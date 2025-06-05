//part 1
s:read0 `:input.txt;
xmas:0;
size:count s;
chk:{[x;y] 
        word:s[x;y];
        if[(word like "XMAS") or (word like "SAMX"); xmas::xmas + 1];
        };
diag:{[x;y]
    word:s[x 0; y 0],s[x 1; y 1],s[x 2; y 2],s[x 3; y 3];
    if[(word like "XMAS") or (word like "SAMX"); xmas::xmas + 1];
    };
xmasFinder:{[r]
    {[r;c]
        nearB:r>=size-3;
        nearT:r>2;
        nearR:c>=size-3;
        if[not nearR;
            chk[r;c + til 4]];
        if[not nearB;
            chk[r + til 4;c]];
        if[ not nearB or nearR;
            diag[(r + til 4); (c + til 4)]];
        if[nearT or nearR;
            diag[(r - til 4); (c + til 4)]];
    }[r;]each til size
    };
res:xmasFinder each til size;

// part 2
masx:0;
masxFinder:{[r]
    {[r;c]
        lr:s[r-1;c-1],s[r;c],s[r+1;c+1]; 
        rl:s[r-1;c+1],s[r;c],s[r+1;c-1];
        f:{[x] (x like "MAS") or (x like "SAM")};
        if[f[rl] and f[lr];masx::masx+1]
    }[r;]each 1_til size-1
    };
res2:masxFinder each 1_til size-1 // can trim r = 0 and r = N because they dont have letters above/below them and so can never make the X