// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import { test, expect, Page } from "@playwright/test"
import { randomEmail, randomString } from "./helpers"

const url = "http://localhost:5286/"

const signup = async (page: Page) => {
  const email = randomEmail()
  const password = randomString()
  await page.fill('[name="traits.email"]', email)
  await page.fill('[name="password"]', password)
  await page.click('[value="password"]')
  return { email, password }
}

const check_session = async (page: Page) => {
  await page.goto(`${url}Home/IdentityInfo`)
  expect(page.locator("text=You are authenticated")).toBeVisible()
}

test.describe("dotnet-ory-network", () => {
  test("sign up, check session and logout", async ({ page }) => {
    await page.goto(url, { waitUntil: "networkidle" })
    await page.locator("text=Sign up").click()
    await expect(page).toHaveURL(/.*\/ui\/registration.*/)
    const credentials = await signup(page)
    await expect(page).toHaveURL(`${url}`)
    await check_session(page)
    await page.locator("text=Log out").click()
    await expect(page).toHaveURL(`${url}`)
  })
})
