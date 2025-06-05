// part 1
rules:("JJ"; "|")0: `:input.csv;
rulesTab:([] n:rules[0];r:rules[1]);
rulesTab:select r by n from rulesTab;
data:read0 `:input2.csv;
data:{"J"$"," vs x} each data;
f:{[x]
    r:{[x;y] :$[any (rulesTab[x[y];`r]) in x[til y];   1b; 0b]}[x;]each 1_til count x;
    :not any r
    };

res:f each data;
good:sum {[x] x[floor (count x)%2]} each data where res;

f2:{[x]
    c:1;
    while[c < count x;
        if[any tomove:x[til c] in (rulesTab[x[c];`r]) ;
            toAdd:x[til c] where tomove;
            fhalf:(c#x);
            shalf:(c _x);
            x:(fhalf except toAdd),(#[1;shalf],toAdd,_[1;shalf]);
            c-:count toAdd;
        ];
    c+:1];
    :x[floor (count x)%2]
    };
res2:sum f2 each data where not res;