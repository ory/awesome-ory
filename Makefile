format: .bin/ory node_modules  # formats the source code
	.bin/ory dev headers copyright --type=open-source
	npm exec -- prettier --write .
	(cd django-ory-cloud && make --no-print-dir format)
	(cd dotnet-ory-network && make --no-print-dir format)

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
