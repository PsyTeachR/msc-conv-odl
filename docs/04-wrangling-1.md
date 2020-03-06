
# Data wrangling 1

Data comes in lots of different formats. One of the most common formats is that of a two-dimensional table (the two dimensions being rows and columns).  Usually, each row stands for a separate observation (e.g. a subject), and each column stands for a different variable (e.g. a response, category, or group). A key benefit of tabular data is that it allows you to store different types of data-numerical measurements, alphanumeric labels, categorical descriptors-all in one place.

It may surprise you to learn that scientists actually spend far more of time cleaning and preparing their data than they spend actually analysing it. This means completing tasks such as cleaning up bad values, changing the structure of tables, merging information stored in separate tables, reducing the data down to a subset of observations, and producing data summaries. Some have estimated that up to 80% of time spent on data analysis involves such data preparation tasks (Dasu & Johnson, 2003)!

Many people seem to operate under the assumption that the only option for data cleaning is the painstaking and time-consuming cutting and pasting of data within a spreadsheet program like Excel. We have witnessed students and colleagues waste days, weeks, and even months manually transforming their data in Excel, cutting, copying, and pasting data. Fixing up your data by hand is not only a terrible use of your time, but it is error-prone and not reproducible. Additionally, in this age where we can easily collect massive datasets online, you will not be able to organise, clean, and prepare these by hand. 

In short, you will not thrive as a psychologist if you do not learn some key data wrangling skills. Although every dataset presents unique challenges, there are some systematic principles you should follow that will make your analyses easier, less error-prone, more efficient, and more reproducible.

In this lesson you will see how data science skills will allow you to efficiently get answers to nearly any question you might want to ask about your data. By learning how to properly make your computer do the hard and boring work for you, you can focus on the bigger issues.

## Tidyverse

Tidyverse (https://www.tidyverse.org/) is a collection of R packages created by world-famous data scientist Hadley Wickham. 

Tidyverse contains six core packages:  `dplyr`, `tidyr`, `readr`, `purrr`,  `ggplot2`, and `tibble`. Last week when you typed `library(tidyverse)` into R, you will have seen that it loads in all of these packages in one go. Within these six core packages, you should be able to find everything you need to wrangle and visualise your data. 

In this chapter, we are going to focus on the `dplyr` package, which contains six important functions: 

* `select()` Include or exclude certain variables (columns)
* `filter()` Include or exclude certain observations (rows)
* `mutate()` Create new variables (columns)
* `arrange()` Change the order of observations (rows)
* `group_by()` Organize the observations into groups
* `summarise()` Derive aggregate variables for groups of observations

These six functions are known as ’single table verbs’ because they only operate on one table at a time. Although the operations of these functions may seem very simplistic, it’s amazing what you can accomplish when you string them together: Hadley Wickham has claimed that 90% of data analysis can be reduced to the operations described by these six functions. 


## The `babynames` database

To demonstrate the power of the six `dplyr` verbs, we will use them to work with the babynames data from the `babynames` package. The babynames dataset has historical information about births of babies in the U.S.

## Activity 1: Set-up

Do the following. If you need help, consult Intro to R or Programming Basics.

* Open R Studio and set the working directory to your chapter folder. Ensure the environment is clear.  
* Open a new R Markdown document and save it in your working directory. Call the file "Data wrangling 1".    
* If you are working on your own computer, install the package `babynames`. Remember, **never install packages if you are working on a university computer**. 
* Delete the default R Markdown welcome text and insert a new code chunk that loads the packages `tidyverse` and `babynames` using `library()`.  


```r
library(tidyverse)
library(babynames)
```

## Activity  2: Load in the package

Today we need to use the `tidyverse` package. You will use this package in every single chapter of this book as the functions it contains are those we use for data wrangling, descriptive statistics, and visualisation.

* To load the `tidyverse` type the following code into your code chunk and then run it. 


```r
library(tidyverse)
```

### Open data

For this chapter we are going to be using real data from the following paper:

[Woodworth, R.J., O'Brien-Malone, A., Diamond, M.R. and Schüz, B., 2018. Data from, ‘Web-based Positive Psychology Interventions: A Reexamination of Effectiveness’. Journal of Open Psychology Data, 6(1).](https://openpsychologydata.metajnl.com/articles/10.5334/jopd.35/)

We recommend that you read through this paper and open up the .csv files in order to understand the data better but briefly, the files contains data from two scales, the  Authentic Happiness Inventory (AHI) and the Center for Epidemiological Studies Depression (CES-D) scale, as well as demographic information about participants. 

## Activity 3: Read in data

Now we can read in the data. To do this we will use the function `read_csv()` that allows us to read in .csv files. There are also functions that allow you to read in .xlsx files and other formats, however in this course we will only use .csv files.

* First, we will create an object called `dat` that contains the data in the `ahi-cesd.csv` file. Then, we will create an object called `info` that contains the data in the `participant-info.csv`.


```r
dat <- read_csv ("ahi-cesd.csv")
pinfo <- read_csv("participant-info.csv")
```


<div class="danger">
<p>There is also a function called <code>read.csv()</code>. Be very careful NOT to use this function instead of <code>read_csv()</code> as they have different ways of naming columns. For the portfolio tasks, unless your results match our exactly you will not get the marks which means you need to be careful to use the right functions.</p>
</div>

## Activity 4: Check yo' data

You should now see that the objects `dat` and `pinfo` have appeared in the environment pane. Whenever you read data into R you should always do an initial check to see that your data looks like you expected. There are several ways you can do this, try them all out to see how the results differ.

* In the environment pane, click on `dat` and `pinfo`. This will open the data to give you a spreadsheet-like view (although you can't edit it like in Excel)  
* In the environment pane, click the small blue play button to the left of `dat` and `pinfo`. This will show you the structure of the object information including the names of all the variables in that object and what type they are (also see `str(pinfo)`) 
* Use `summary(pinfo)`
* Use `head(pinfo)`
* Just type the name of the object you want to view, e.g., `dat`.

## Activity 5: Join the files together

We have two files, `dat` and `info` but what we really want is a single file that has both the data and the demographic information about the participants. R makes this very easy by using the function `inner_join()`.

Remember to use the help function `?inner_join` if you want more information about how to use a function and to use tab auto-complete to help you write your code.

The below code will create a new object `all_dat` that has the data from both `dat` and `pinfo` and it will use the columns `id` and `intervention` to match the participants' data. 

* Type and run this code and then view the new dataset using one of the methods from Activity 4.


```r
all_dat <- inner_join(x = dat, # the first table you want to join
                      y = pinfo, # the second table you want to join
                      by = 'id', 'intervention') # columns the two tables have in common
```

## Activity 6: Pull out variables of interest {#ref1}

Our final step is to pull our variables of interest. Very frequently, datasets will have more variables and data than you actually want to use and it can make life easier to create a new object with just the data you need.

In this case, the file contains the responses to each individual question on both the AHI scale and the CESD scale as well as the total score (i.e., the sum of all the individual responses). For our analysis, all we care about is the total scores, as well as the demographic information about participants.

To do this we use the `select()` function to create a new object named `summarydata`.


```r
summarydata <- select(.data = all_dat, # name of the object to take data from
                      ahiTotal, cesdTotal, sex, age, educ, income, occasion,elapsed.days) # all the columns you want to keep
```

* Type and run the above code and then run `head(summarydata)`. If everything has gone to plan it should look something like this:


 ahiTotal    cesdTotal    sex    age    educ    income    occasion    elapsed.days 
----------  -----------  -----  -----  ------  --------  ----------  --------------
    32          50         1     46      4        3          5           182.03    
    34          49         1     37      3        2          2           14.19     
    34          47         1     37      3        2          3           33.03     
    35          41         1     19      2        1          0            0.00     
    36          36         1     40      5        2          5           202.10    
    37          35         1     49      4        1          0            0.00     


Finally, try knitting the file to HTML. And that's it, well done! Remember to save your Markdown in your Chapter 2 folder and make a note of any mistakes you made and how you fixed them. You have started on your journey to become a confident and competent member of the open scientific community! 

## Debugging tips

* When you downloaded the files from Moodle did you save the file names **exactly** as they were originally? If you download the file more than once you will find your computer may automatically add a number to the end of the file name. `data.csv` is not the same as `data(1).csv`. Pay close attention to names!
* Have you used the **exact** same object names as we did in each activity? Remember, `name` is different to `Name`. In order to make sure you can follow along with this book, pay special attention to ensuring you use the same object names as we do.  
* Have you used quotation marks where needed?  
* Have you accidentally deleted any back ticks (```) from the beginning or end of code chunks?

## Test yourself

1. When loading in a .csv file, which function should you use? 

<select class='solveme' data-answer='["read_csv()"]'> <option></option> <option>read_csv()</option> <option>read.csv()</option></select>


<div class='solution'><button>Explain this answer</button>

Remember, in this course we use `read_csv()` and it is important for the portfolio assignment that you use this function otherwise you may find that the variable names are slightly different and you won't get the marks

</div>
 

<br>

2. The function `inner_join()` takes the arguments `x`, `y`, `by`. What does `by` do?

<select class='solveme' data-answer='["Specifies the column to join by that both tables have in common"]'> <option></option> <option>Specifies the first table to join</option> <option>Specifies the second table to join</option> <option>Specifies the column to join by that both tables have in common</option></select>

3. What does the function `select()` do? 
<br>
<select class='solveme' data-answer='["Keeps only the variables you specify"]'> <option></option> <option>Keeps only the observations you specify</option> <option>Keeps only the variables you specify</option> <option>Keeps only the objects you specify</option></select>
