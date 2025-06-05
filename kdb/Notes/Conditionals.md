# if
if[1b; do all this]

# Cond
```
$[1b; "do this"; "else this"]
"do this"
```
```
$[0b; "do this"; 1b; "do that"]
"do that"
```
```
$[0b; "do this"; 0b; "do that"]
No response
```
```
$[0b; "do this"; 0b; "do that" ;"else this"]
"else this"
```

# vector condtitional
```
q)?[11001b;1 2 3 4 5;10 20 30 40 50]
1 2 30 40 5
q)?[11001b;1;10 20 30 40 50]
1 1 30 40 1
q)?[11001b;1 2 3 4 5;99]
1 2 99 99 5
```

great for qsql queries:
eg given the below table, create a new column that gives the first value of c1 if c2 is 0 and the second value if c2 is true
```
t:([] c1: 5 2 #5?9;c2: 5?01b)
c1  c2
------
6 8 0 
8 3 0 
6 6 1 
8 8 1 
3 6 0 
update c3:?[not c2;1#'c1;-1#'c1] from t
c1  c2 c3
---------
6 8 0  6 
8 3 0  8 
6 6 1  6 
8 8 1  8 
3 6 0  3 
```