#!/bin/bash

try() {
    expected="$1"
    input="$2"

    ./9cc "$input" > tmp.s
    gcc -o tmp tmp.s
    ./tmp
    actual="$?"

    if [ "$actual" = "$expected" ]; then
        echo "$input => $actual"
    else
        echo "$expected expected, but got $actual"
        exit 1
    fi
}

try 0 0
try 42 42
try 21 '5+20-4'
try 41 " 12 + 34 - 5 "
try 47 "5+6*7"
try 15 "5*(9-6)"
try 4 "(3+5)/2"
try 10 "-10+20"
try 10 '- -10'
try 10 '- - +10'

try 0 "0 == 1"
try 1 "42==42"
try 1 "0 != 1"
try 0 "42!=42"

try 1 '0<1'
try 0 '1<1'
try 0 '2<1'
try 1 '0<=1'
try 1 '1<=1'
try 0 '2<=1'

try 1 '1>0'
try 0 '1>1'
try 0 '1>2'
try 1 '1>=0'
try 1 '1>=1'
try 0 '1>=2'

try 2 "a = 2;"
try 1 "foo = 1"
try 5 "bar = 2 + 3;"
try 5 "bar = 2 + 3; bar"
try 8 "return 8;"
try 6 "a = 3; b = a * a - a"
try 14 "a = 3; b = 5 * 6 - 8; return a + b / 2;"
try 2 "if (1) return 2;"
try 2 "if (1) return 2; else return 1;"
try 1 "if (0) return 2; else return 1;"

echo OK
