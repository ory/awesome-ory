// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

using System;
using Microsoft.AspNetCore.Authentication;

namespace OryIntegration;

/// <summary>
/// Extension methods to configure Ory authentication.
/// </summary>
public static class AuthenticationBuilderExtensions
{
  /// <summary>
  /// Adds Ory cookie-based authentication to <see cref="AuthenticationBuilder"/> using the default scheme.
  /// The default scheme is specified by <see cref="OryDefaults.AuthenticationScheme"/>.
  /// <para>
  /// Ory authentication allows application users to sign in with their Ory Network account.
  /// </para>
  /// </summary>
  /// <param name="builder">The <see cref="AuthenticationBuilder"/>.</param>
  /// <param name="configureOptions">A delegate to configure <see cref="OryAuthSchemeOptions"/>.</param>
  /// <returns>A reference to <paramref name="builder"/> after the operation has completed.</returns>
  public static AuthenticationBuilder AddOry(this AuthenticationBuilder builder, Action<OryAuthSchemeOptions>? configureOptions = null)
  {

    builder.AddScheme<OryAuthSchemeOptions, OryAuthHandler>(OryDefaults.AuthenticationScheme, configureOptions);

    return builder;
  }
}
