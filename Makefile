MANPAGES = sessiond.1 sessionctl.1 sessiond-inhibit.1 \
		   sessiond.conf.5 sessiond-hooks.5

all: $(MANPAGES:=.md)

%.md: ../man/%.pod
	pod2markdown --html-encode-chars '|' $< | \
		./scripts/link_manpages.pl $(MANPAGES) > man/$@

gems:
	bundle config path .gem
	bundle install

build:
	bundle exec jekyll build

serve: build
	bundle exec jekyll serve

.PHONY: all gems build serve
