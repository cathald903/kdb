\p 5001
\c 20 225
//part 1 and 2
data: "J"$ " " vs raze read0 `:input.txt;
blink:75;
seenBefore:(enlist -1)!enlist (1 2);
newOrder:();
iterationsLeft:([]n:data;iterations:(count data)#blink);
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
    r:stone;
    i:5;
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
        `iterationsLeft upsert raze {[x;stone;remainder] ([]n:stone;iterations:(count stone)#remainder)}[;stone;remainder]each til times;
        :()
        ];
    newOrder::newOrder,times * count stone;
    };
\ts f[;blink;1] each data;
f1:{[stone;b]
    t:(first exec times from exec times:count i by n,iterations from iterationsLeft where n = stone,iterations=b);
    f[stone;b;t];
    iterationsLeft::delete from iterationsLeft where n=stone,iterations=b;
    //show count distinct iterationsLeft

    };
\ts while[count iterationsLeft;
    {f1[x[`n];x[`iterations]]} first iterationsLeft
   ];

// 3893 201409552 for 35    
// 789  153256432
// 4006 6849888 for 25
// 1816 5268448 for 25
// 1322 25990288
