import { Namespace } from "@ory/permission-namespace-types"

class User implements Namespace {}

class services implements Namespace {
  related: {
    access: User[]
  }
}
