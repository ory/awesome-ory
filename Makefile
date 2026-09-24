# Every project in this list has a Makefile with a `test` target that provisions
# what it needs, asserts, and cleans up after itself — with no credentials. That
# is the contract; see AGENTS.md.
PROJECTS := \
	oathkeeper/01-basic \
	oathkeeper/02-authenticators \
	oathkeeper/03-header-mutator \
	oathkeeper/04-hydrator-mutator \
	oathkeeper/05-nginx-oathkeeper \
	oathkeeper/06-nginx-hydrator \
	oathkeeper/07-traefik-decision \
	oathkeeper/08-envoy-header \
	oathkeeper/09-oathkeeper-websockets \
	oathkeeper/10-network \
	oathkeeper/11-kratos-keto \
	oathkeeper/12-multiple-authenticators \
	kratos-oathkeeper-kong \
	kratos-keto-flask \
	django-ory-cloud \
	dotnet-ory-network \
	ory-actions/vpncheck-py

# The examples bind the same ports and the same Docker resources, so the suite
# is serial by design. `make -j` is not supported.
.NOTPARALLEL:

.PHONY: test
test: $(addprefix test-,$(PROJECTS))  # runs the whole suite; the default gate

.PHONY: test-%
test-%:
	@$(MAKE) --no-print-directory -C $* test

.PHONY: test-network
test-network:  # the credentialed lane; skips loudly when no project is configured
	@$(MAKE) --no-print-directory -C oathkeeper/10-network test-network

.PHONY: health
health:  # runs everything, tolerates failures, and records the result
	@./_common/health.sh $(PROJECTS)

format: .bin/ory node_modules  # formats the source code
	.bin/ory dev headers copyright --type=open-source
	npm exec -- prettier --write .

licenses: .bin/licenses node_modules  # checks open-source licenses
	.bin/licenses

.bin/licenses: Makefile
	curl https://raw.githubusercontent.com/ory/ci/master/licenses/install | sh

.bin/ory: Makefile
	curl https://raw.githubusercontent.com/ory/meta/master/install.sh | bash -s -- -b .bin ory v0.1.48
	touch .bin/ory

node_modules: package-lock.json
	npm ci
	touch node_modules
