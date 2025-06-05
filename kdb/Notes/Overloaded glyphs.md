# AT
basically
Index, apply and amend

|rank	|syntax|	semantics|
|-|-|-|
|2	|l@i, @[l;i]	|Index At|
|2	|f@y, @[f;y]	|Apply At|
|3	|@[f;y;e]	|Trap At|
|3	|@[d;i;u]	|Amend At|
|4	|@[d;i;m;my]	|Amend At|
|4	|@[d;i;:;y]	|Replace At|

```
// Apply at
q)d:((1 2 3;4 5 6 7);(8 9;10;11 12);(13 14;15 16 17 18;19 20))
/index at
q)d@0 1 2
(1 2 3;4 5 6 7)
(8 9;10;11 12)
(13 14;15 16 17 18;19 20)
q)d@/0 1 2 // ((d @ 0)@1)@2
6

// Trap at
@[f;fx;e]


// rank 3 amend at
q)e:(1 2 3 ;4 5 6; 7 8 9)
q)@[e;0 0 1 1 2 2 2; 2+] // apply 2+ to e at the given index(s), repeated values mean do it again
5  6  7     // 2+ done twice eg 4+ 1 2 3
8  9  10    // 2+ done twice eg 4+ 4 5 6
13 14 15    // 2+ done twice eg 6+ 7 8 9

// rank 4 amend at
like rank 3 but vy is right hand argument of v 
@[d; i; v; vy] 
@[e ;0 1 2 1; {x*y};100]
100   200   300  // {x*100} done once
40000 50000 60000 // {x*100} done twice
700   800   900  // {x*100} done once

// Replace at
Like rank 4 ammend at but because of the : operator it just replaces the location with whatever we give it
q)@[e ;0 1 2 1;: ;100]
100 100 100
```


## Bang
t:enlist `a`b!0 1
|rank	|syntax|	semantics|
|-|-|-|
| x!t | make a dictionary |``` `a`b!0 1 ```|
| N!t| Key a table | 1!t |
| 0!t | Unkey a tabke | 0!t |
| -i!y | internal functions | |
| ![t;c;b;a] |  functional update and delete| |

## Colon colon
|rank	|syntax|	semantics|
|-|-|-|
| v::select from t where a =b | define a view | define a view |
| global::42 | define a global |  |
| :: | identity and null |  |
```
views
q)v::a+b
q)v
'b
q)a:1
q)b:5
q)v
6
```

## . Dot
|rank	|syntax|	semantics|
|-|-|-|
| d. 1 2  | index |  |
|  | apply |  |
| .[g;gx;e] | trap |  |
| .[d;i;u] | ammend |  |
| .[d;i;m;my] | ammend |  |
| .[d;i;::;y] | replace |  |

``` 
//apply
q)(+) . 2 3         / +[2;3] (Apply)
5
//index
q)d:((1 2 3;4 5 6 7);(8 9;10;11 12);(13 14;15 16 17 18;19 20))
q)d . enlist 1 // d at 1
 9
10
11 12
q) d. 1 2
11 12
```

## $ dollar
|rank	|syntax|	semantics|
|-|-|-|
| $[x>10;y;z] | conditional evaluation |  |
| "j"$y | cast |  |
| "J"$y | tok |  |
| x$y | Enumerate  |  |
| 9$"foo" | pad | "foo         " |
| (1 2 3f;4 5 6f)$(7 8f;9 10f;11 12f) | dot product |  |

## # hash
|rank	|syntax|	semantics|
|-|-|-|
| 2 3#til 6 | Take |  |
| `s#123| set attribute  |  |
```
// Take
q)2 5 #til 10
0 1 2 3 4
5 6 7 8 9

// apply an attribute
q)`s#1 2 3
```

## ? query
|rank	|syntax|	semantics|
|-|-|-|
| "abcdef"?"cab" | find | find  right in left / y in x|
| 10?10 | Roll | 4 1 6 4 4 2 2 7 2 0 |
| -10?10 | Deal | 3 5 2 7 6 1 8 0 9 4 |
| 0N?x | Permute  | x is a list, return x in a random order |
| x?v | Enum Extend |  |
| ?[11011b;"black";"flock"] | Vector Conditional |  |
| ?[t;i;p] | Simple Exec |  |
| ?[t;c;b;a] | Select, Exec |  |
| ?[t;c;b;a;n] | Select |  |
| ?[t;c;b;a;n;(g;cn)] | Select |  |
```
// find y in x
q)"abcdef"?"cab"
2 0 1

// permute
q)0N?"xab"
"bxa"

//  Simple Exec
t:([] a: 1 2 3 4;b:`a`b`c`d)
q)?[t;0 2;`a] // select rows 0 and 2 of row a from t
1 3

// Select, Exec

```