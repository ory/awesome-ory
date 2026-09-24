# Flutter is run from a container so the test suite does not depend on whatever
# Flutter happens to be installed on the machine. The version is pinned: this
# project does not yet build on Flutter 3.44, where the framework's own painting
# library fails to compile against the collection version pub resolves here.
FLUTTER_IMAGE := ghcr.io/cirruslabs/flutter:3.35.7
PUB_CACHE_VOLUME := awesome-ory-flutter-pub-cache

FLUTTER := docker run --rm \
	-v "$(CURDIR)":/app \
	-v $(PUB_CACHE_VOLUME):/pub-cache \
	-w /app -e PUB_CACHE=/pub-cache \
	$(FLUTTER_IMAGE) sh -c

.PHONY: test
test:
	@$(FLUTTER) 'git config --global --add safe.directory /sdks/flutter >/dev/null 2>&1; \
		flutter pub get >/dev/null && flutter test'

.PHONY: analyze
analyze:
	@$(FLUTTER) 'git config --global --add safe.directory /sdks/flutter >/dev/null 2>&1; \
		flutter pub get >/dev/null && flutter analyze'
