SOURCE_DOCS_MD := $(wildcard *.md)
SOURCE_DOCS_TEX := $(wildcard *.tex)

all: $(SOURCE_DOCS_TEX) $(SOURCE_DOCS_MD)
	docker run -it --mount src=$(shell pwd),target=/mnt,type=bind pandoc-bickham /bin/sh -c 'cd /mnt && make --file /docker-makefile'

clean:
	docker run -it --mount src=$(shell pwd),target=/mnt,type=bind pandoc-bickham /bin/sh -c 'cd /mnt && make --file /docker-makefile clean'

image: Dockerfile
	docker build --tag 'pandoc-bickham:latest' .

install: image
	mkdir -p /usr/local/bin
	mkdir -p /usr/local/etc
	cp pandoc-make /usr/local/bin/pandoc-make
	ln -s /usr/local/bin/pandoc-make /usr/local/bin/pdmake
	cp makefile /usr/local/etc/pandoc-bickham-makefile
	chmod +x /usr/local/bin/pandoc-make
	chmod +x /usr/local/bin/pdmake

uninstall:
	$(RM) /usr/local/bin/pandoc-make
	$(RM) /usr/local/bin/pdmake
	$(RM) /usr/local/etc/pandoc-bickham-makefile

.PHONY: all clean
