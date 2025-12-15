<?php
$lines = file("example.txt", FILE_IGNORE_NEW_LINES);

$locations = array();
$distances = array();
foreach ($lines as $line) {
    $boom = explode(" = ", $line);
    $locs = explode(" to ", $boom[0]);
    $dist = $boom[1];
    $locations[$locs[0]] = 1;
    $locations[$locs[1]] = 1;
    $distances[$locs[0]][$locs[1]] = $dist;
    $distances[$locs[1]][$locs[0]] = $dist;
}

function permutations($arr, $perms = array())
{
    if (empty($arr)) {
        return array($perms);
    }
    $out = array();
    for ($i = count($arr) - 1; $i >= 0; --$i) {
        $new_arr = $arr;
        $new_perms = $perms;
        list($foo) = array_splice($new_arr, $i, 1);
        array_unshift($new_perms, $foo);
        $out = array_merge($out, permutations($new_arr, $new_perms));
    }
    return $out;
}

$locations = array_keys($locations);
$perms = permutations($locations);

$min = PHP_INT_MAX;
$max = 0;
foreach ($perms as $perm) {
    $dist = 0;
    for ($i = 0; $i < count($perm) - 1; $i++) {
        $dist += $distances[$perm[$i]][$perm[$i + 1]];
    }
    $min = min($min, $dist);
    $max = max($max, $dist);
}
print "Part 1: $min\n";
print "Part 2: $max\n";
