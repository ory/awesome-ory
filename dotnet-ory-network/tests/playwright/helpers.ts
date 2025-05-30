// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

export const randomString = () =>
  Math.random().toString(36).substring(2, 15) +
  Math.random().toString(36).substring(2, 15)

export const randomEmail = () => randomString() + "@" + randomString() + ".dev"
