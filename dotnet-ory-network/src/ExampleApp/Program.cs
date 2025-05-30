// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

using Ory.Client.Api;
using OryIntegration;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews();

// Integrate Ory Network

var oryBasePath = builder.Configuration.GetValue<string>("ORY_BASEPATH") ?? "http://localhost:4000";

builder.Services.AddSingleton<IFrontendApiAsync>(_ => new FrontendApi(oryBasePath));

builder.Services.AddAuthentication(opt =>
{
  opt.DefaultAuthenticateScheme = OryDefaults.AuthenticationScheme;
}).AddOry(o =>
{
  o.BasePath = oryBasePath;
});

// Build request pipeline

var app = builder.Build();

app.UseStatusCodePages();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
