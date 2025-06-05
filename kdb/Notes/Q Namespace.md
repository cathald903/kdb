### General

| shortcut  | explanation                                             | example                                                                                                                                |
| --------- | ------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| .Q.gc     | garbage collect                                         | .Q.gc[]                                                                                                                                |
| .Q.qt     | Is table?                                               | .Q.qt[x] -> 1b or 0b                                                                                                                   |
| .Q.A/a/an | upper/lower/numerics case alphabet                      | q).Q.A<br>"ABCDEFGHIJKLMNOPQRSTUVWXYZ"                                                                                                 |
| .Q.n/nA   | numerics / numerics and upper alphabet                  | q).Q.n <br>"0123456789"<br>q).Q.nA "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"                                                              |
| .Q.ts     | same as \ts, shows time and space of query              | q).Q.ts [.Q.hg;enlist`:http://www.google.com] <br>148 131760                                                                           |
| .Q.w      | memory stats                                            |                                                                                                                                        |
| .Q.opt    | cmd line args as dict                                   | .Q.opt .z.x                                                                                                                            |
| .Q.fs     | file streaming to read in large csvs N chunks at a time | q).Q.fs[{0N!("SSSSSSID";",")0:x}]`:potamus.csv <br>(`Take`A;`a`man;`hippo`a;`to`plan;`lunch`a;`today`hippopotamus;-1 42i;1941.12.. 120 |
| .Q.ty     | type but as character                                   | q)a:1<br>q).Q.ty[a]<br>"j"                                                                                                             |

### Database
| shortcut  | explanation                                                                                                 | example                              |
| --------- | ----------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| .Q.chk    | fills tables missing from partitions using the most <br>recent partition containing the table as a template | .Q.chk[`:hdb]                        |
| .Q.dpft/s | saves table t splayed to partition p, s allowing for the enum domain to be specified                        | .Q.dpft[`:db;2007.07.23;`sym;`trade] |
| .Q.en     | enumerate varcharcols                                                                                       | .Q.en[dir;table]                     |
| .Q.ens    | enumerate  against domain                                                                                   | .Q.ens[dir;table;name]               |
|           |                                                                                                             |                                      |
|           |                                                                                                             |                                      |
