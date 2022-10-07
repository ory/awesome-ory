// Copyright © 2022 Ory Corp

import { mount } from "@vue/test-utils"
import NuxtLogo from "@/components/NuxtLogo.vue"

describe("NuxtLogo", () => {
  test("is a Vue instance", () => {
    const wrapper = mount(NuxtLogo)
    expect(wrapper.vm).toBeTruthy()
  })
})
