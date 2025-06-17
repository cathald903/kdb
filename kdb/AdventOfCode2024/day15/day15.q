\c 25 225
\p 5001
//file: "test";
file:"test2";
//file:"test3";
//file: "input";
map:read0 hsym `$ "_" sv (file;"map.txt");
instructions:raze read0 hsym `$ "_" sv (file;"instructions.txt");
location:(1;1);
startFound:0b;
findStart:{[index]
    if[startFound;:()];
    data:map[index];
    if["@" in data;
        location::(index;first (til count data ) where "@" = data);
        startFound::1b];
 };
findStart each til count map;

instructionToCoord:{[direction]
    :$[  direction = ">"; 0 1;
        direction = "v";  1 0;
        direction = "<";  0 -1;
        -1 0]
 };

moveThing:{[point;nextPoint;thing]
    map::.[map;point;:;"."];
    map::.[map;nextPoint;:;thing];
    //show map;
    };

boxMover:{[point;direction]
    nexterLocationIndex:point + direction;
    nexterLocationValue:map over nexterLocationIndex;
    if[nexterLocationValue = "#"; :0b];
    if[nexterLocationValue = ".";
        moveThing[point;nexterLocationIndex;"O"];
        :1b];
    :$[.z.s[nexterLocationIndex;direction];
        [moveThing[point;nexterLocationIndex;"O"]; :1b];
        :0b];
    };

moveBigThingHorizontally:{[otherBoxHalfIndex;nextLocationIndex;nexterLocationIndex;nextLocationValue]
    otherBoxHalfValue:map over otherBoxHalfIndex;
    map::.[map;nextLocationIndex;:;"."];
    map::.[map;otherBoxHalfIndex;:;nextLocationValue];
    map::.[map;nexterLocationIndex;:;otherBoxHalfValue];
    //show map;
    };

bigBoxMover:{[nextLocationIndex;direction;double]
    nextLocationValue:map over nextLocationIndex;
    if[direction in (0 -1; 0 1); // moving left or right
        otherBoxHalfIndex:nextLocationIndex + direction;
        nexterLocationIndex:otherBoxHalfIndex + direction;
        nexterLocationValue:map over nexterLocationIndex;
        if[nexterLocationValue ="#";:0b];
        if[nexterLocationValue = ".";
            moveBigThingHorizontally[otherBoxHalfIndex;nextLocationIndex;nexterLocationIndex;nextLocationValue];
            :1b];
        //check the next box has a free space after it
        :$[.z.s[nexterLocationIndex;direction;0b];
            [moveBigThingHorizontally[otherBoxHalfIndex;nextLocationIndex;nexterLocationIndex;nextLocationValue]; :1b];
            :0b];
        ];
    // moving up or down is more complicated
    boxHalf:$[nextLocationValue = "]"; `right;`left];
    leftBoxIndex:$[boxHalf = `left;
            nextLocationIndex;
            nextLocationIndex + 0 -1];
    rightBoxIndex:$[boxHalf = `right;
            nextLocationIndex;
            nextLocationIndex + 0 1];
    leftNextIndex:leftBoxIndex + direction;
    leftNextValue:map over leftNextIndex;
    rightNextIndex:rightBoxIndex + direction;
    rightNextValue:map over rightNextIndex;
    //break;
    if[any "#" in (leftNextValue;rightNextValue); :0b];
    if[ ".." ~ (leftNextValue;rightNextValue);
        if[not double;
            moveThing[leftBoxIndex;leftNextIndex;"["];
            moveThing[rightBoxIndex;rightNextIndex;"]"]
        ];
         :1b];
    success:$[
        "]." ~ (leftNextValue,rightNextValue);
            .z.s[leftNextIndex;direction;0b];
        ".[" ~ (leftNextValue,rightNextValue);
            .z.s[rightNextIndex;direction;0b];
        "[]" ~ (leftNextValue,rightNextValue);
            .z.s[leftNextIndex;direction;0b];
        [double:1b;all (.z.s[leftNextIndex;direction;1b];.z.s[rightNextIndex;direction;1b])]
    ];
    if[success and double;
        (.z.s[leftNextIndex;direction;0b];.z.s[rightNextIndex;direction;0b])
    ];
    if[success;
        moveThing[leftBoxIndex;leftNextIndex;"["];
        moveThing[rightBoxIndex;rightNextIndex;"]"];
        :1b
        ];
        :0b
    };

instructionFollower:{[instruction;part]
    direction:instructionToCoord[instruction];
    nextLocationIndex:location + direction;
    nextLocationValue:map over nextLocationIndex;
    if[nextLocationValue = ".";
        moveThing[location;nextLocationIndex;"@"];
        location::nextLocationIndex;
        :1b];
    if[nextLocationValue = "#";
            :0b];
    moverFunc:$[part = 1; boxMover; bigBoxMover[;;0b]];
    if[moverFunc[nextLocationIndex;direction];
        moveThing[location;nextLocationIndex;"@"];
        location::nextLocationIndex;
        :1b]
        
    };
instructionFollower[;1] each instructions;


 GPS:sum {[index]
    sum *[100;index] + ss[map[index];"O"]
    } each til count map


// part 2
map:read0 hsym `$ "_" sv (file;"map.txt");
location:(1;1);
startFound:0b;

thingScaler:{[thing]
    :$[ thing = "#"; "##";
        thing = "O"; "[]";
        thing = "."; "..";
        "@."];
    };

mapScaler:{[index]
    newRow:raze thingScaler each map[index];
    map[index]:newRow;
    } each til count map;

findStart each til count map;
//instructionFollower[;2] each instructions;
//193