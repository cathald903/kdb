\p 5001
\c 25 225

data:read0 `input.txt;
letters:distinct raze over data;
points:(til count data) cross til count data;
// part 1
getLetter:{[p]
    :data[p[0];p[1]]
    };

touchingPoints:{[p]
    :(p[0] + 0 0 1 -1),' p[1] + 1 -1 0 0 // allows negative indexes because they count to the perimiter
    };

f:{[tc;p;l;area;perimiter]
    if[not any m:l = getLetter each tc; perimiter:perimiter,tc where not m;: (area;perimiter)]; //any non valid points are the perimiter.
    area:area, distinct tc where m; // if it is valid we add it to the area list, but only one occurence.
    perimiter:perimiter, tc where not m; // add the count of the non valid points to the perimiter. dupes are ok as area points can share a perimiter point and need to be counted
    tc:distinct tc where m;
    points::points except tc; // remove points in this plot from overall point map so we don't check them later
    p,:distinct tc; // all the points in the area so far
    tc:(raze touchingPoints each tc) except p; // get the new points to check but not the ones that we have already confirmed are in the area
    :.z.s[tc;p;l;area;perimiter] 
    };

getAP:{[p]
    l:getLetter[p];
    toCheck:touchingPoints[p];
    p:enlist p;
    points::points except p;
    plot:f[toCheck;p;l;p;()];
    :`letter`area`perimiter`p1Cost!(l;plot[0]; plot[1];*[count plot[0];count plot[1]])
    };
x:();

while[count points;
    tab,:enlist getAP points[0]
    ];
show sum exec p1Cost from tab;

//part 2
// side 0 1 2 3 = top right bottom left
tab:update p2OutsideCost:0,p2InsideCost:0,p2Cost:0 from tab;
sideTab:flip `side`h`v!(0 1 2 3;(0 1; 1 0; 0 -1; -1 0); (-1 1;1 1;1 -1;-1 -1)); 
g:{[a;currentSide;point;startPoint;rotated;seen]
    seen,:point;
    if[(point ~ startPoint) and not rotated;
        :$[any currentSide in 0 3; (1;seen); (2;seen)]
        ];
    if[startPoint ~ ();startPoint:point];
    s:exec h,v from sideTab where side = currentSide;
    pv:+[point;s[`v]];
    ph:+[point;s[`h]];
    :$[ first pv in a;
            [r: .z.s[a;-[currentSide;1] mod 4; pv;startPoint;0b;seen];(1+ sum r[0];r[1])];
        first ph in a;
            [r: .z.s[a;currentSide; ph;startPoint;0b;seen];( sum r[0];r[1])];
        [r:.z.s[a;+[currentSide;1] mod 4;point;startPoint;1b;seen];(1 + sum r[0];r[1])] 
    ]
    };

pruneInsideArea:{[point;area]
    $[all touchingPoints[point] in area; point;()]
 };

// to store the letters that contain another plot within them as walking the outside perimiter
// will only be correct if there is not a case like the below where b is inside of A
/
AAAAAA
AAABBA
AAABBA
ABBAAA
ABBAAA
AAAAAA
\
insideTab:([]letter:();lr:();rows:()); 
goWalking:{[index]
    plot:tab[index];
    a:asc plot[`area];
    if[1 = ca:count a;
        tab::update p2OutsideCost:4,p2Cost:4 from tab where letter=plot[`letter],{ x ~ y}[plot[`area];]each area;
        :()
    ];
    outsideArea: g[a;0;enlist a[0];();0b;()];
    outsideSides:outsideArea[0];
    insideArea:a except outsideArea:outsideArea[1];
    insideArea: insideArea except pruneInsideArea[;a] each insideArea;
    tab::update p2OutsideCost:outsideSides from tab where letter=plot[`letter],{ x ~ y}[plot[`area];]each area;
    if[not count insideArea; 
        tab::update p2Cost:outsideSides from tab where letter=plot[`letter],{ x ~ y}[plot[`area];]each area;
        :()];
    insidePoints:(distinct raze touchingPoints each insideArea)except a;
    r:exec i from tab where {[x;y] any y in x}[;insideArea]each perimiter;
    `insideTab upsert ([]letter:plot[`letter];lr:index;rows:enlist r);
    :()
    };
goWalking each til count tab;

{[x]
    innerPerimiter:exec sum p2OutsideCost from tab where i in x[`rows];
    tab::update p2InsideCost:innerPerimiter,p2Cost:p2OutsideCost + innerPerimiter from tab where i = x[`lr];

    }each insideTab;
sum exec ({count x}each area )*p2Cost  from tab