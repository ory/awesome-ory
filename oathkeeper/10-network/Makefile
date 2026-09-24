# 10-network is the one example that cannot run against self-hosted Ory: its
# whole point is the Ory tunnel in front of an Ory Network project. The default
# target therefore skips rather than fails, so a full `make test` from the repo
# root stays green without credentials.
.PHONY: test test-network
test:
	@echo "skip: 10-network needs an Ory Network project — run 'make test-network'"

test-network:
	./test-network.sh
