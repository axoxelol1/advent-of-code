$p1 = 0;
while (<>) {
    chomp;
    $p1 += length($_);
    $_ = substr($_, 1, length($_)-2);
    s/\\\\/b/g;
    s/\\"/q/g;
    s/\\x../x/g;
    $p1 -= length($_);
}
print "Part 1: $p1\n";
