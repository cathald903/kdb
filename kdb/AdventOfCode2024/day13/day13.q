\p 5001
\c 20 225
// part 1
data: 4 cut read0 `:input.txt;
pointTab:{[x] `a`b`p!("J"$ "," vs x[0] except "Button A: X+ Y+";"J"$ "," vs x[1] except "Button B: X+ Y+";"J"$ "," vs x[2] except "Prize: X= Y=")} each data ;

// Skip to the function named s for the actual intelligent solution finder
// leaving the rest in to show the dangers of going "I can brute force this"
// instead of thinking through the problem 

calculateBPresses:{[target;bVal;limitMaxTries]
    r:distinct $[all (target mod bVal) =0; "j"$target%bVal; ()];
    if[(count[r] > 1) or r ~ ();:()];
    r:first r;
    :$[limitMaxTries and r >100;();r]
    };

f:{[index;limitMaxTries]
    machine:pointTab[index];
    target:machine[`p];
    a:machine[`a];
    b:machine[`b];
    validCosts:();
    leave:$[limitMaxTries; 100 & floor min target%a; floor min target%a];
    if[a ~ 0 0; leave:0];
    aPress:0;
    while[not aPress>leave;
        combos:calculateBPresses[target - *[a;aPress];b;limitMaxTries];
        combos:*[3;1 | aPress],'combos;
        if[count combos; validCosts,:combos];
        aPress+:1
    ];
    :`index`combos!(index;validCosts)
    };
part1:f[;1b] each til count pointTab;
part1:select from part1 where {not x ~ ()} each combos;
show sum exec sum combos from part1;

//part 2
pointTab:update p:{10000000000000 10000000000000 + x} each p from pointTab;

// wait ... this is just simultaneous linear equations .....
// can solve with the elimination method
s:{[machine]
    eqs:(machine[`a]),'machine[`b],'machine[`p];
    e1:eqs 0;
    e2:eqs 1;
    p:(e1*e2[1]) + (-1*e2*e1[1]);
    $[0 = p[2] mod p[0];
        x:"j"$p[2]%p[0];
        :0];
    $[0 = (e1[2]-(x*e1[0])) mod e1[1];
        y:"j"$(e1[2]-(x*e1[0]))%e1[1];
        :0];
    :*[x;3] + *[y;1]
    };
sum s each pointTab