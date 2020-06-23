# load brexit_polls from dslabs. how many had startdate in april?

library(dslabs)
library(lubridate)
library(tidyverse)

brexit_polls %>% filter(month(startdate) == 4) %>% summarize(n = n())

# how many polls ended the week of 2016-06-12

brexit_polls %>% filter(round_date(enddate, unit = "week") == "2016-06-12") %>% summarize(n())


# on which weekday did greatest no. of polls end

brexit_polls %>% group_by(weekdays(enddate)) %>% summarize(n = n()) %>% arrange(desc(n))


# use movielens dataset from dslabs to answer the following
# 1. which year had the most movie reviews

movie <- movielens %>% mutate(review_year = year(as_datetime(timestamp)), 
                              review_hour = hour(as_datetime(timestamp)))

movie %>% group_by(review_year) %>% summarize(n = n()) %>% arrange(desc(n))


movie %>% group_by(review_hour) %>% summarize(n = n()) %>% arrange(desc(n))
