Were previously known as adverbs. Shockingly they are used for iterating over objects in q

| func      | symbol    | sample            |
| -----     | ------    | ------            |
| each      | '         | +[1;] each til 10 |
| peach     | ':        |  v1 peach x       |
| prior     | ':        | (-':)1 1 2 3 5 8 13 |
|           |           | 1 0 1 1 2 3 5 |
| each left | \:        |                   |
| each right| /:        |                   |
| case      | '         |q)2 0 1'["abc";"def";"xyz"] |
|||                     "xbf"            |
| over      | /         |                   |
| scan      | \         |                   |

## Each
Simplest iterator, apply a value or function to everything in a list or dict etc
```
q)count each string `Clash`Fixx`The`Who
5 4 3 3
q)(count')`a`b`c!(1 2 3;4 5;6 7 8 9)        / unary
a| 3
b| 2
c| 4
```

## Each Parallel
Same as each but if secondary processes are enabled then it will split the computation between threads and so increase performance
```
\s
2i
\t inv each 2 1000 1000#2000000?1f
1528
\t inv peach 2 1000 1000#2000000?1f
973
```


## Each Prior
Apply something to two proceeding items of a list, eg l[n] - l[n-1] Note:first element in the list is operated on with whatever is on the left hand side of the prior operator with default 0, eg 
```
q)(-':) 1 2 3
1 1 1
q) 0 -': 1 2 3
1 1 1
q)2 -': 1 2 3
-1 1 1
q)(-) prior 1 2 3
1 1 1
```

## Each Left and Each Right
Each Left; x f\:y  == f[;y] each x
```
q)"abcde",\:"XY"             / Each Left
"aXY"
"bXY"
"cXY"
"dXY"
"eXY
```

Each Right; x f/:y == f[x;] each y
``` 
q)"abcde",/:"XY"             / Each Right
"abcdeX"
"abcdeY"
```

## Case
for arguments of equal lengths eg, "abc" "def, and a given integer list <= count of those arguments
select from the arguments at position i where the integer corresponds to the index

in a clear example
``` 
q)2 0 1'["abc";"def";"xyz"]
"xbf"
```
starts at position 0 of the list, and because the int is 2, we essentialy are doing \
``` ("abc";"def";"xyz")[2][0] ```\
we move on to position 1 of the int list and that is 0 so
``` ("abc";"def";"xyz")[0][1] ```\
finally we move on to position 2 of the int list and that is 1 so
``` ("abc";"def";"xyz")[1][2] ```\

To Note: atoms are treated as infitely repeating values
``` 
q)2 0 1'["a";"ded";"z"]
"zad"
```

## Scan and Over
Scan = Show me the running results
```
q)(+\)2 3 4    / Scan
2 5 9
```
Over = Show me when it is over
q)(+/)2 3 4    / over
9