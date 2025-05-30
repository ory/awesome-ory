// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Ory.Client.Api;

namespace ExampleApp.Controllers;

public class HomeController : Controller
{
  private readonly IFrontendApiAsync _ory;

  public HomeController(IFrontendApiAsync ory)
  {
    _ory = ory;
  }

  public IActionResult Index() => View();

  public async Task<IActionResult> Signup()
  {
    var flow = await _ory.CreateBrowserRegistrationFlowAsync();
    return Redirect(flow.RequestUrl);
  }

  public async Task<IActionResult> Login()
  {
    var flow = await _ory.CreateBrowserLoginFlowAsync();
    return Redirect(flow.RequestUrl);
  }

  public async Task<IActionResult> Logout()
  {
    var flow = await _ory.CreateBrowserLogoutFlowAsync(Request.Headers["cookie"]);
    return Redirect(flow.LogoutUrl);
  }

  [Authorize]
  public IActionResult IdentityInfo() => View();
}
