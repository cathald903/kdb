//part 1
data:"J"$" " vs' read0 `:input.csv;
f:{[row]
    row:1_ prior[-;] row;
    if[not (all row > 0) or (all row <0);:0b];
    row:abs row;
    if[(max row) >3;:0b];
    :1b
 };
good_reports: f each data; 
res1: sum good_reports;

//part 2
retryer:{[cond;orig]
    index: first  where not 1b,cond;
    r1:f[@[orig;(til count orig) except index]];
    r2:0b;
    if[index>0; r2:f[@[orig;(til count orig) except index-1]]];
    r1 or r2

 };
f2:{[row]
    orig:row;
    row:1_ prior[-;] row;
    errors:0;
    gz:((sum row>0) mod count row) mod (count row )-1;
    lz:((sum row<0) mod count row) mod (count row)-1;
    ez:sum row=0;
    
    $[sum(gz, lz, ez) >1;
        :0b;
        errors+:sum(gz, lz, ez)];
    // Add the number of changes above 3 to errors, if any 
    too_high:0b;   
    if[any (abrow:abs row) >3;
        too_high:1b;
        errors+:sum abrow > 3];
    $[
        errors > 2 ; 
            :0b;
        errors = 0;
            :1b
        ];
    :$[
        gz = 1; retryer[row < 0 ;orig];
        lz = 1; retryer[row > 0 ;orig];
        ez = 1; f[orig where 1b,not row =0];
        too_high; retryer[abrow <=3 ;orig]
        ]
 
 };
bad_reports: data where not good_reports;
t:bad_reports where f2 each bad_reports;
res2: sum f2 each bad_reports;
res1 + res2

brute_forcer:{[row]
    found:0b;
    counter:0;
    while[(not found) and counter <count row;
        found:f[@[row;(til count row) except counter]];
        counter+:1;
    ];
    found 
 };