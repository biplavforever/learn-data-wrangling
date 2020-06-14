# load the url https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm

library(tidyverse)
library(rvest)

h <- read_html("https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm")

# load the table node 

node <- html_nodes(h, "table")


# view the content of 7th table

html_text(node[7])

html_text(node[[7]])

# convert to data frame

html_table(node[7])

# convert first 4 tables in node to data frame and inspect them

html_table(node[c(1, 2, 3, 4)], fill = TRUE)

# inspect last 3 tables of nodes

length(node)

html_table(node[21:23])

# create tab1 and tab2 for entries 10 and 19 of node respectively

tab1 <- html_table(node[[10]])
tab2 <- html_table(node[[18]])

# remove the median column of tab1 and rename Averge as Average

tab1 <- tab1 %>% rename(Average = Averge) %>% select(Team, Payroll, Average)

# remove the first row of tab2 and rename the columns as Team and Average

tab2 <- tab2[-1,] %>% rename(Team = X1, Payroll = X2, Average = X3)


# join tab1 and tab2 using full_join
new_tab <- full_join(tab1, tab2, by = "Team")


# read the url "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"

url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"

h <- read_html(url)

tab <- html_nodes(h, "table")

length(tab)

# which table has the first column "Date(s) conducted"?
html_table(tab[1:2], fill = TRUE)
html_table(tab[3:4])
head(html_table(tab[[5]], fill = TRUE))
