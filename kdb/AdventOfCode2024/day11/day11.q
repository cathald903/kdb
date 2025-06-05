\p 5001
\c 20 225
//part 1 and 2
data: "J"$ " " vs raze read0 `:input.txt;
blink:75;
seenBefore:(enlist -1)!enlist (1 2);
newOrder:();
// a table to store what number have how many iterations left how many times
// essentially used to avoid having to build giant lists that consume too much memory
// as we don't care about order, only number of stones, so we can break up the order of  
// calculations as we want
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
    i:15; // limiting to 15 because it seems to be the sweet spot for chunk size
    remainder:$[    b>i;
                        b-i;
                    b<i;
                        [i:b;0];
                    0];
    while[i;
        if[1 < count stone;
            stone:raze over stone;  //flatten lists
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
    iterationsLeft::delete from iterationsLeft where i= 0; // completed the topmost item in the table, so we can remove it.
    stone:raze over stone; //flatten lists
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

// 3322 4472512 for 75 using i = 25
// 2093 4555600 for 75 using i = 10
// 1776 4472736 for 75 using i = 15