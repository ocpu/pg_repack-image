REPO := ocpu/pg_repack

1.5.1: VERSION=1.5.1
1.5.1: PG_VERSION=17
1.5.1: build

1.5.0: VERSION=1.5.0
1.5.0: PG_VERSION=16
1.5.0: build

1.4.8: VERSION=1.4.8
1.4.8: PG_VERSION=15
1.4.8: build

1.4.7: VERSION=1.4.7
1.4.7: PG_VERSION=14
1.4.7: build

1.4.6: VERSION=1.4.6
1.4.6: PG_VERSION=13
1.4.6: build

1.4.5: VERSION=1.4.5
1.4.5: PG_VERSION=12
1.4.5: build

1.4.4: VERSION=1.4.4
1.4.4: PG_VERSION=11
1.4.4: build

1.4.3: VERSION=1.4.3
1.4.3: PG_VERSION=10
1.4.3: build

build:
	docker build --network host -t $(REPO):$(VERSION) --build-arg=VERSION=$(VERSION) --build-arg=PG_VERSION=$(PG_VERSION) .

clean:
	rm pg_repack-*
