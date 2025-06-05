\p 5001
\c 20 225
//part 1
data:first (read0 `:input.txt);
chunked:2 cut data;
d:([]pos:"J"$();blocks:"J"$();space:"J"$());
diskmap:();
{[index]
    d:: d upsert ([]pos:enlist index;blocks:enlist "J"$chunked[index;0];space:enlist "J"$chunked[index;1]);
    diskmap,:#["J"$chunked[index;0];index],#[0|"J"$chunked[index;1];-1];
    }each til count chunked;
diskmapClone:diskmap; // for part 2
diskmapTrimmer:{
    if[last diskmap = -1;
        diskmap::-1 _ diskmap;
        .z.s[]]
    };

blockCalculator:{[last_index]
    freeSpaces:(til count diskmap) where diskmap = -1;
    if[not count freeSpaces;freeBlock::();:()];
    freeBlock::();
    currentBlock:();
    i:0;
    while[i < last_index;
        $[+[1;freeSpaces[i]] = freeSpaces[i+1];
            currentBlock:currentBlock,freeSpaces[i];
            [   currentBlock,:freeSpaces[i];
                freeBlock:: freeBlock,enlist currentBlock;
                currentBlock:() ]   ];
        i+:1
    ]
    };

blockMover:{[file;occurences]
    if[not any enoughSpace:file[`blocks] <= count each freeBlock;:()];
    index:first (til count freeBlock) where enoughSpace;
    if[(first occurences) < first freeBlock[index];:() ]; // free block of big enough size occurs after it's current location
    diskmap::@[diskmap;occurences;:;-1];
    diskmap[file[`blocks]#freeBlock[index]]::file[`pos];
    freeBlock::@[freeBlock;index;:;(file[`blocks])_ freeBlock[index]];    
    };

individualMover:{[file;occurences]
    freeSpaces:(til count diskmap) where diskmap = -1;
    if[0 = count freeSpaces; :0b];
    $[file[`blocks] <= count freeSpaces;
        [   diskmap::.[(til first occurences);();diskmap];
            diskmap[file[`blocks]#freeSpaces]::file[`pos]   ];
        [   diskmap::.[til first #[(-)count freeSpaces;occurences];();diskmap];
            diskmap[freeSpaces]::file[`pos] ]
    ];
    :1b
    };

mover:{[file;wholeFile]
    if[(last diskmap = -1) and not wholeFile;
        diskmapTrimmer[]
        ];
    occurences:(til count diskmap) where diskmap = file[`pos];
    if[not wholeFile;
        :individualMover[file;occurences]
        ];
    blockMover[file;occurences];
    :1b
    };

moreFreeSpaces:1b;    
f:{[file;wholeFile]
    show("file ", (string file[`pos]), " starting");
    if[moreFreeSpaces;
        moreFreeSpaces::mover[file;wholeFile]]
    show("file ", (string file[`pos]), " finished");
    };

f[;0b] each reverse 1_d;
show res:sum {[index] index * diskmap[index]} each til count diskmap;

//part 2
diskmap:diskmapClone;
moreFreeSpaces:1b;
blockCalculator[count diskmap];    
f[;1b] each reverse 1_d;
show res:sum {[index] v:diskmap[index]; $[-1 = v;:0;index * diskmap[index]]} each til count diskmap