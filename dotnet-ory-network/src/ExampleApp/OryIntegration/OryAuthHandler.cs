// Copyright © 2026 Ory Corp
// SPDX-License-Identifier: Apache-2.0

using System.Security.Claims;
using System.Text.Encodings.Web;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Ory.Client.Api;

namespace OryIntegration;

internal sealed class OryAuthHandler : AuthenticationHandler<OryAuthSchemeOptions>
{
  private readonly IFrontendApi _ory;

  // ASP.NET Core 8 removed the ISystemClock overload of this constructor in
  // favour of TimeProvider, which the base class resolves for itself. The Ory
  // client is injected rather than constructed here: the SDK is registered with
  // the service collection in Program.cs and comes with its own HttpClient.
  public OryAuthHandler(
      IOptionsMonitor<OryAuthSchemeOptions> options,
      ILoggerFactory logger,
      UrlEncoder encoder,
      IFrontendApi ory)
      : base(options, logger, encoder)
  {
    _ory = ory;
  }

  protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
  {
    try
    {
      var cookie = Request.Headers.Cookie.ToString();
      if (string.IsNullOrWhiteSpace(cookie))
      {
        return AuthenticateResult.NoResult();
      }

      // ToSessionOrDefaultAsync returns null instead of throwing when the
      // session is missing or expired, which is the ordinary case here.
      var response = await _ory.ToSessionOrDefaultAsync(cookie: cookie);
      if (response is null || !response.TryOk(out var session) || session!.Active != true)
      {
        return AuthenticateResult.NoResult();
      }

      var identity = new ClaimsIdentity(new[]
      {
                new Claim(ClaimTypes.NameIdentifier, session.Identity.Id.ToString(), ClaimValueTypes.String, ClaimsIssuer),
                new Claim("urn:ory:id", session.Identity.Id.ToString(), ClaimValueTypes.String, ClaimsIssuer),
                new Claim("urn:ory:schema_id", session.Identity.SchemaId, ClaimValueTypes.String, ClaimsIssuer),
            },
      ClaimsIssuer);

      return AuthenticateResult.Success(
          new AuthenticationTicket(new ClaimsPrincipal(identity), Scheme.Name));
    }
    catch (Exception e)
    {
      return AuthenticateResult.Fail(e);
    }
  }
}
