// Copyright © 2026 Ory Corp
// SPDX-License-Identifier: Apache-2.0

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Ory.Client.Api;

namespace ExampleApp.Controllers;

public class HomeController : Controller
{
  private readonly IFrontendApi _ory;
  private readonly Uri _oryBrowserUrl;

  public HomeController(IFrontendApi ory, IConfiguration configuration)
  {
    _ory = ory;
    _oryBrowserUrl = new Uri(
        (configuration["ORY_BROWSER_URL"] ?? "http://127.0.0.1:4433").TrimEnd('/') + "/");
  }

  public IActionResult Index() => View();

  // Initialise the flow in the browser so Kratos can set its CSRF cookie.
  // The SDK's internal address (e.g. http://kratos:4433) is not browser-facing.
  public IActionResult Signup() =>
      Redirect(new Uri(_oryBrowserUrl, "self-service/registration/browser").AbsoluteUri);

  public IActionResult Login() =>
      Redirect(new Uri(_oryBrowserUrl, "self-service/login/browser").AbsoluteUri);

  public async Task<IActionResult> Logout()
  {
    var flow = (await _ory.CreateBrowserLogoutFlowAsync(Request.Headers.Cookie.ToString())).Ok();
    return Redirect(flow.LogoutUrl);
  }

  [Authorize]
  public IActionResult IdentityInfo() => View();
}
