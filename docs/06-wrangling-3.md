# Data Wrangling 3

## Data wrangling recap

In the last chapter, we looked at using one-table Wickham verbs to `filter`, `arrange`, `group_by`, `select`, `mutate` and `summarise`. Now we will focus on working with data across two or more tables. The two main verbs we will practice adding to the Wickham six in this chapter are `pivot_longer()` and `inner_join()`and these will help you process your data for the your quantitative project in Research Methods 2.

* `pivot_longer()` allows us to **transform** a table from wide format to long format (more on this below).
* `inner_join()` allows us to **combine** two tables together based on common columns.

<div class="try">
<p>A function is a tool that takes an input, performs some action, and gives an output. They are nothing more than that. If you think about it your toaster is a function: it takes bread as an input; it performs the action of heating it up (nicely sometimes; on both sides would be a luxury); and it gives an output, the toast. A good thing about the Wickham six functions is that they are nicely named as verbs to describe what they do - <code>mutate()</code> mutates (adds on a column); <code>arrange()</code> arranges columns, <code>summarise()</code> summarises, etc.</p>
<p>In terms of remembering all the functions, the truth is you don’t have to know them all. However, through practice and repetition, you will quickly learn to remember which ones are which and what package they come from. Sort of like where to find your spoons in your kitchen - you don’t look in the fridge, and then the washing machine, and then the drawer. Nope, you learnt, by repetition, to look in the drawer first time. It’s the same with functions. Keep in mind that research methods is like a language in that the more you use it and work with it the more it makes sense.</p>
</div>

</div>


## Tidy data 

We will use a type of data organisation known as **tidy data** or sometimes **long-form data**. Any data in this format is easily processed through the `tidyverse` package. However, the data you work with will not always be formatted this way. If that happens then your first step is to put it into tidy data format. There are three fundamental rules defining Tidy Data:

1. Each variable must have its own column.
2. Each observation must have its own row.
3. Each value must have its own cell (i.e. no grouping two variables together, e.g. time/date in one cell). 
    i) A cell is where any specific row and column meet; a single data point in a tibble is a cell. 


<div class="try">
<p>If you’ve worked with any kind of data before, particularly if you’ve used Excel, it’s very likely that you will have used <strong>wide format</strong> data. In wide format, each participant’s data is all in one row with multiple columns for different data points. This means that the data set tends to be very wide and you will have as many rows as you have participants.</p>
<p>This layout can be easy to read, however, it makes programming quite difficult. Whilst Tidy Data can be conceptually more difficult to understand at first, it means you can manipulate your data in whatever way you want very easily.</p>
</div>

## Analysing the Autism Spectrum Quotient (AQ)

To continue building your data wrangling skills in this chapter you will tidy data from the Autism Spectrum Quotient (AQ) questionnaire. The AQ10 is a non-diagnostic short form of the AQ with only 10 questions per participant. It is a discrete scale and the higher a participant scores on the AQ10 the more autistic-like traits they are said to display. Anyone scoring 7 or above is recommended for further diagnosis. You can see an example of the AQ10 through this link: <a href="http://docs.autismresearchcentre.com/tests/AQ10.pdf">AQ10 Example</a>.  

There are 66 participants and your goal in this pre-class activity is to find an AQ score for each of them through your data-wrangling skills. 

There are four data files to work with that you should download into your chapter folder: 

* <a href="responses.csv" download>responses.csv</a> containing the AQ survey responses to each of the 10 questions for the 66 participants
* <a href="qformats.csv" download>qformats.csv</a> containing information on how a question should be coded - i.e. forward or reverse coding
* <a href="scoring.csv" download>scoring.csv</a> containing information on how many points a specific response should get; depending on whether it is forward or reverse coded 
* <a href="pinfo.csv" download>pinfo.csv</a> containing participant information such as Age, Sex and importantly `ID` number.  

<br>

<div class="try">
<p><code>csv</code> stands for ‘comma separated variable’, and is a very basic way of transferring data. It really just stores numbers and text and nothing else. The great thing about being this basic is that it can be read by many different machines and does not need expensive licenses to open it.</p>
</div>


## Activity 1: Set-up

Do the following. If you need help, consult Chapter \@ref(ref2) and Chapter \@ref(ref3).

* Open R Studio and set the working directory to your chapter folder. Ensure the environment is clear.  
* Open a new R Markdown document and save it in your working directory. Call the file "Data wrangling 3".    
* Download the four .csv files above and save them in your chapter folder. Make sure that you do not change the file names at all.
* Delete the default R Markdown welcome text and insert a new code chunk that loads the package `tidyverse` using the `library()` function. 


## Activity 2: Load in the data

Now you need to load in the `.csv` data files using the `read_csv()` function and save them as variables in the environment. For example, to load in the `responses` file we would type:


```r
responses <- read_csv("responses.csv") 
```

* Add the following lines of code to your Markdown and complete them to load in all four `.csv` data files. Use the above code as an example and name each variable the same as its original file name (minus the .csv part), again as above, e.g. `responses.csv` gets saved as `responses`. Remember to run the lines so that the data loaded in and is stored in your environment. 


```r
responses <-  read_csv()    # survey responses
qformats <-                 # question formats
scoring <-                  # scoring info
pinfo <-                    # participant information
```


## Activity 3: Look at your data

Now that we have the data loaded in it is always best to have a look at it to get an idea of its layout. We showed you ways of doing this before, but you can also use the `glimpse()` or `View()` functions in your Console window and put the name of the data between the brackets to see how it is arranged. Don't add these to your script though they are just one-offs for testing.

* Have a look at the data in `responses` to see if you think it is Tidy or not and answer the following question: The data in `responses` is in <select class='solveme' data-answer='["Wide"]'> <option></option> <option>Tidy</option> <option>Wide</option></select> format


<div class='solution'><button>Explain this answer</button>

The `responses` tibble is far from being tidy; each row represents multiple observations from the same participant, i.e. each row shows responses to multiple questions and there are the same number of rows as there are participants (66) - `wide format`. Remember we want the data in tidy format as described above.
    

</div>
  

## Activity 4: Tidying data {#gather}

We now have all the data we need loaded in, but in order to make it easier for us to get the AQ score for each participant, we need to change the layout of the `responses` tibble to Tidy Data using the `pivot_longer()` function. 

* Type the below code line into the Activity 4 code chunk and run it.


```r
rlong <- pivot_longer(data = responses, # the dataset we want to work on
                names_to = "Question", # the name of the column that will store what is currently the names of each column (question numbers)
                values_to = "Response", # the name of the new column that will store the values (data points)
                Q1:Q10) # the columns we want to put into long-form
```

<div class="warning">
<p><code>pivot_longer()</code> is a relatively new function in the tidyverse package. If you get an error message that says <code>could not find function pivot_longer()</code> you will need to update the tidyverse package by reinstalling it. You may also need to update R itself and other packages such a <code>rlang</code>.</p>
</div>

In case you are wondering if we wanted to go back the way,we would use the `pivot_wider()` function: e.g. `rwide <- pivot_wider(rlong, names_from = Questions, values_from = Response)`. But we do not want to do that here so let's not add this to the code. 

<div class="warning">
<p>In the code above we have used the notation <code>Q1:Q10</code>. This means ’select all the columns from Q1 to Q10. We could have written out the name of each column individually, for example <code>Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10</code> but obviously it is much easier to use the shorthand notation. You must be careful though to know what you are selecting. R isn’t clever enough to realise that what you want is all the Question columns - it would take any and all columns that exist between Q1 and Q10. This means that if your dataset is out of order you may end up selecting columns you didn’t mean to. Always look at your data and make sure you know the layout.</p>
</div>

* Look at the new dataset `rlong`. Compare it to the original dataset `responses` and try to understand how they relate to each other. 

## Activity 5: Combining data

Now the `responses` data is in tidy format, you are closer to being able to calculate an AQ score for each person. However, you still need some extra information:

* Is the question reverse or forward scored (i.e., is strongly agree a positive or negative response)? This information is found in `qformats`
* How many points are given to give a specific response? This information is found in `scoring`. 

This is a typical analysis situation where different information is in different tables and you need to join them altogether. Both these pieces of information are contained in `qformats` and `scoring` respectively, but we want to join them to `responses` to create one informative tidy table with all the information we need. We can do this through the function `inner_join()`; a function to combine information in two tibbles using a column common to both tibbles.

* Replace the `NULL` values in the below code with the necessary variable names to join `rlong` and `qformats` by `Question`. If you need extra help, revisit Chapter \@ref(join) - you used the same function then! You can also check the solutions for the answer (but make sure you try yourself first).


```r
rlong2 <- inner_join(x = NULL, y = NULL, by = "NULL")
```

* Now view `rlong2`. You have matched each question with its scoring format, `forward` or `reverse`.


<div class="try">
<p>A lot of questionnaires have some questions that are Forward scored and some questions that are Reverse scored. What does this mean? Imagine a situation where your options in replying to a question are: 1 - extremely agree, 2 - agree, 3 - neutral, 4 - disagree, 5 - extremely disagree. In a forward-scoring question you would get 1 point for extremely agree, 2 for agree, 3 for neutral, etc. In a reverse scoring question you would get 5 for extremely agree, 4 for agree, 3 for neutral, etc.</p>
<p>The reasoning behind this shift is that sometimes agreeing or disagreeing might be more favourable depending on how the question is worded. Secondly, sometimes these questions are used just to catch people out - imagine if you had two similar questions where one has the reverse meaning of the other. In this scenario, people should respond opposites. If they respond the same then they might not be paying attention.</p>
</div>
  
## Activity 6: Combining more data  

Now you need to combine the information in our new table, `rlong2`, with the `scoring` table so you know how many points to attribute each question based on the answer the participant gave, and whether the question was forward or reverse coded. Again, you can use the `inner_join()` function, but this time the common columns found in `rlong2` and `scoring` are `QFormat` and `Response`. To combine by two columns you just write them in sequence as shown below. **Note: when there is more than one common column between two tibbles you are joining, it is best to combine by all the columns to avoid repeat columns names in the new tibble.

* Type the below line into the Activity 6 code chunk, run it, and then view the new object. 


```r
# combine rows in rlong2 and scoring based on QFormat and Response
rscores <- inner_join(rlong2, scoring, c("QFormat", "Response"))
```

## Activity 7: Calculating the AQ scores.

You have now created `rscores` which has information on how each participant responded to each question and how each question should be coded and scored, all within the one tibble. All you need now is to sum the scores for each participant to get their AQ score. 

1. Based on your knowledge from the last chapter, type the below line into your code and replace the NULLs to obtain individual `aq_scores` for each participant.  
2. Save your Markdown and knit it to make sure all your code works. 


```r
aq_scores <- rscores %>% 
             group_by(NULL) %>% # how will you group individual participants?
             summarise(AQ = sum(NULL)) # which column will you sum to obtain AQ scores?
```


<div class='solution'><button>Helpful Hint</button>

Each participant could be grouped by their Id.

If we summed up the value for each Score we might get a full AQ Score for each particpipant.
    

</div>
  


## Activity 8: One last thing on pipes

You now have a complete code to load in your data, convert it to Tidy, combine the tables and calculate an AQ score for each participant. But, if you look at it, some of your code could be more efficient by using pipes. 

Go back through your code and try to rewrite it using pipes `%>%` so that it is as efficient as possible. 


<div class='solution'><button>Helpful Hint</button>


```r
At any point where the first argument of your function is the name of a variable created before that line, there is a good chance you could have used a pipe! Here are all the bits of this code that could be piped together into one chain:
    
`rlong <- pivot_longer(responses, names_to = "Question", values_to = "Response", Q1:Q10)`

`rlong2 <- inner_join(rlong, qformats, \"Question\")`

`rscores <- inner_join(rlong2, scoring, c(\"QFormat\", \"Response\"))`

`aq_scores <- rscores %>% group_by(Id) %>% summarise(AQ = sum(Score))`
```

</div>


<br>

You have now recapped one-table and two-table verbs. These are great to know as for example, in the above, it actually only took a handful of reproducible steps to get from messy data to tidy data; could you imagine doing this by hand in Excel through cutting and pasting? Not to mention the mistakes you could make!

If you have any questions, please post them on Teams.

## Activity solutions

Below you will find the solutions to the above questions. Only look at them after giving the questions a good try and trying to find help on Google or Teams about any issues.

### Activity 2


<div class='solution'><button>Activity 2</button>


```r
responses <- read_csv("responses.csv")                  
qformats <- read_csv("qformats.csv")                 
scoring <- read_csv("scoring.csv")                  
pinfo <- read_csv("pinfo.csv")
```

</div>


**Click the tab to see the solution**

### Activity 5


<div class='solution'><button>Solution Task 5</button>


```r
rlong2 <- inner_join(x = rlong, y = qformats, by = "Question")
```

</div>


**Click the tab to see the solution**

### Activity 7


<div class='solution'><button>Solution Task 7</button>


```r
aq_scores <- rscores %>% 
             group_by(Id) %>% # group by the ID number in column Id
             summarise(AQ = sum(Score)) # sum column Score to obtain AQ scores.
```

</div>


**Click the tab to see the solution**

### Activity 8


<div class='solution'><button>Activity 8</button>


```r
aq_scores2 <- responses %>% # take the data in `responses` and then
  pivot_longer(names_to = "Question", values_to = "Response", Q1:Q10) %>%  # gather up columns Q1 to Q10, put the column names in Question and the scores in Response and then
  inner_join(qformats, "Question") %>% # join with `qformats` and match the data by the column `Question` and then
  inner_join(scoring, c("QFormat", "Response")) %>% # join with `scoring` and match the data by the columns `Qformat` and `Response` and then
  group_by(Id) %>% # group by participant ID and then
  summarise(AQ = sum(Score)) # calculate the total AQ score
```

</div>


**Click the tab to see the solution**

## Test yourself

* You want to put the first three columns of a file called `responses` (Q1, Q2, Q3) into long-form, put the question numbers in a column called `Jam`, the responses in a column called `Strawberry`, and store everything in a tibble called `sandwich`. Fill in the box with what you would write: <input class='solveme nospaces' size='60' data-answer='["sandwich <- pivot_longer(data = responses, names_to = Jam, values_to = Strawberry, Q1:Q3)"]'/>


<div class='solution'><button>Explain this answer</button>


```r
sandwich <- pivot_longer(data = responses, names_to = "Jam", values_to = "Strawberry", Q1:Q3)
    
#`pivot_longer` wants the data first, then the name of the new column to store the column names, then the name of the new column to store the data, and then finally which columns to tidy
```

</div>


* Complete the sentence, the higher the AQ score...<select class='solveme' data-answer='["the more autistic-like traits displayed"]'> <option></option> <option>the less autistic-like traits displayed</option> <option>has no relation to autistic-like traits</option> <option>the more autistic-like traits displayed</option></select>  

* Type in the AQ score (just the number) of Participant ID No. 87: <input class='solveme nospaces' size='10' data-answer='["2"]'/>  

* Type how many participants had an AQ score of 3 (again just the number): <input class='solveme nospaces' size='10' data-answer='["13"]'/>  

* The cut-off for the AQ10 is usually said to be around 6 meaning that anyone with a score of more than 6 should be referred for diagnostic assessment. Type in how many participants we should refer from our sample: <input class='solveme nospaces' size='10' data-answer='["6"]'/>  


<div class='solution'><button>Explain these answers</button>

1. From the link above you can see that an appropriate citation for the AQ10 would be (Allison, Auyeung, and Baron-Cohen, (2012))

2. As mentioned, the higher the score on the AQ10 the more autistic-like traits a participant is said to show.

3. You could do this by code with `filter(aq_scores, Id == 87)`, which would give you a tibble of 1x2 showing the ID number and score. If you just wanted the score you could use `pull()` which we haven't shown you that yet: `filter(aq_scores, Id == 87) %>% pull(AQ)`. The answer is an AQ score of 2.

4. Same as above but changing the argument of the filter. `filter(aq_scores, AQ == 3) %>% count()`. The answer is 13. Remember you can do this by counting but the code makes it reproducible and accurate every time. You might make mistakes.

5. `filter(aq_scores, AQ > 6) %>% count()` or `filter(aq_scores, AQ >= 7) %>% count()`. The answer is 6.
        

</div>
  
