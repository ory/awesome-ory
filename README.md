# Awesome Ory

[<img src="./assets/logo512.png" align="right" width="256">](https://ory.sh/)

An awesome list of the [Ory ecosystem](https://github.com/ory/). Ory provides scalable, flexible, and secure identity and access management (IAM) solutions that empower developers to build innovative applications. Whether you handle billions of users or launch a startup, Ory makes security and compliance simple with open-source transparency and cutting-edge tools.

[![Docs](https://img.shields.io/badge/docs-ory.sh-%233B4B6C "Ory Documentation")](https://ory.sh/docs)
[![Docs](https://img.shields.io/badge/chat-slack.ory.sh-%234B1B6C "Ory Community Slack")](https://slack.ory.sh/)

If you have any questions or suggestions [open a discussion](https://github.com/ory/examples/discussions), or join the [Ory Chat](https://slack.ory.sh/)!

See [CONTRIBUTING.md](CONTRIBUTING.md) for pointers on how to contribute.

## Contents

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Ecosystem](#ecosystem)
- [Developer resources](#developer-resources)
- [Blog posts](#blog-posts)
  - [Ory blog guest articles](#ory-blog-guest-articles)
  - [Ory ecosystem](#ory-ecosystem)
  - [Ory Kratos](#ory-kratos)
  - [Ory Hydra](#ory-hydra)
  - [Ory Keto](#ory-keto)
  - [Ory Oathkeepeer](#ory-oathkeepeer)
  - [Ory Dockertest](#ory-dockertest)
- [Videos](#videos)
- [Examples](#examples)
  - [Ory Ecosystem](#ory-ecosystem)
  - [Ory Kratos](#ory-kratos-1)
  - [Ory Hydra](#ory-hydra-1)
- [Projects](#projects)
  - [Ory Ecosystem](#ory-ecosystem-1)
  - [Ory Kratos](#ory-kratos-2)
  - [Ory Hydra](#ory-hydra-2)
  - [Ory Keto](#ory-keto-1)
  - [Ory Oathkeeper](#ory-oathkeeper)
  - [Ory Fosite](#ory-fosite)
- [Services](#services)
- [Postman collections](#postman-collections)
- [Archive](#archive)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Ecosystem

Overview of the main projects in the Ory ecosystem.

- [Ory Network](https://console.ory.sh/)
- [Ory Hydra](https://github.com/ory/hydra)
- [Ory Kratos](https://github.com/ory/kratos)
- [Ory Keto](https://github.com/ory/keto)
- [Ory Oathkeeper](https://github.com/ory/oathkeeper)
- [Ory Fosite](https://github.com/ory/fosite)
- [Ory Dockertest](https://github.com/ory/dockertest)
- [Other Ory projects can be found here](https://github.com/ory)

## Developer resources

Developer resources and forums for discussing Ory and meeting other users

- [Ory Documentation](https://www.ory.sh/docs) - Comprehensive documentation for major Ory services
- [Ory Slack](https://slack.ory.sh) - Slack community for the Ory ecosystem
- [Ory Archive](https://archive.ory.sh) - Searchable archive of the Ory Slack community
- [GitHub Discussions](https://github.com/discussions?discussions_q=org%3Aory+sort%3Aupdated-desc) - All discussions for Ory services on GitHub
- [StackOverflow](https://stackoverflow.com/questions/tagged/ory) - StackOverflow questions tagged with `ory`
- [Twitter](https://twitter.com/orycorp) - Official Ory Twitter account

- Ory Support 👉 [Enterprise-grade support directly from the Ory maintainers](https://ory.sh/contact) ✨

## Blog posts

### Ory blog guest articles

> Are you building something with Ory?
> Are you interested in Auth and security topics in general?
> Do you want to share your knowledge and experience?
> [Reach out](mailto:office@ory.sh) to get published in the Ory blog!

- [Deploying Ory Oathkeeper as an AWS Lambda Authorizer](https://www.ory.sh/deploying-ory-oathkeeper-aws-lambda/)
- [Using Ory with Cloudflare Workers](https://www.ory.sh/use-ory-with-cloudflare-workers/)
- [How I built LoginWithHN using Ory Hydra](https://www.ory.sh/how-to-build-login-with-hacker-news/)
- [Add Authentication to your Flutter Web Applications with Ory Kratos](https://www.ory.sh/login-flutter-authentication-example-api-open-source/)
- [Looking at Zanzibar through Ory Keto](https://www.ory.sh/looking-at-keto/)

### Ory ecosystem

- [Authentication Infrastructure – Using Ory Stack (Ory Kratos, Ory Hydra)](https://neutronxinnovation.com/blog/2025/01/23/authentication-infrastructure-using-ory-stack/)
- [Open Source Authentication with Hydra and Kratos](https://blog.px.dev/open-source-auth/)

### Ory Kratos

- [Building a Quarkus application with Ory Kratos](https://hauke.me/writing/2021-03-building-a-quarkus-application-with-ory-kratos/)
- [How to write an application that integrates Kratos in Go](https://stories.abletech.nz/integrating-third-party-provider-kratos-f5514b53af66)
- [Ory Kratos reverse proxy (Nginx) example](https://github.com/ory/kratos/discussions/1049)

### Ory Hydra

- [Ory Hydra with Apache APISIX integration](https://apisix.apache.org/blog/2022/07/04/apisix-integrates-with-hydra/)
- [Practical Example of Implementing OAuth 2.0 Using ory/hydra](https://yusufs.medium.com/practical-example-of-implementing-oauth-2-0-using-ory-hydra-fbaa2765d94f)
- OAuth 2.0 with Ory Hydra and Vapor on iOS:
  [Part 1](https://medium.com/12plus1/oauth2-with-ory-hydra-vapor-3-and-ios-12-ca0e61c28f5a),
  [Part 2](https://medium.com/12plus1/oauth2-implementation-with-ory-hydra-vapor-3-and-ios-12-a2e6684e5085),
  [Part 3](https://medium.com/12plus1/oauth2-implementation-with-ory-hydra-vapor-3-and-ios-12-356793a0edcb),
  [Part 4](https://medium.com/12plus1/oauth2-implementation-with-ory-hydra-vapor-3-and-ios-12-4b34fa67d6).
- [Creating an OAuth 2.0 custom lambda authorizer for use with Amazons (AWS) API Gateway using Hydra](https://blogs.edwardwilde.com/2017/01/12/creating-an-oauth2-custom-lamda-authorizer-for-use-with-amazons-aws-api-gateway-using-hydra/)

### Ory Keto

- [Looking at Zanzibar through Ory Keto](https://gruchalski.com/posts/2021-04-11-looking-at-zanzibar-through-ory-keto/)

### Ory Oathkeepeer

- [API Access Control with Ambassador and Ory Oathkeeper](https://blog.getambassador.io/part-2-api-access-control-and-authentication-with-kubernetes-ambassador-and-ory-oathkeeper-q-a-127fa57f6332?utm_content=76739953&utm_medium=social&utm_source=twitter)
- [Ory Oathkeeper Istio best practices/reference configuration](https://github.com/ory/oathkeeper/issues/624)

### Ory Dockertest

- [Writing Tests for MongoDB using Dockertest in Go](https://mainawycliffe.dev/blog/using-dockertest-to-write-integration-tests-against-mongodb/)
- [Integration tests in Golang with dockertest](https://sergiocarracedo.es/integration-tests-in-golang-with-dockertest/)
- [Go Package for better integration tests: Ory Dockertest](https://mariocarrion.com/2021/03/14/golang-package-testing-datastores-ory-dockertest.html)
- [Using Dockertest with Golang](https://bignerdranch.com/blog/using-dockertest-with-golang/)
- [How to write a Go API Part 3: Testing With Dockertest](https://jonnylangefeld.com/blog/how-to-write-a-go-api-part-3-testing-with-dockertest)

## Videos

- [Ory selfhosted introduction course](https://youtu.be/Cptnv7ZaFY8)
- [Ory Kratos & Ory Hydra integration guide](https://youtu.be/F6ZKrxf8LuQ)

## Examples

Code examples that show how to integrate Ory with a framework, software stack, or how to solve a specific use case.

### Ory Ecosystem

- [Microservices app using Ory, NestJS, Kubernetes](https://github.com/getlarge/ticketing)
- [Selfhosted admin frontend in ASP.net](https://github.com/josxha/OryUI)
- [Next.js based starter for Ory Kratos and Ory Hydra](https://github.com/markusthielker/next-ory)
- [APISIX as gateway with Ory, linkerd, and kustomize](https://github.com/iverly/kube-apisix-linkerd-ory-kustomize)
- [Ory Kratos & Oathkeeper with Kong, docker-compose](https://github.com/Pterygoidien/Kong-Ory-Microservices)
- [Ory Kratos, Keto, Oathkeeper Kubernetes example](https://github.com/pngouin/k8s-ory-example)

### Ory Kratos

- [Ory Kratos Nuxt example](https://github.com/khusseini/nuxt-kratos-selfservice)
- [Ory Kratos Sveltekit with MeltUI and TailwindCSS example](https://github.com/karlis-vagalis/kratos-selfservice)
- [Ory Kratos for Plug apps example](https://github.com/ScoreVision/kratos_plug)
- [Ory Kratos Svelte Node example](https://github.com/emrahcom/kratos-selfservice-svelte-node)
- [Ory Kratos SvelteKit example](https://github.com/bessey/ory-kratos-sveltekit-demo)
- [Ory Kratos Admin Interface in React example](https://github.com/dfoxg/kratos-admin-ui)
- [Ory Kratos Admin Interface with analytics](https://github.com/dhia-gharsallaoui/kratos-admin-ui)
- [Ory Kratos SPA Self-service UI written in the Dioxus rust framework (WASM)](https://github.com/justins-engineering/kratos-selfservice-wasm)

### Ory Hydra

- [Ory Hydra Web3 Authentication incl. Metamask, Coinbase, Walletconnect example](https://github.com/MetaWarrior-Army/mwa-auth)
- [Ory Hydra Java identity provider example](https://github.com/ardetrick/ory-hydra-refrence-java)
- [Ory Hydra Golang identity provider example](https://github.com/M3ikShizuka/service-account)
- [Ory Hydra client integrations with OAuth2.0 & OIDC example](https://github.com/shauryadhadwal/oauth2-oidc-client-integrations)
- [Ory Hydra PKCE & Spring Boot 2 example](https://github.com/Chistousov/ORY-Hydra-OAuth2.0-Example)

## Projects

Community projects, configuration tools, or development helpers extending Ory services.

### Ory Ecosystem

- [Ory Plugin for HashiCorp Vault](https://github.com/comnoco/vault-plugin-auth-ory)
- [Libraries to integrate NestJS with Ory](https://github.com/getlarge/nestjs-ory-integration)

### Ory Kratos

- [Ory Kratos Symfony Authenticator](https://github.com/stethome/ory-auth-bundle)
- [Ory Kratos Loopback4 integration](https://github.com/giuseppegrieco/loopback4-kratos)
- [Ory Kratos read-only traits](https://github.com/lus/kratos-readonly-traits)
- [Ory Kratos Client Rust WASM](https://github.com/justins-engineering/kratos-client-rust)

### Ory Hydra

- [Ory Hydra Testcontainer](https://github.com/ardetrick/testcontainers-ory-hydra)
- [Ory Hydra Golang HTTP middleware](https://github.com/ngyewch/hydra-login-consent)
- [Ory Hydra OAuth2 Token Exchange RFC 8693](https://github.com/Exact-Realty/ts-hydra-rfc8693)
- [Ory Hydra Terraform Provider](https://github.com/svrakitin/terraform-provider-hydra)

### Ory Keto

- [Ory Keto Terraform provider](https://github.com/76creates/terraform-provider-oryketo/)

### Ory Oathkeeper

- [CLI to create Ory Oathkeeper rules from OpenAPI spec](https://github.com/cerberauth/openapi-oathkeeper)

### Ory Fosite

- [MongoDB storage for Ory Fosite](https://github.com/matthewhartstonge/storage)
- [Argon2 Hasher for Ory Fosite](https://github.com/matthewhartstonge/hasher)

## Services

Managed services that run Ory for you

- [Ory Network](https://console.ory.sh) - Self-service managed IAM service operated by Ory
- [Ory Enterprise License](https://www.ory.sh/docs/self-hosted/oel/quickstart) - Private, compliant, and enterprise-grade version of Ory

## Postman collections

- [Ory Postman Public Workspace](https://www.postman.com/ory-docs)

The API Collections are built directly from the swagger specification (you can find it at the path `/spec/api.json` in GitHub) and
are organized into folders that categorize the various API calls. To be able to work with the collection you need to set the
`baseURl` variable. For example, when running Ory Kratos the `baseURl` needs to be set to the public endpoint. You may also have
to configure query parameters or the JSON method body, depending on the API call.

> Note that while the collections should be up to date, please open an issue here if that's not the case.

> Don't store tokens in Postman as environment variables! If you are signed in to the Postman application, it will automatically try to synchronize Collections and Environments with the Postman servers. This means that a token, which could allow someone else access to your APIs, is being uploaded to Postman's servers. Postman has taken measures to ensure that tokens are encrypted and encourages users to store them in Environment Variables. Read more [here](https://www.postman.com/security).

## Archive

You can find old, archived, outdated, or incomplete projects in [ARCHIVE.md](./ARCHIVE.md)
