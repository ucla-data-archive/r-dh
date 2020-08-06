library(janeaustenr) #jane austin books
library(dplyr)
library(stringr)

#source: https://www.tidytextmining.com/
#Tidy data
#Each variable is a column
#Each observation is a row
#Each type of observational unit is a table
#tidy text format as being a table with one-token-per-row

#The janeaustenr package provides these texts in a one-row-per-line format
#where a line in this context is analogous to a literal printed line in a physical book.
#Let’s start with that, and also use mutate() to annotate a linenumber quantity to keep
#track of lines in the original format and a chapter (using a regex) to find where all the chapters are.

original_books <- austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
                                                 ignore_case = TRUE)))) %>%
  ungroup()

#look at the original_books object we created
# note the column for line number and, chapter (we just added)
original_books

# Now we can tidy text it

library(tidytext) #the package
#create new object tidy_books by unnesting the words in original books
#creates the one token per row format
tidy_books <- original_books %>%
  unnest_tokens(word, text)

tidy_books

# we can remove stop words, lets see what those are
data(stop_words) #data will load them and then ew can print them out
stop_words
?stop_words

#We can remove stop words (kept in the tidytext dataset stop_words)
# with an anti_join().
# anti-join here will return a new dataframe without the stopwords

tidy_books <- tidy_books %>%
  anti_join(stop_words)

tidy_books

# finally we can visualize word frequencies using ggplot2

library(ggplot2)

tidy_books %>%
  count(word, sort = TRUE) %>%
  filter(n > 600) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()

# whew, that was a lot
# we tokenized the texts, removed stopwords
# then to visualize we counted up each word
# keeping only words that appear more than 600 times
# do a little sorting
# make a bar chart and flip it
#next steps, work with the gutenbergr package
# https://www.tidytextmining.com/tidytext.html#the-gutenbergr-package
