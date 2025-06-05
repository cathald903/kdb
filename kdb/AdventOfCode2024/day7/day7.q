// part 1
data:("J*";enlist",")0: `:input.csv

doMath:{[x;useThirdOperator]
    x1: x[0] * x[1];
    x2: x[0] + x[1];
    x3: "J"$ string[x[0]],string[x[1]];
    :$[useThirdOperator;
        (x1;x2;x3);
        (x1;x2)
        ]
    };

equationDoer:{[n;target;useThirdOperator]
    if[2 = count n;
        :$[any doMath[n;useThirdOperator] = target;  target; 0]
     ];
    a:2#n;
    b:2_n;
    a1:doMath[a;useThirdOperator];
    a3:a1[2];
    a2:a1[1];
    a1:a1[0];
    p1:$[ a1 > target; 0;
        p1:.z.s[a1,b;target;useThirdOperator]
    ];
    p2:$[ a2 > target; 0;
        p2:.z.s[a2,b;target;useThirdOperator]
    ];
    p3:$[useThirdOperator;
        $[ a3 > target; 0;
        p3:.z.s[a3,b;target;useThirdOperator]
        ];
        0
        ];
    :$[p1 or p2 or p3; target;0]
 };

show res: sum {[dict] n:"J"$ " " vs dict[`numbers]; sum $[0 in n; 0;equationDoer[n;dict[`result];0b]]} each data;

//part 2

show res: sum {[dict] n:"J"$ " " vs dict[`numbers]; sum $[0 in n; 0;equationDoer[n;dict[`result];1b]]} each data;
