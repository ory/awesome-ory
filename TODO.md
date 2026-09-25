# Known follow-ups

Work that is understood but not done. `AGENTS.md` describes how to run a
maintenance pass; this file is the backlog that a pass can pull from when
nothing is red.

Each item says what is wrong, why it matters, and where to start. Delete an item
when it is done — a stale backlog is worse than none. If an item turns out to
need a decision that is not yours, say so here rather than guessing.

## Blocking a version bump

### Flutter is pinned to 3.35.7 because 3.44 does not build

`flutter-ory-network/Makefile` pins the container image. On 3.44 the **Flutter
framework's own** `painting` library fails to compile — `star_border.dart` cannot
resolve `Matrix4`, and `_network_image_io.dart` rejects a `const MapEquality()` —
against the `collection` version pub resolves for this project. Constraining
`collection` to `^1.20.0` makes version solving fail outright.

So the project is stuck a major Flutter version back, and will drift further.
Start by working out which dependency caps `collection` at 1.19.x
(`flutter pub deps --style=compact`), since that is the likely root cause.

### The Android toolchain will not build under current Flutter

`flutter-ory-network/android/` still has AGP 7.3.0, Kotlin 1.7.10,
`minSdkVersion 19`, Java 8, and `apply from: "$flutterRoot/.../flutter.gradle"` —
the legacy script-apply that current Flutter replaced with the declarative
`plugins {}` block in `settings.gradle`.

Nothing catches this today because the test suite is `flutter test`, which does
not touch Gradle. Adding `flutter build apk --debug` to `make test` would catch
it, but only after the toolchain is fixed. Related: `ios/Podfile` has its
`platform :ios, '13.0'` line commented out.

## Test coverage gaps

### Only one of the five Flutter blocs is tested

`test/login_bloc_test.dart` covers `LoginBloc`. `lib/blocs/` also has `auth`,
`registration`, `settings` and `bloc` (recovery). They take their repository by
injection exactly as `LoginBloc` does, so the same `bloc_test` + `mocktail`
pattern applies directly — this is mechanical, not hard.

### Complete the Ory Network integration before adding its test lane

Ory Network support is deferred; the Django and .NET examples currently target
self-hosted Kratos. Changing an SDK URL to point at a tunnel is not sufficient.

- Django's `ory_auth/middleware.py` and `ory_auth/context.py` hardcode
  `ory_kratos_session`. Network uses `ory_session_<slug>`, so the middleware
  currently treats Network users as anonymous and cannot create their logout
  flows. Forward the incoming cookie header for session and logout requests,
  and test both cookie naming schemes.
- For both apps, configure and verify the SDK address, browser-facing flow URLs,
  cookie domain, and allowed return URLs against an Ory Network project.
  .NET's `ORY_BROWSER_URL` is separate from its internal `ORY_BASEPATH`.
- Add credentialed `make test-network` lanes that exercise registration, login,
  session resolution, and logout, and remove the identities they create.
  `oathkeeper/10-network/test-network.sh` provides a starting point, but its
  identity cleanup also needs implementing before reusing it unattended.

Keep the default test suite credential-free. Do not describe either app's
Network integration as working until those flows have been verified.

### `AGENTS.md` has never had a cold run

The real test of it is a fresh session given only that file: can it pick up the
next item and land a correct change without asking anything? Anything it has to
ask belongs in the file.

## Correctness and tidiness

### `oathkeeper/10-network` runs a hydrator nothing uses

The compose file builds and starts the `hydrator` service, but the access rule
lists only the `header` mutator, so it is never called. Either wire it into the
rule — which would make 10 demonstrate the same thing as 04, against Ory Network
— or drop the service. Worth deciding rather than leaving ambiguous.

### `ory-actions/vpncheck-py` triplicates its logic

`focsec.py`, `ipqs.py` and `vpnapi.py` are the same webhook against three
vendors, with the bearer check, the Ory error envelope and the fail-open path
copy-pasted. A shared module with a per-vendor `query_*` and rule set would make
the vendor differences legible instead of hiding them in the noise.

There is a visible symptom of the copy-paste: `focsec.py:88` raises
`f"vpnapi.io returned {response.status_code}"` from the **focsec** code path.

### The courier points at a service behind a profile

`_common/kratos/kratos.yml` sets `connection_uri: smtp://mailpit:1025/...`, but
`mailpit` only starts under the `ui` profile. Without it Kratos logs courier
delivery failures — harmless, because nothing in the test suite needs mail, but
noisy and confusing when reading logs. Either move the courier config behind the
profile too, or accept it and say so in `_common/README.md`.

### The licenses report only knows about the root package

`.reports/dep-licenses.csv` lists exactly one module, `awesome-ory@1.0.0`, which
is the root `package.json` holding prettier. Now that the examples have real
Python, .NET, Dart and Go dependency sets, `licenses.yml` is reporting on
almost nothing. Check whether `ory/ci`'s licenses tooling is meant to cover the
subprojects here, or whether this report is simply not meaningful for this repo.

### Django's base template references static files that may not exist

`django-ory-cloud/mysite/templates/base.html` loads `js/vendors.min.js`,
`js/project.js`, `css/project.css` and a favicon via `{% static %}`. Django does
not verify these at render time, so the page works, but they are probably 404ing
in the browser. Either add them or remove the tags.

### One .NET nullability warning

`dotnet-ory-network/src/ExampleApp/Views/Shared/_Layout.cshtml(35,47)`: CS8602,
dereference of a possibly null reference. Harmless, but it is the only warning in
an otherwise clean build.
