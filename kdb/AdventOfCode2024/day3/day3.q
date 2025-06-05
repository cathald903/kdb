//part 1
data:raze read0 `:input.txt;
mulSplit:ss[data;"mul("] cut data;
fullMul:{[x] $[")" in x; :(1+first ss[x;")"])# x;:""] } each mulSplit;
sum {[task]    x: "J"$ "," vs -1_4_task;    {[x] x[0] * x[1]}[x] }each fullMul;

//part 2
dos:1b;
mulSplit:(asc ss[data;"mul("], ss[data;"do()"],ss[data;"don't()"]) cut data;
mul:{[x]
    if[not type x = 7h;:0];
    (x[0]) * (x[1])
    };
doMul:{[x]
    res:$[((first x) = "m") and dos and (")" in x);
            @[value;(1+first ss[x;")"])# x; 0];
            0
        ];
    
    if[(4#x) like "do()"; dos::1b];
    if[(7#x) like "don't()"; dos::0b];
    :res
 };
res:raze doMul each mulSplit;
