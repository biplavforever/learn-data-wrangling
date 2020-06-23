# load reported heights from dslabs

library(dslabs)
library(tidyverse)

data("reported_heights")

head(reported_heights)

# view class of height column

class(reported_heights$height)

# convert height column to numeric vector

h <- as.numeric(reported_heights$height)


# keep only values that result in NA's

heights_nas <- reported_heights %>% mutate(new_height = as.numeric(height)) %>%
  filter(is.na(new_height))

heights_nas

# add heights in cm to heights_nas

heights_num <- reported_heights %>% mutate(new_height = as.numeric(height)) %>%
  filter(!is.na(new_height))

alpha <- 0.000001
mean_male <- 69.1
sd_male <- 2.9
mean_female <- 63.7
sd_female <- 2.7

heights_inches <- c(qnorm(alpha, 63.7, 2.7), qnorm(1-alpha, 69.1, 2.9))

height_cm <- heights_num %>% filter(new_height > 82.9) %>% filter(new_height/2.54 <= 82.9)

heights_error <- full_join(height_cm, heights_nas)

nas <- heights_nas$height


# view which values have x'y" pattern

str_view(nas, "^[4-7]'\\d{1,2}\"$")


# replace all feet, foot, ft with "'" and replace all inches, in, '' with '"'

nas <- nas %>% str_replace("feet|foot|ft", "'")

nas <- nas %>% str_replace("inches|in|''|\"", '')

pattern_2 <- "^[4-7]\\s*'\\s*\\d{1,2}$"

data.frame(heights_nas$sex, nas)

solved_1 <- heights_nas %>% filter(str_detect(height, "^[4-7]'\\d{1,2}$"))

yet_unsolved <- setdiff(heights_nas, solved_1)

sum(str_detect(yet_unsolved$height, "^[4-7]'\\d{1,2}\"$")) 

solved_2 <- heights_nas %>% filter(str_detect(height, "^[4-7]'\\d{1,2}\"$")) %>%
  mutate(height = str_replace(height, '"', ''))

solve_process_1 <- heights_nas %>% filter(str_detect(height, "^[4-7]'\\d{1,2}\"$"))

yet_unsolved <- setdiff(yet_unsolved, solve_process_1)

solve_process_2 <- yet_unsolved %>% mutate(height = str_replace(height, "''", ""))

str_view(solve_process_2$height, "^([4-7])\\s*['\\s,\\.]\\s*(\\d*)\"?$")


solve_process_3 <- solve_process_2 %>% 
  filter(str_detect(height,"^([4-7])\\s*['\\s,\\.]\\s*(\\d*)\"?$"))

solved_3 <- solve_process_3 %>% 
  mutate(height = str_replace(height, "^([4-7])\\s*['\\s,\\.]\\s*(\\d*)\"?$", "\\1'\\2"))

yet_unsolved <- setdiff(solve_process_2, solve_process_3)

str_view(yet_unsolved$height, "feet|foot|ft")

solve_process_4 <- yet_unsolved %>% filter(str_detect(height, "feet|foot|ft") | 
                                              str_detect(height, "inches"))

solve_process_5 <- solve_process_4 %>% 
  mutate(height = str_replace(height, "feet|foot|ft", "'")) %>% 
  mutate(height = str_replace(height, "inches", ""))

solved_4 <- solve_process_5 %>% filter(str_detect(height, "^\\s*[4-7]\\s*'\\s*\\d\\s*$")) %>%
  mutate(height = str_replace(height, "^\\s*([4-7])\\s*'\\s*(\\d)\\s*$", "\\1'\\2"))


yet_unsolved <- yet_unsolved %>% 
  mutate(height = str_replace(height, "feet|foot|ft", "'")) %>% 
  mutate(height = str_replace(height, "inches", ""))

solve_process_6 <- yet_unsolved %>% filter(str_detect(height, "^\\s*[4-7]\\s*'\\s*\\d\\s*$"))


yet_unsolved <- setdiff(yet_unsolved, solve_process_6)
