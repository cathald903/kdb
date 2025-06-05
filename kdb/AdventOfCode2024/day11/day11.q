\p 5001
\c 20 225
//part 1 and 2
data: "J"$ " " vs raze read0 `:input.txt;
blink:75;
seenBefore:(enlist -1)!enlist (1 2);
newOrder:();
iterationsLeft:([]n:data;iterations:(count data)#blink;timesToDo:1);
iterationsLeft:0!select sum timesToDo by n,iterations from iterationsLeft;
applyRules:{[stone]
    r:$[ stone = 0;
            1;
        mod[(count s:string stone);2]=0;
            "J"$cut["J"$ string %[count s;2];s];
        stone*2024
    ];
    seenBefore[stone]:r;
    };

f:{[stone;b;times]
    stone;
    i:20;
    remainder:$[    b>i;
                        b-i;
                    b<i;
                        [i:b;0];
                    0];
    while[i;
        if[1 < count stone;
            stone:raze over stone;  
            ];
        if[any t:not stone in key seenBefore;
            $[1 = count t;
                applyRules stone;
                applyRules each stone where t
            ]        
        ];
        stone:seenBefore[stone];
        i-:1
    ];
    iterationsLeft::delete from iterationsLeft where i= 0;
    stone:raze over stone;
    if[remainder;
        temp:select sum timesToDo by n,iterations from ([]n:stone;iterations:remainder;timesToDo:times);
        p:exec n from iterationsLeft where iterations = remainder;
        iterationsLeft:: iterationsLeft pj select from temp where n in p;
        iterationsLeft:: iterationsLeft upsert 0!select from temp where not n in p;
        :()
        ];
    newOrder::newOrder,times * count stone;
    };
f1:{[stone;b;t]
    show " " sv (string .z.T;"starting";string stone;string b;string t);
    f[stone;b;t];
    show " " sv (string .z.T;"finished";string stone;string b;string t);

    };
\ts while[count iterationsLeft;
    {f1[x[`n];x[`iterations];x[`timesToDo]]} first iterationsLeft;iterationsLeft
   ];

// 3322 4472512 for 75
