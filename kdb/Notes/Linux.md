## df 
| arg | function|
|-|-|
|  |  |

## du
| arg | function|
|-|-|
|  |  |

## cat
| arg | function|
|-|-|
|-n| numbers the lines |
|-b| numbers only non empty lines, overrides -n |
|-e| shows $ at end of line |
|-s| doesn't print blanks -> SQUEEZE |

## find
find . -name Databases.md
find . -name *.md

## free
| arg | function|
|-|-|
| -h | human readable |
| --bytes | show output in bytes |
| --kilo | show output in kilobytes |
| --mega | show output in megabytes |
| --giga | show output in gigabytes |
| --tera | show output in terabytes |
| --peta | show output in petabytes |
| -b | show output in bytes |
| -k | show output in kibibytes |
| -m | show output in mibibytes |
| -g | show output in gibibytes |

## grep
| arg | function|
|-|-|

## less
| arg | function|
|-|-|
|

## ls
| arg | function|
|-|-|
| -a | show .* files |
| -d | list directories, not their contents  |
| -g | like -l but do not list owner |
| -h | human readable |
| -r | reverse order |
| -R | lisst subdirectories recursively |
| -s | prints size of each file in blocks |
| -t | sort by time, newest = first  |

## ssh
ssh remote_username@remote_host

## tail 
with no given file it reads standard input
| arg | function|
|-|-|
| -f | follow |
| -n | output last n lines instead of the default of 10 | 
| -s  | with -f, sleep for given seconds between iterations |


## Top
| arg | function|
|-|-|
| -c | shows command line name |
| shift + m| sorts by memory |
| shift + f| sorts by selected field |

## PS
show processes 
| arg | function|
|-|-|
| -e | all process |
| -r | only running processes|
| -f | full format inclduing cmd lines |
