REPO := ocpu/pg_repack

1.4.8: VERSION=1.4.8
1.4.8: PG_VERSION=15
1.4.8: get-zip build

1.4.7: VERSION=1.4.7
1.4.7: PG_VERSION=14
1.4.7: get-zip build

1.4.6: VERSION=1.4.6
1.4.6: PG_VERSION=13
1.4.6: get-zip build

1.4.5: VERSION=1.4.5
1.4.5: PG_VERSION=12
1.4.5: get-zip build

1.4.4: VERSION=1.4.4
1.4.4: PG_VERSION=11
1.4.4: get-zip build

1.4.3: VERSION=1.4.3
1.4.3: PG_VERSION=10
1.4.3: get-zip build

get-zip:
	test -f pg_repack-$(VERSION).zip || wget https://api.pgxn.org/dist/pg_repack/$(VERSION)/pg_repack-$(VERSION).zip

build:
	docker build -t $(REPO):$(VERSION) --build-arg=VERSION=$(VERSION) --build-arg=PG_VERSION=$(PG_VERSION) .

clean:
	rm pg_repack-*
