NAME := ghc
REVISION := $(shell git rev-parse --short HEAD)
VERSION = $(shell grep 'Version string =' cmd/version.go | sed -E 's/.*"(.+)"$$/\1/')
LDFLAGS = -X 'cmd.Version=$(VERSION)' \
          -X 'github.com/masa0x80/ghc/cmd.Revision=$(REVISION)'

setup:
	go get github.com/Masterminds/glide
	go get golang.org/x/tools/cmd/goimports
	go get github.com/golang/lint/golint

test: deps
	go test $$(glide novendor)

deps: setup
	glide install

update: setup
	glide update

lint: setup
	go vet $$(glide novendor)
	for pkg in $$(glide novendor -x); do \
		golint -set_exit_status $$pkg || exit $$?; \
	done

fmt: setup
	goimports -w $$(glide nv -x)

bin/%: . deps
	go build -ldflags "$(LDFLAGS)" -o $@ $<

.PHONY: setup deps update test lint fmt build
