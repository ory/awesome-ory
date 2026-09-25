// Copyright © 2026 Ory Corp
// SPDX-License-Identifier: Apache-2.0

using Ory.Client.Client;
using Ory.Client.Extensions;
using OryIntegration;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews();

// Integrate self-hosted Ory Kratos

var oryBasePath = builder.Configuration.GetValue<string>("ORY_BASEPATH") ?? "http://127.0.0.1:4433";

// The Ory SDK registers itself with the service collection and brings its own
// HttpClient; the APIs are then injected where they are needed.
builder.Host.ConfigureApi((context, services, options) =>
{
  options.AddApiHttpClients(client => client.BaseAddress = new Uri(oryBasePath));

  // The generated client resolves a provider for every auth scheme in the Ory
  // API description, so all three have to be registered even though the browser
  // flows this app uses authenticate with the visitor's own session cookie.
  options.AddTokens(new BearerToken(string.Empty));
  options.AddTokens(new BasicToken(string.Empty, string.Empty));
  options.AddTokens(new OAuthToken(string.Empty));
});

builder.Services.AddAuthentication(opt =>
{
  opt.DefaultAuthenticateScheme = OryDefaults.AuthenticationScheme;
  opt.DefaultChallengeScheme = OryDefaults.AuthenticationScheme;
}).AddOry(o =>
{
  o.BasePath = oryBasePath;
});

// Build request pipeline

var app = builder.Build();

app.UseStatusCodePages();

app.UseRouting();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
