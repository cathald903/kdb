![t;c;b;a]              /update and delete

?[t;i;p]                /simple exec

?[t;c;b;a]              /select or exec
?[t;c;b;a;n]            /select up to n records
?[t;c;b;a;n;(g;cn)]     /select up to n records sorted by g on cn

| symbol | meaning | example|
| - | - | - |
| t | table or `table | trade or `trade |
| c | where phrase = as a parse tree |enlist (>;`c2;35) |
| b | by phrase = dictionary of symbols for grouping | (enlist `name)!enlist `n |
| b | can be 0b for no grouping 1b for grouping or () | 0b, 1b, () |
| a | select phrase = | `m`s!((max;`p);(sum;`p) |
| i | list of indexes | | 
| p | parse tree | | 
| n | max  records returned | 10 or -10 or 1 6 |
| g | unary grade function | (idesc;`c1)|


## Select
?[t;c;b;a]
``` 
q)t:([] c1:`a`b`a`c`b`c; c2:1 1 1 2 2 2; c3:10 20 30 40 50 60)

q)?[t;(); 1b; `c1`c2!`c1`c2]        / select distinct c1,c2 from t
c1 c2
-----
a  1
b  1
c  2
b  2
```


## exec
?[t;c;b;a]
```
q)?[t; (); (); ()]                          / exec last c1,last c2,last c3 from t
c1| `a
c2| 40
c3| 3.14159
c4| `dog

q)?[t; (); (); `c1]                         / exec c1 from t
`a`b`c`c`a`a

q)?[t; (); (); `one`two!`c1`c2]             / exec one:c1,two:c2 from t
one| a  b  c  c  a  a
two| 10 20 30 30 40 40

q)?[t; (); (); `one`two!(`c1;(sum;`c2))]    / exec one:c1,two:sum c2 from t
one| `a`b`c`c`a`a
two| 170
```

## simple exec
?[t;i;p]
``` 
q)show t:([]a:1 2 3;b:4 5 6;c:7 9 0)
a b c
-----
1 4 7
2 5 9
3 6 0

q)?[t;0 1 2;`a]
1 2 3
q)?[t;0 1 2;`b]
4 5 6
q)?[t;0 1 2;(last;`a)]
3
q)?[t;0 1;(last;`a)]
2
q)?[t;0 1 2;(*;(min;`a);(avg;`c))]
5.333333
``` 

## update
![t;c;b;a]

## delete
![t;c;0b;a]
delete is update but with b = 0b AND one of c/a must be empty and the other not.
c => ,(=;`c2;5) deletes rows
a => `c1`c2`c3 deletes columns