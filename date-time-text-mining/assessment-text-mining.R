# load gutenbergr, tidytext and tidyverse

library(tidyverse)
library(tidytext)
install.packages("gutenbergr")
library(gutenbergr)

head(gutenberg_metadata)

# what is the ID of Pride and Prejudice

gutenberg_metadata %>% filter(str_detect(title, "Pride and Prejudice"))


# what is the correct ID for Pride and Prejudice

gutenberg_works(title == "Pride and Prejudice")


# how many words are there in the book Pride and Prejudice

book <- gutenberg_download(1342)

head(book)

words <- book %>% unnest_tokens(words, text)

# remove stop_words from words

new_words <- words %>% filter(!words %in% stop_words$word)

# remove any token that contains a digit

new_words <- new_words %>% filter(!str_detect(words, "\\d+"))


# what is the most common word after removing stop_words and digits?

most_common <- new_words %>% group_by(words) %>% summarize(n = n()) %>% arrange(desc(n))

# how many words appear more than 100 times

most_common %>% filter(n > 100) %>% summarize(n())

# get afinn lexicon for sentiments and store in afinn

afinn <- get_sentiments("afinn")

# how many words in new_words have sentiments in afinn?

new_words <- new_words %>% rename(word = words)

afinn_sentiments <- inner_join(new_words, afinn)

head(afinn_sentiments)

# what proportion of words in afinn_sentiments have positive value?

afinn_sentiments %>% filter(value > 0) %>% summarize(n()/6065)

# how many afinn_sentiments elements have a value of 4

afinn_sentiments %>% filter(value == 4) %>% summarize(n())
