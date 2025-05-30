// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

using System.Security.Claims;
using System.Text.Encodings.Web;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Ory.Client.Api;
using Ory.Client.Client;

namespace OryIntegration;

internal sealed class OryAuthHandler : AuthenticationHandler<OryAuthSchemeOptions>
{
  private IFrontendApiAsync Api => new FrontendApi(new Configuration()
  {
    BasePath = Options.BasePath
  });

  public OryAuthHandler(IOptionsMonitor<OryAuthSchemeOptions> options, ILoggerFactory logger, UrlEncoder encoder, ISystemClock clock)
      : base(options, logger, encoder, clock)
  { }

  protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
  {
    try
    {
      var cookie = Request.Headers["cookie"];
      if (string.IsNullOrWhiteSpace(cookie))
      {
        return AuthenticateResult.NoResult();
      }

      var session = await Api.ToSessionAsync(cookie: cookie);
      if (session is null)
      {
        return AuthenticateResult.Fail("Could not decode session cookie");
      }

      var identity = new ClaimsIdentity(new[]
      {
                new Claim(ClaimTypes.NameIdentifier, session.Identity.Id, ClaimValueTypes.String, ClaimsIssuer),
                new Claim("urn:ory:id", session.Identity.Id, ClaimValueTypes.String, ClaimsIssuer),
                new Claim("urn:ory:schema_url", session.Identity.SchemaUrl, ClaimValueTypes.String, ClaimsIssuer),
                new Claim("urn:ory:schema_id", session.Identity.SchemaId, ClaimValueTypes.String, ClaimsIssuer),
                // TODO: translate session props to claims
            },
      ClaimsIssuer);

      return AuthenticateResult.Success(new AuthenticationTicket(new ClaimsPrincipal(identity), new()
      {
        IssuedUtc = session.IssuedAt.ToUniversalTime(),
        ExpiresUtc = session.ExpiresAt.ToUniversalTime()
      }, Scheme.Name));
    }
    catch (Exception e)
    {
      return AuthenticateResult.Fail(e);
    }
  }
}
