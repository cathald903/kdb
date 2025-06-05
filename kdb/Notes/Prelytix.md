Description
A demand side platform for serving ads to a targeted audience using an inhouse database of ips that could be confidently matched to certain companies to ensure relevant targeting of those ads. The matching was done via scoring each ip against our set of tags, essentially just key words like Cloud computing or finance, business, sport etc.

Database Management \
S - memory overflowing causing slow/shut down of key process \
T- Resolve \
A - Find heavy tables/dictionaries .Q.ts on various tables and dictionaries where 
prune where possible 
communicate with business for reduction in look back period for processes that did not use the full extent of the 90 day period. \
R- memory was under control for the remainder of the v2 lifecycle 

Scoring Process \
S - Increase in critical database size would cause daily scoring process to take more than a day and reduced AWS costs \
T - resolve \
A - 
- investigating bottlenecks using reduced data set to help
identify where maximum gains would be made
- choosing to focus on functions and data loads inside loops for maximum return. 
- Applying sorted attribute to ip table to facilitate quicker join against classification table
- restructured the project 
- moved loaded data to a pre-process and split it into batches for less in memory usage
- l week long testing of new vs old version to ensure 100% match.

R - 16 hours on 3.6 million reduced to 2 hours on 8.4 million rows which massively increased our allure to potential customers AND saved roughly 1000 dollars a month by being able to downgrade our r4.2xlarge instance with 17 hours of usage a day to a r6g.xlarge with 3 hours of usage a day. (figures obtained from amazon price calculator)

 tradedesk integration \
S- inhouse DSP deemed unfeasible due to costs needed. Decided to use a whitebox solution instead. \
T - API via python to hit solution's backend and create the campaigns, flights and tactics users need to serve their adds. \
A - Design integration and set up first use of pykx in the Prelytix project  \


STAR - Vertica data duplication \
 
 
 data file ingestion \
S - files being dropped into s3 buckets to supplement our db\
T - bring into our DB\
A - designed a pipeline with a common entry point function that would listen for a kafka message ,which was triggered by a AWS lambda, then would run different kdb code to parse and ingest the file \
R - Flexible pipeline 



Day to Day tasks
 - JIRA Sprint work- 
	- feature work
	- bug fixes
- TDD's creation/review using confluence
- meetings
- log monitoring
