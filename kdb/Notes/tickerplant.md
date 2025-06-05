## Feed handler
pipes in data to the tickerplant

## Tickerplant
does the following:
1) write to log file in the form of ```(`upd;`table;params) ```
2) checks it's subscribers to see who is interested in what tables and what syms in those tables (via .u.sub)
3) runs/triggers .u.endofday which alerts the subscribers to run their EOD(.u.end)functions

can be ran in real time or batch mode (with -t n>0) 

Requires a schema file to define the tables to be populated

### .u functions

#### sub
like .u.add but empty list subscribes to all tables. Also wipes existing subs

#### pub
async sends data to subscribers
uses .u.sel if client set a filter when they subbed with .u.sub

#### .u.sel
select from table where (given sym filter)

#### .u.add
add a subscription to the given table and sym list

#### .u.del
delete client subscription to the given table

### .u.end
eod day