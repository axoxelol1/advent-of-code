$p2 = 0;
while (<>) {
    chomp;
    $p2 -= length($_);
    s/\\/\\\\/g;
    s/"/\\"/g;
    $p2 += length($_) + 2;
}
print "Part 1: $p2\n";
