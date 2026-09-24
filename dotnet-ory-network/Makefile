IMAGE_NAME=dotnet-ory-network-example

format:
	docker run --rm -u "$$(id -u):$$(id -g)" -v "$$(pwd):/work" --tmpfs /.dotnet --tmpfs /.nuget --tmpfs /.local mcr.microsoft.com/dotnet/sdk:10.0 dotnet format /work/src/

.PHONY: test
test:
	../_common/smoke.sh .
