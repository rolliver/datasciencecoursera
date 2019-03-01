acs <- read.csv(url("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"))

library(sqldf)

f <- sqldf("select pwgtp1 from acs where AGEP < 50")

g <- sqldf("select distinct AGEP from acs")

jl2 <- readLines(  url("http://biostat.jhsph.edu/~jleek/contact.html") )

cf <- read.fwf (url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"), skip = 4,
               widths = c(11,8,4,9,4,9,4,9,4)
                
                )



cf