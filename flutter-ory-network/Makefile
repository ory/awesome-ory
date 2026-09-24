# Flutter is run from a container so the test suite does not depend on whatever
# Flutter happens to be installed on the machine. The version is pinned because
# this project does not yet build on 3.44 — see TODO.md before bumping it.
FLUTTER_IMAGE := ghcr.io/cirruslabs/flutter:3.35.7
PUB_CACHE_VOLUME := awesome-ory-flutter-pub-cache

FLUTTER := docker run --rm \
	-v "$(CURDIR)":/app \
	-v $(PUB_CACHE_VOLUME):/pub-cache \
	-w /app -e PUB_CACHE=/pub-cache \
	$(FLUTTER_IMAGE) sh -c

# .env is gitignored but declared as a bundled asset, so the build needs one to
# exist. The values only matter when the app actually talks to Ory.
.env:
	cp .env.example .env

.PHONY: test
test: .env
	@$(FLUTTER) 'git config --global --add safe.directory /sdks/flutter >/dev/null 2>&1; \
		flutter pub get >/dev/null && flutter test'

.PHONY: analyze
analyze: .env
	@$(FLUTTER) 'git config --global --add safe.directory /sdks/flutter >/dev/null 2>&1; \
		flutter pub get >/dev/null && flutter analyze'
