// Copyright © 2026 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import { Namespace } from "@ory/permission-namespace-types";

class User implements Namespace {}

class app implements Namespace {
  related: {
    read: User[];
  };
}
