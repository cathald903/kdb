\p 5001

// part 1
data: read0 `:input.txt;
frequencies:(distinct raze data) except ".";
nodes:(frequencies)!(());
nodeFinder:{[index]
    row:data[index];
    {[row;index;f] nodes[f],:index,' ss[row;f]}[row;index;]each frequencies;
 } each til count data

pointcombo:{[points;l]
    if[0 = count 1_points;: l];
    p:enlist 1#points;
    l,:p cross enlist each 1_points;
    .z.s[1_points;l]
    
 };

directionFinder:{[p1;p2]
    vertical:$[
        p1[0] < p2[0];
        (`d;`u);
        p1[0]>p2[0];
        (`u;`d);
        `
        ];
    horizontal:$[
        p1[1] < p2[1];
        (`r;`l);
        p1[1]>p2[1];
        (`l;`r);
        `
        ];
    :vertical,'horizontal

 };

isPointInGrid:{[p;direction;distance;gridDimension;index]
    valid:$[(direction = `d) or (direction = `r);
        0 <= d:p[index]-distance;
        gridDimension >= d:p[index]+distance];
    :$[valid;d;-1]
 };

distanceCalculator:{[p1;p2;path;harmonics]
    
    gridDimension:-[count data;1];
    yF:isPointInGrid[;path[0];abs(p1[0]-p2[0]);gridDimension;0];
    xF:isPointInGrid[;path[1];abs(p1[1]-p2[1]);gridDimension;1];

    antinode:$[
        path[0] ~ `d;
            [(yF[p1];xF[p1])];
        path[0] ~ `u;
            [(yF[p2];xF[p2])];
        (path[0] ~ `)and (path[1] ~ `r);
            [(p1[0];xF[p1])];
        (path[0] ~ `)and (path[1] ~ `l);
            [(p1[0];xF[p2])]
        ];
    antinode:$[all -1 < antinode; antinode;[harmonics:0b;()]]; // all valid or we stop checking
    :$[not harmonics;
        antinode;
        antinode,$[path[0] in `d`;.z.s[antinode;p1;path;harmonics];.z.s[p2;antinode;path;harmonics]]
    ];
    
    

 }; 

distanceChecker:{[points;harmonics]
    p1:points 0;
    p2:points 1;
    dirs:directionFinder[p1;p2];
    :distinct  distanceCalculator[p1;p2;;harmonics] each dirs;
 };

antinodeFinder:{[k;harmonics]
    points:nodes[k];
    combo:pointcombo[points;()];
    antinodes:distinct 2 cut raze over distanceChecker[;harmonics] each combo;
    :$[harmonics;
        points,antinodes;
        antinodes
    ]

 };

antinodes: distinct raze antinodeFinder[;0b] each key nodes;
count antinodes


//part 2
resonantAntinodes: distinct raze antinodeFinder[;1b] each key nodes;
count resonantAntinodes
