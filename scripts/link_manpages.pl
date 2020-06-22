#!/usr/bin/perl

my $manpage_url = "https://www.commandlinux.com/man-page/man%d/%s.%d.html";
my $pattern = qr/\*\*([^[:space:]]+)\*\*\(([[:digit:]]+)\)/;

my %pages = map { $_ => 1 } @ARGV;

while (my $line = <STDIN>) {
    my @matches = $line =~ m/$pattern/g;
    while (@matches) {
        ($k, $v) = splice @matches, 0, 2;
        if (exists($pages{"$k.$v"})) {
            $line =~ s/$pattern/[$k($v)]($k.$v.md)/;
        } else {
            my $url = sprintf($manpage_url, $v, $k, $v);
            $line =~ s/$pattern/[$k($v)]($url)/;
        }
    }
    print $line;
}
