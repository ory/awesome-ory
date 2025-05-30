// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

using Microsoft.AspNetCore.Authentication;

namespace OryIntegration;

/// <summary>
/// Configuration options for <see cref="OryAuthHandler"/>.
/// </summary>
public sealed class OryAuthSchemeOptions : AuthenticationSchemeOptions
{
  /// <summary>
  /// The base path of the Ory API Endpoint.
  /// </summary>
  public string? BasePath { get; set; }
}
