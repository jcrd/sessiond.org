MANPAGES = sessiond.1 sessionctl.1 sessiond-inhibit.1 \
		   sessiond.conf.5 sessiond-hooks.5

all: $(MANPAGES:=.md)

%.md: ../man/%.pod
	pod2markdown --html-encode-chars '|' $< man/$@

.PHONY: all
