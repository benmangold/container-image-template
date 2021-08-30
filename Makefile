# Makefile targets for building and testing container image with Docker, Dive, Goss and Snyk

ci: install build-image test-goss test-dive test-snyk

install: install-goss install-dive install-snyk

install-goss:
	./scripts/install-goss.sh

install-dive:
	./scripts/install-dive.sh

install-snyk:
	./scripts/install-snyk.sh

build-image:
	docker build -t test .

test-goss:
	GOSS_PATH=$$PWD/goss ./dgoss run test

test-dive:
	CI=true dive test

test-snyk:
	./snyk container test test --file=Dockerfile --severity-threshold=high
