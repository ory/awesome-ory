// Copyright © 2022 Ory Corp
// SPDX-License-Identifier: Apache-2.0

export const state = () => ({
  session: {},
  authenticated: false,
  logoutUrl: "",
})

export const mutations = {
  setSession(state, session) {
    state.session = session
  },
  setAuthenticated(state, authenticated) {
    state.authenticated = authenticated
  },
  setLogoutURL(state, logoutURL) {
    state.logoutURL = logoutURL
  },
}
