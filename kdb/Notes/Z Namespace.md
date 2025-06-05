### Time shortcut

| shortcut | Time                | eg                            |
| -------- | ------------------- | ----------------------------- |
| .z.D/d   | date shortcuts      |                               |
| .z.N/n   | local/UTC timespan  | 0D23:30:10.827156000          |
| .z.P/p   | local/UTC timestamp | 2018.04.30D10:18:31.932126000 |
| .z.T/t   | time shortcuts      |                               |
| .z.Z/z   | local/UTC datetime  | 2006.11.13T21:16:14.601       |

### Callbacks

| shortcut | explanation                                                                               | example                                                                            |
| -------- | ----------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| .z.po    | port open. gets the handle as x<br>which can be used to make a <br>connections dictionary | .z.po:f                                                                            |
| .z.pc    | called after a connection is close<br>x is the handle that was being <br>used.            | .z.pc:{0N!(.z.a;.z.u;.z.w;x);x}                                                    |
| .z.pg    | synchronous execution of object<br>given. Default = {[x] value x}                         | .z.pg:f                                                                            |
| .z.ps    | asynch execution of object given<br>Default = {[x] value x}                               | .z.ps:f                                                                            |
| .z.pw    | user validation, allowing for access<br>control. Default = {[user;pswd]1b}                | .z.pw:{[user;pswd] <br>$[user in allowed_users and pswed = pswds[user];1b;0b]<br>} |


### Misc 

| shortcut | explanation                                               | example                                                |
| -------- | --------------------------------------------------------- | ------------------------------------------------------ |
| .z.X/x   | list/parse of raw args                                    | $ q test.q -P 0 -abc 123<br>q).z.x <br>"-abc"<br>"123" |
| .z.H     | active sockets                                            |                                                        |
| .z.W/w   | Handles/handle                                            |                                                        |
| .z.ts    | timer function that gets called every<br>\t N  // seconds | .z.ts:{0N!x}                                           |
| .z.exit  | function that runs before process exits                   | .z.exit{[x] show "oh no"}                              |
