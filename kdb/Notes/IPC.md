Real Quick

TCP based\
 -p on cmd line or \p in process to set listening port to given number

## Hopen
`:host:port[:user:password]
```
hopen ":path/to/file.txt"                   / filehandle
hopen `:unix://5010                         / localhost, Unix domain socket
hopen `:tcps://mydb.us.com:5010             / SSL/TLS with hostname
hopen(":10.43.23.198:5010";10000)           / IP address and timeout
hopen 5010   
```

## Messaging
### synchronus
h"something to be evaluated" or \
 h(`func_on_process;v1) \
or \
h(func_on_client;params)

### Deferred Response
-30!(::)

### async
neg[h] on the above

## Deferred Sync or callback
async message sent to process and the function executed contains logic to fire a message back to that client also asynchronously using .z.w to get it's handle

## Relevant .z functions
\x can reset them to default values in case you mess it up

### .z.pg
for synchronous queries. If there is a return value it will be passed back to the calling task

### .z.ps
for asynschronous queries. return value is discarded so a callback function needs to be made use of in order to send a response back to the calling task if needed


### .z.po
argument given is the handle of the connectting client.
do shit with it like user dict

### .z.pc
connection is closed by the time f is called so no .z.a or .z.u able to be called after it. Takes the handle as it's parameter.

### .z.pw
is evaluated after -u/ - U and before .z.po.

tool for implementing access rules. eg "not valid user" or "hey it is the weekend go outside"

#### -u and -U
``` 
-u 1        / blocks system functions and file access
-U file     / sets password file, blocks \x
-u file     / both the above
```

- U lso disables \x

