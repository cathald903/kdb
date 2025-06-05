\p 5001
\c 20 255

//part 1
/
essentially just looking to see if we can count to 9 from any zero
\ 
data: read0 `:input.txt;
data:(count data 0) cut "J"$ ' raze data;

pointPruner:{[point; previousPoint]
    $[  (point ~ previousPoint) or (any point <0) or (any point >= count data[0]);
            :();
            :point
        ]
    };

touchingPoints:{[rowNumber;colNumber;previousPoint]
    points:(   (rowNumber-1; colNumber );
        (rowNumber +1; colNumber );
        (rowNumber ; colNumber-1 );
        (rowNumber ; colNumber + 1)
    );
    :pointPruner[;previousPoint] each points
    };

findThePath:{[currentPoint;previousPoint;startingPoint]
    rowNumber:currentPoint[0];
    colNumber:currentPoint[1];
    path,:currentPoint;
    if[9 = data[rowNumber;colNumber];paths[startingPoint]::paths[startingPoint],enlist currentPoint;:()];
    pointsToCheck:touchingPoints[rowNumber;colNumber;previousPoint] except enlist ();
    pointsToCheck: pointsToCheck where {[nextPoint;currentPoint];
        :$[ data[nextPoint[0];nextPoint[1]] = data[currentPoint[0];currentPoint[1]]+1;
                1b;
                0b ];
       
    }[;currentPoint] each pointsToCheck;
    if[ count pointsToCheck;
        .z.s[;currentPoint;startingPoint] each pointsToCheck
                ];
    };


startingPoints: raze  {[index]
    {[index;jindex]
        if[0 = data[index;jindex];
            :(index;jindex);
            ];
    }[index;] each til count data[0]
    
    } each til count data;
startingPoints: startingPoints except (::);
paths:startingPoints!();
{[x] findThePath[x;x;x]} each startingPoints;
show sum count raze distinct each paths;

//part 2
sum count each paths
