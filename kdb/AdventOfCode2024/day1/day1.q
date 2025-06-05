// Part 1
data:("JJ";" ")0: `:input.csv;
show res:sum abs (asc data 0) -' (asc data 1);

// Part 2
groupedData:count each group data 0;
f:{[x;y] appears: sum x = y;:groupedData[x] * x * appears}[;data 1]; 
sum f each key groupedData
