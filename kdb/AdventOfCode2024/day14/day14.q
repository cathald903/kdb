\p 5001
\c 120 500

//part 1
/file:`test.txt;
file:`input.txt;
data: read0 file;
gridSize:$[file ~ `test.txt;7 11;103 101];
rParser:{[robot] 
    robot:" " vs robot;
    robot:"," vs' raze 1 _' ("=" vs' robot);
    :(reverse "J"$robot[0];reverse "J"$robot[1])
    };
data: rParser each data;

trackPath:{[robot;seconds]
    :(robot[0]+*[robot[1];seconds]) mod gridSize;
    };
p:flip trackPath[;100] each data;
positionTab:([]robot:til count data;yCoord:p[0];xCoord:p[1]);
middle:floor gridSize%2; // round down it seems
quadrants:(
        ((0;0);(middle[0]-1;middle[1]-1));
        ((0;middle[1]+1);(middle[0]-1;gridSize[1]-1));
        ((middle[0]+1;0);(gridSize[0]-1;middle[1]-1));
        ((middle[0]+1;middle[1]+1);(gridSize[0]-1;gridSize[1]-1))
    );

safetyFactor:{[q]
    :count select from positionTab where yCoord within (q[0;0];q[1;0]), xCoord within (q[0;1];q[1;1])
    };
show res:(*) over safetyFactor each quadrants;

//part 2
pointGrid:gridSize[0]#enlist gridSize[1]#"-";
pointGridCopy:pointGrid;
touchingPoints:{[p]
    :(p[0] + 0 0 1 -1),' p[1] + 1 -1 0 0 // allows negative indexes because they count to the perimiter
    };

treeFinder:{[]
    positions:trackPath[;steps] each data;
    {pointGridCopy[x[0];x[1]]:"X"}each positions;
    print:0b;
    c:til count dp:(distinct asc positions);
    while[(not print) and 0< count c;
        print:{[x;y]all touchingPoints[y[x]] in y}[c[0];positions];
        c:1_c;
    ];
    if[print;
        show ": " sv ("Steps";string steps);
        show flip pointGridCopy
    ];
    pointGridCopy::pointGrid;
    };
steps:0;
.z.ts:{[x] treeFinder[];steps::steps+1};
/
Not solved programatically, I just stared and the outputs until I saw a christmas tree

there must be a better way to find it, but without knowing the christmas tree shape it's hard to make a pattern match to find it.
might be able to reduce the number of false positives by upping the number of points checked from a cross to something else but if the
christmas tress was the smallest possible christmas tree, ie a cross, then it would be missed.
Or is the minimum christmas tree not 
    +                   +
   +++      and is     +++
    +                 +++++
                        +
\
\t 1