#!/bin/bash

# assignment variables
var=value
var2="one two three"
var3=one\ two\ three

# referecing a variable
echo $var
echo ${var}

# indirecting referencing 
var=value
value=hello
eval b=\$$var
echo $b

n=6/3
echo "n = $n"

declare -i n
n=6/3
echo "n = $n"