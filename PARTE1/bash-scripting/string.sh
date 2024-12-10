#!/bin/bash

# ${#var} - $var length. For an array, ${#array} is the length of the first element in the array. 
stringZ=abcABC123ABCabc
echo ${#stringZ}


arrayX=(a ab abc)
echo ${#arrayX}

# ${var:position:length} - extracts $length characters of substring from $var at $position. 0-based indexing.
stringZ=abcABC123ABCabc
echo ${stringZ:2:5}


# ${var#Pattern} - remove from $var the shortest part of $pattern that matches the front end of $var.
# ${var##Pattern} - remove from $var the longest part of $pattern that matches the front end of $var.
stringZ=abcABC123ABCabc
echo ${stringZ#a*C}
echo ${stringZ##a*C}

# ${var%Pattern} - deletes shortest match of $Pattern from back of $var.
# ${var%%Pattern} - deletes longest match of $Pattern from back of $string.
stringZ=abcABC123ABCabc
echo ${stringZ%a*c}
echo ${stringZ%%b*c}

# ${var/Pattern/Replacement} - replace first match of $Pattern with $Replacement. If $Replacement is omitted, then the first match of $Pattern is replaced by nothing, that is, deleted.
# ${var//Pattern/Replacement} - replace all matches of $Pattern with $Replacement.
stringZ=abcABC123ABCabc
echo ${stringZ/abc/xyz}
echo ${stringZ//abc/xyz}
stringZ=abcABC123ABCabc
echo ${stringZ/abc}
echo ${stringZ//abc}

# ${var/#Pattern/Replacement} - if prefix of $var matches $Pattern, then substitute $Replacement for $Pattern.
# ${var/%Pattern/Replacement} - if suffix of $var matches $Pattern, then substitute $Replacement for $Pattern.
stringZ=abcABC123ABCabc
echo ${stringZ/#abc/XYZ}
echo ${stringZ/%abc/XYZ}

