// part 1
data:read0 `:input.txt;
rowMap:([rowNum:til count data] rowData:(count data )#() );
colMap:([colNum:til count data] colData:(count data )#() );
startingPosition:(0;0);
checker:{[data;dir;index]
    if[("^" in data) and dir;startingPosition::(index;first (til count data ) where "^" = data)];
    :(til count data ) where "#" = data

 };

{[index]
    rowMap::rowMap upsert (index;checker[data index;1b;index]);
    colMap::colMap upsert (index; checker[(flip data) index;0b;index])
    } each til count data;


gridHeight:count data;
gridWidth:count data 0;
// config for each of the directions, basically what do when the guard is on a path that will leave vs one with obstacles
// done to make the while loop easier to read
directionTab:([direction:enlist `up]
    nextDirection:enlist `right;
    leavingf:{reverse (til currentRow) ,' currentCol};
    nextVist:{[stoppingAt]reverse (stoppingAt + til (1+ (currentRow-1)-stoppingAt)) ,' currentCol};
    inLine:{colMap[currentCol;`colData]};
    obstacles:{[columnsInLine]currentRow> columnsInLine};
    stoppingAt:{[columnsInLine;obstacles]1+ last columnsInLine where obstacles};
    newSP:{[stoppingAt] (stoppingAt;currentCol)}
    );
directionTab,:([direction:enlist `right] 
    nextDirection:enlist `down;
    leavingf:{currentRow,' (currentCol+ til (gridWidth- currentCol))};
    nextVist:{[stoppingAt]currentRow,'(1 +currentCol + til (stoppingAt-currentCol))};
    inLine:{rowMap[currentRow;`rowData]};
    obstacles:{[rowsInLine]currentCol < rowsInLine};
    stoppingAt:{[rowsInLine;obstacles](first rowsInLine where obstacles)-1};
    newSP:{[stoppingAt] (currentRow;stoppingAt)}
    );
directionTab,:([direction:enlist `down]
    nextDirection:enlist `left;
    leavingf:{ (currentRow + til (gridHeight- currentRow)) ,' currentCol};
    nextVist:{[stoppingAt](1+currentRow + til (stoppingAt-currentRow)) ,' currentCol};
    inLine:{colMap[currentCol;`colData]};
    obstacles:{[columnsInLine]currentRow< columnsInLine};
    stoppingAt:{[columnsInLine;obstacles](first columnsInLine where obstacles)-1};
    newSP:{[stoppingAt] (stoppingAt;currentCol)}
    );
directionTab,:([direction:enlist `left] 
    nextDirection:enlist `up;
    leavingf:{ reverse currentRow,' (til currentCol)};
    nextVist:{[stoppingAt]reverse currentRow,'(stoppingAt + til (currentCol - stoppingAt))};
    inLine:{rowMap[currentRow;`rowData]};
    obstacles:{[rowsInLine]currentCol > rowsInLine};
    stoppingAt:{[rowsInLine;obstacles](last rowsInLine where obstacles)+1};
    newSP:{[stoppingAt] (currentRow;stoppingAt)}
    );

moveNext:{[dir;movNum]
    inLine:directionTab[dir;`inLine][];
    obstacles:directionTab[dir;`obstacles][inLine];
    stoppingAt:directionTab[dir;`stoppingAt][inLine;obstacles];
    newMoves:$[not any obstacles;
        [
            left::1b;
            directionTab[direction;`leavingf][]
            ];
        
        directionTab[dir;`nextVist][stoppingAt]
        ];
    if[count newMoves;
        if[newMoves in moveTab[`moves];looping::1b]
    ];
    moveTab::moveTab,([] moveNum:movNum;moves:enlist newMoves);
    startingPosition:directionTab[dir;`newSP][stoppingAt];
    currentRow::startingPosition 0;
    currentCol::startingPosition 1;
 };
prepareTofindThePath:{
    left::0b;
    looping::0b;
    moveTab::flip `moveNum`moves!(0;enlist enlist startingPosition);
    direction::`up;
 }; 
findThePath:{[]
    prepareTofindThePath[];
    movNum:1;
    currentRow::startingPosition 0;
    currentCol::startingPosition 1;
    while[not left or looping;
        moveNext[direction;movNum];
        direction::directionTab[direction;`nextDirection];
        movNum+:1;
        ];
    count distinct raze moveTab[`moves]
 };
distinctVisits:findThePath[];
visited:raze moveTab[`moves];

//part 2
mapAdder:{[coord]
    rd:rowMap[coord[0];`rowData];
    cd:colMap[coord[1];`colData];
    rowMap[coord[0];`rowData]::asc rd,coord[1];
    colMap[coord[1];`colData]::asc cd,coord[0]
 };

mapDeleter:{[coord]
    rowMap[coord[0];`rowData]:: rowMap[coord[0];`rowData] except coord[1];
    colMap[coord[1];`colData]:: colMap[coord[1];`colData] except coord[0]
 };

toCheck:distinct visited;
loopers:{[coord]
        mapAdder[coord];
        findThePath[];
        mapDeleter[coord];
        :$[looping;
            1b;
            0b];
        
        
     }each toCheck;