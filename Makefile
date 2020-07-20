MANPAGES = sessiond.1 sessionctl.1 sessiond-inhibit.1 \
		   sessiond.conf.5 sessiond-hooks.5

SPHINX_FILES = sphinx/conf.py sphinx/index.rst \
			   ../python-sessiond/sessiond.py

all: $(MANPAGES:=.md) sphinx

%.md: ../man/%.pod
	pod2markdown --html-encode-chars '|' $< | \
		./scripts/link_manpages.pl $(MANPAGES) > man/$@

sphinx: $(SPHINX_FILES)
	sphinx-build -M jekyll sphinx _sphinx
	mkdir -p python
	mv _sphinx/jekyll/index.md python/sessiond.md
	rm -rf _sphinx

gems:
	bundle config path .gem
	bundle install

build:
	bundle exec jekyll build

serve: build
	bundle exec jekyll serve

.PHONY: all sphinx gems build serve
