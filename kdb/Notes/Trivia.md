# Time .z functions and their differences
.z.p/P : Is system UTC/localtime timestamp in nanoseconds. 2025.04.16D10:55:09.972968856 \
.z.n/N : Is system UTC/localtime time as timespan in nanoseconds. 0D10:55:19.046832331 \
.z.z/Z : Is UTC/local time as a datetime  .2025.04.16T10:55:27.727 \
.z.t/T : Is milliseconds since midnight. `time$.z.z (10:57:29.131;39449131i) \
.z.d/D : Is days since 2000.01.01 

# What could be causing high HDB memory
1) large sym file could be bloating memory
2) a global or namespace variable could be declared and be accumulating memory, eg some table that tracks queries or connections and isn't pruned or flushed