# t-tests

Two-sample designs are very common as often we want to know whether there is a difference between groups on a particular variable.  There are different types of two-sample designs depending on whether or not the two groups are independent (e.g. different participants on different conditions) or not (e.g. same participants on different conditions).  In this lab we will perform one test of each type.

<div class="try">
<p>One of the really confusing things about research design is that there are many names for the same type of design.</p>
<ul>
<li>Independent and between-subjects design typically mean the same thing - different participants in different conditions</li>
<li>Within-subjects, dependent, paired samples, and repeated-measures tend to mean the same participants in all conditions</li>
<li>Matched pairs design means different people in different conditions but you have matched participants across the conditions so that they are effectively the same person (e.g. age, IQ, Social Economic Status, etc)</li>
<li>Mixed design is when there is a combination of within-subjects and between-subjects designs in the one experiment. For example, say you are looking at attractiveness and dominance of male and female faces. Everyone might see both male and female faces (within) but half of the participants do ratings of attractiveness and half do ratings of trustworthiness (between).</li>
</ul>
</div>


For the independent t-test we will be using data from Schroeder and Epley (2015). You can take a look at the Psychological Science article here:

[Schroeder, J. and Epley, N. (2015). The sound of intellect: Speech reveals a thoughtful mind, increasing a job candidate's appeal. Psychological Science, 26, 277--891.](https://doi.org/10.1177/0956797615572906)

The abstract from this article explains more about the different experiments conducted (we will be specifically looking at the dataset from Experiment 4, courtesy of the [Open Stats Lab](https://sites.trinity.edu/osl/data-sets-and-activities/t-test-activities):

> A person's mental capacities, such as intellect, cannot be observed directly and so are instead inferred from indirect cues. We predicted that a person's intellect would be conveyed most strongly through a cue closely tied to actual thinking: his or her voice. Hypothetical employers (Experiments 1-3b) and professional recruiters (Experiment 4) watched, listened to, or read job candidates' pitches about why they should be hired. These evaluators (the employers) rated a candidate as more competent, thoughtful, and intelligent when they heard a pitch rather than read it and, as a result, had a more favourable impression of the candidate and were more interested in hiring the candidate. Adding voice to written pitches, by having trained actors (Experiment 3a) or untrained adults (Experiment 3b) read them, produced the same results. Adding visual cues to audio pitches did not alter evaluations of the candidates. For conveying one's intellect, it is important that one's voice, quite literally, be heard.

To summarise, 39 professional recruiters from Fortune 500 companies evaluated job pitches of M.B.A. candidates from the University of Chicago Booth School of Business. The methods and results appear on pages 887--889 of the article if you want to look at them specifically for more details. The original data, in **wide** format, can be found at the [Open Stats Lab](https://drive.google.com/open?id=0Bz-rhZ21ShvOei1MM24xNndnQ00) website for later self-directed learning. Today however, we will be working with a modified version in "tidy" format which can be downloaded from Moodle. 

## Activity 1: Set-up

Your task is to reproduce the results from the article (p. 887). 

* Open R Studio and set the working directory to your Week 7 folder. Ensure the environment is clear.   
* Open a new R Markdown document and save it in your working directory. Call the file "Week 7".    
* Download <a href="evaluators.csv" download>evaluators.csv</a> and <a href="ratings.csv" download>rating.csv</a> and save them in your Week 7 folder. Make sure that you do not change the file name at all.    
* Delete the default R Markdown welcome text and insert a new code chunk that loads `broom`, `car`, `lsr`,  and `tidyverse` using the `library()` function and loads the data into an object named `evaluators` using `read_csv()`



## Activity 2: Explore the dataset

There are a few things we should do to explore the dataset and make working with it a bit easier. You have done all of these tasks before, use the book search function if you can't remember how to do them. As always the solutions are at the bottom but you will learn faster if you can solve the problem yourself.

* Use `mutate()` and `recode()` to recode `sex` into a new variable `sex_labels` so that `1` = `male` and `2` = `female`. Be careful - there are multiple functions in different packages called recode, make sure to specify `dplyr::recode()` to get the right one.
* Use `mutate()` and `as.factor()` to overwrite `sex_labels` and `condition` as factors.  
* Use `summary()` to get an overview of the missing data points in each variable.



* How many participants were noted as being female: <input class='solveme nospaces' size='2' data-answer='["30"]'/>
* How many participants were noted as being male: <input class='solveme nospaces' size='1' data-answer='["4"]'/>
* How many data points are missing for `sex`? <input class='solveme nospaces' size='1' data-answer='["5"]'/>

## Activity 3: Ratings

We are now going calculate an overall intellect rating given by each evaluator - how intellectual the evaluators thought candidates were overall depending on whether or not the evaluators **read** or **listened** to the candidates' resume pitches. This is calculated by averaging the ratings of `competent`, `thoughtful` and `intelligent` for each evaluator; held within `ratings.csv`. **Note:** we are not looking at ratings to individual candidates; we are looking at overall ratings for each evaluator. This is a bit confusing but makes sense if you stop to think about it a little.

We will then combine the overall intellect rating with the overall impression ratings and overall hire ratings for each evaluator, with the end goal of having a tibble called `ratings2` - which has the following structure:


 eval_id  Category      Rating  condition   sex_labels 
--------  -----------  -------  ----------  -----------
       1  hire           6.000  listened    female     
       1  impression     7.000  listened    female     
       1  intellect      6.000  listened    female     
       2  hire           4.000  listened    female     
       2  impression     4.667  listened    female     
       2  intellect      5.667  listened    female     

The following steps describe how to create the above tibble - if you're feeling comfortable with R, try yourself without using our code. The trick when doing data analysis and data wrangling is to first think about what you want to achieve - the end goal - and then think about what functions you need to use to get there. 

Steps 1-3 calculate the new `intellect` rating. Steps 4 and 5 combine this rating to all other information.

1. Load the data found in `ratings.csv` into a tibble called `ratings`. 

2. `filter()` only the relevant variables (**thoughtful**, **competent**, **intelligent**) into a new tibble (call it what you like - we use `iratings`), and calculate a mean `Rating` for each evaluator.  

3. Add on a new column called `Category` where every entry is the word `intellect`. This tells us that every number in this tibble is an intellect rating.  

4. Now create a new tibble called `ratings2` and filter into it just the "impression" and "hire" ratings from the original `ratings` tibble. Next, bind this tibble with the tibble you created in step 3 to bring together the intellect, impression, and hire ratings, in `ratings2`.  

5. Join `ratings2` with the `evaluator` tibble that we created in Task 1. Keep only the necessary columns as shown above and arrange by Evaluator and Category.


```r
# 1. load in the data
ratings <- read_csv("ratings.csv")

# 2. first step: pull out the ratings associated with intellect
iratings <- ratings %>%
  filter(Category %in% c("competent", "thoughtful", "intelligent"))

# second step: calculate means for each evaluator
imeans <- iratings %>%
  group_by(eval_id) %>%
  summarise(Rating = mean(Rating))

# 3. add Category variable 
# this way we can combine with 'impression' and 'hire' into a single table, very useful!
imeans2 <- imeans %>%
  mutate(Category = "intellect")

# 4. & 5. combine into a single table
ratings2 <- ratings %>%
  filter(Category %in% c("impression", "hire")) %>%
  bind_rows(imeans2) %>%
  inner_join(evaluators, "eval_id") %>%
  select(-age, -sex) %>%
  arrange(eval_id, Category)
```

## Activity 4: Visualisation

You should **always** visualise your data before you run a statistical analysis. Not only will it help you interpret the results of the test but it will give you a better understanding of the spread of your data. For comparing two means, we can take advantage of the many plotting options R provides so we don't have to settle for a boring (and more importantly, uninformative, bar plot).

To visualise our data we are going to create a violin-boxplot.

`geom_violin()` represents density. The fatter the plot, the more data points there are for that . The reason is is called a violin plot is because if your data are normally distributed it should look something like a violin.  
`geom_boxplot()` shows the median and inter-quartile range (see [here](https://towardsdatascience.com/understanding-boxplots-5e2df7bcbd51) if you would like more information). The boxplot can also give you a good idea if the data are skewed - the median line should be in the middle of the box, if it's not, chances are the data are skewed.  
`geom_pointrange()` will show the mean and confidence intervals. If you're conducting a test that is comparing means, it's a good idea to add in the means.  

* Run the below code to produce the plot. It is a good idea to save code 'recipes' for tasks that you will likely want to repeat in the future. You do not need to memorise lines of code, you only need to understand how to alter examples to work with your specific data set.
* Try setting `trim = TRUE`, `show.legend = FALSE` and altering the value of `width` to see what these arguments do.  


```r
# create summary data to use with `geom_pointrange()`
summary_dat<-ratings2%>%
  group_by(condition)%>%
  summarise(mean = mean(Rating),
            min = mean(Rating) - qnorm(0.975)*sd(Rating)/sqrt(n()), #confidence intervals
            max = mean(Rating) + qnorm(0.975)*sd(Rating)/sqrt(n()))


ggplot(ratings2, aes(x = condition, y = Rating)) +
  geom_violin(trim = FALSE) +
  geom_boxplot(aes(fill = condition), width = .2, show.legend = FALSE) + 
  geom_pointrange(data = summary_dat,
                  aes(x = condition, y = mean, ymin=min, ymax=max),
                  shape = 20, 
                  position = position_dodge(width = 0.1), show.legend = FALSE)
```

* Look at the plot. In which condition did the evaluators give the higher ratings? <select class='solveme' data-answer='["listened"]'> <option></option> <option>listened</option> <option>read</option></select>

## Activity 5: Assumptions

Before we run the t-test we need to check that the data meet the assumptions for a Welch t-test.

1. The data are interval/ratio
2. The data are independent
3. The residuals are normally distributed for each group

We know that 1 and 2 are true from the design of the experiment, the measures used, and by looking at the data. To test assumption 3, we can create a QQ-plot of the **residuals**. For a between-subject t-test the residuals are the difference between the mean of each group and each data point. E.g., if the mean of group A is 10 and a participant in group A scores 12, the residual for that participant is 2.

* Run the below code to calculate then plot the residuals. Based upon the plot, do the data meet the assumption of normality? <select class='solveme' data-answer='["Yes"]'> <option></option> <option>Yes</option> <option>No</option></select>


```r
ratings2 <- ratings2 %>%
  group_by(condition) %>%
  mutate(group_resid = Rating - mean(Rating)) %>%
  ungroup()

qqPlot(ratings2$group_resid)
```

We can also use a new test that will statistically test the residuals for normality, the **Shapiro-Wilk** test. `shapiro.wilk()` from Base R assesses if the distribution is significantly different from a normal distribution, so, if the test is significant it means your data is not normal, and if it is non-significant it means it is approximately normal. 

* Run the below code. According to the Shapiro-Wilk test, is the data normally distributed? <select class='solveme' data-answer='["Yes"]'> <option></option> <option>Yes</option> <option>No</option></select>


```r
shapiro.test(x = ratings2$group_resid)
```


<div class='solution'><button>Explain this answer</button>

The p-value is .2088 which is more than .05, the cut-off for statistical significance. 
    

</div>
  
<br>

* Think back to the lecture. If you ran a Student's t-test instead of a Welch t-test, what would the 4th assumption be? <select class='solveme' data-answer='["Homogeneity of variance"]'> <option></option> <option>Homogeneity of variance</option> <option>Homoscedascity</option> <option>Nominal data</option></select>    
* Why should you always use a Welch test instead of a Student t-test? <select class='solveme' data-answer='["Because it performs better if sample sizes and variances are unequal and gives the same result when sample sizes and variances are equal"]'> <option></option> <option>Because it rhymes with squelch which is a funny word</option> <option>Because you are more likely to obtain a signifcant p-value than with Student's t-test when sample sizes and variances are equal</option> <option>Because it performs better if sample sizes and variances are unequal and gives the same result when sample sizes and variances are equal</option></select>.

## Activity 6: Running the t-test

We are going to conduct t-tests for the Intellect, Hire and Impression ratings separately; each time comparing evaluators' overall ratings for the listened group versus overall ratings for the read group to see if there was a significant difference between the two conditions: i.e. did the evaluators who **listened** to pitches give a significant higher or lower rating than evaluators that **read** pitches.

* First, calculate the mean and SD for each condition and category.


```r
group_means <- ratings2 %>%
  group_by(condition, Category) %>%
  summarise(m = mean(Rating), sd = sd(Rating))
```

* Next, create separate data sets for the intellect, hire, and impression data using `filter()`. We have completed intellect for you.




```r
intellect <- filter(ratings2, Category == "intellect")
hire <- 
impression <- 
```

As you may have realised by now, most of the work of statistics involves the set-up - running the tests is generally very simple. To conduct the t-test we will use `t.test()` from Base R. This function uses a style of code you haven't come across yet but that is very important to get used to, **formula syntax**.


```r
results_intellect <- t.test(Rating ~ condition, paired = FALSE, data = intellect) %>% tidy()
```

* `~` is called a tilde. It can be read as 'by'.  
* The variable on the left of the tilde is the dependent or outcome variable. 
* The variable(s) on the right of the tilde is the independent or predictor variable.  
* You can read the below code as 'run a t-test for rating score by condition'.
* `paired = FALSE` indicates that we do not want to run a paired-samples test and that our data is from a between-subjects design.  

Just like we did with the correlation, we are also going to use `tidy()` to convert the output to a more manageable format.

* Run the above code and then view the `results_intellect`.

The output is in a nice table format that makes it easy to extract individual values but it is worth explaining what each variable means:

* `estimate` is the difference between the two means
* `estimate1` is the mean of group 1  
* `estimate2` is the mean of group 2  
* `statistic` is the t-statistic  
* `p.value` is the p-value  
* `parameter` is the degrees of freedom  
* `con.low` and `conf.high` are the confidence interval of the `estimate`
* `method` is the type of test, Welch, Student, paired, or one-sample
* `alternative` is whether the test was one or two-tailed  

* Complete the code to run the t-tests for the hire and impression ratings and view the results.




```r
results_hire <- 
results_impression <- 
```

<div class="warning">
<p>What do you do if the data don’t meet the assumption of normality? There are a few options.</p>
<ol style="list-style-type: decimal">
<li>Transform your data to try and normalise the distribution. We won’t cover this but if you’d like to know more, <a href="https://www.researchgate.net/profile/Jason_Osborne2/publication/200152356_Notes_on_the_Use_of_Data_Transformations/links/0deec5295f1eb10df8000000.pdf">this page</a> is a good start.</li>
<li>Use a non-parametric test. The non-parametric equivalent of the independent t-test is the Mann-Whitney and the equivalent of the paired-samples t-test is the Wilcoxon. See the Supplementary Analyses chapter for more information.</li>
<li>Do nothing. <a href="https://www.rips-irsp.com/articles/10.5334/irsp.82/">Delacre, Lakens &amp; Leys, 2017</a> argue that with a large enough sample (&gt;30), the Welch test is robust and that using a two-step process actually causes more problems than it solves.</li>
</ol>
</div>

## Activity 8: Correcting for multiple comparisons

Because we've run three t-tests we risk inflating our chances of a Type 1 errors due to familywise error. To correct for this we can apply a correction for multiple comparisons.

To do this first of all we need to join all the results of the t-tests 
together using `bind_rows()`. First, you specify all of the individual tibbles you want to join and give them a label, and then you specify what the ID column should be named.




```r
results <- bind_rows(hire = results_hire, impression = results_impression, intellect = results_intellect, .id = "test")
```


    test       estimate    estimate1    estimate2    statistic     p.value     parameter    conf.low     conf.high            method             alternative 
------------  ----------  -----------  -----------  -----------  -----------  -----------  -----------  -----------  -------------------------  -------------
    hire       1.825397    4.714286     2.888889     2.639949     0.0120842    36.85591     0.4241979    3.226596     Welch Two Sample t-test     two.sided  
 impression    1.894333    5.968333     4.074000     2.817175     0.0080329    33.80061     0.5275086    3.261158     Welch Two Sample t-test     two.sided  
 intellect     1.986722    5.635000     3.648278     3.478555     0.0014210    33.43481     0.8253146    3.148130     Welch Two Sample t-test     two.sided  

Now, we're going to add on a column of adjusted p-values using `p.adj()` and `mutate()`. 

* Run the below code and then view the adjusted p-values. Are they larger or smaller than the original values? <select class='solveme' data-answer='["Larger"]'> <option></option> <option>Larger</option> <option>Smaller</option></select>


```r
results <- results %>%
  mutate(p.adjusted = p.adjust(p = p.value, # the column that contains the original p-values
                               method = "bonferroni")) # type of correction to apply
```

## Activity 7: Effect size

Before we interpret and write-up the results our last task is to calculate the effect size which for a t-test is Cohen's D. To do this, we will use the function `cohensD()` from the `lsr` package. The code is very simple, it is very similar to the syntax for `t.test()`. The only difference is rather than `paired = FALSE`, you must specify `method = "unequal"` which indicates that we conducted a Welch test (see the help documentation for more information). 

* Run the below code and then calculate the effect sizes for hire and impression




```r
intellect_d <- cohensD(Rating ~ condition, method = "unequal", data = intellect)
hire_d <- 
impression_d <- 
```

## Activity 8: Interpreting the results

* Were your results for `hire` significant? Enter the mean estimates and t-test results (means and t-value to 2 decimal places, p-value to 3 decimal places). Use the adjusted p-values:

    + Mean `estimate1` (listened condition) = <input class='solveme nospaces' size='4' data-answer='["4.71"]'/>  
    
    + Mean `estimate2` (read condition) = <input class='solveme nospaces' size='4' data-answer='["2.89"]'/>  
    
    + t(<input class='solveme nospaces' size='2' data-answer='["37"]'/>) = <input class='solveme nospaces' size='4' data-answer='["2.62"]'/>, p = <input class='solveme nospaces' size='5' data-answer='["0.036",".036"]'/>  
    

* Were your results for `impression` significant? Enter the mean estimates and t-test results (means and t-value to 2 decimal places, p-value to 3 decimal places):

    + Mean`estimate1` (listened condition) = <input class='solveme nospaces' size='4' data-answer='["5.97"]'/>  
    
    + Mean `estimate2` (read condition) = <input class='solveme nospaces' size='4' data-answer='["4.07"]'/>  
    
    + t(<input class='solveme nospaces' size='2' data-answer='["37"]'/>) = <input class='solveme nospaces' size='4' data-answer='["2.85"]'/>, p = <input class='solveme nospaces' size='5' data-answer='["0.024",".024"]'/> 

* According to Cohen's (1988) guidelines, the effect sizes for all three tests are <select class='solveme' data-answer='["Large"]'> <option></option> <option>Small</option> <option>Medium</option> <option>Large</option></select>

## Activity 9: Write-up

Copy and paste the below **exactly** into **white space** in your R Markdown document and then knit the file to replicate the results section in the paper (p.887). 

* Note that we haven't replicated the analysis exactly - the authors of this paper conducted Student's t-test whilst we have conducted Welch tests and we've also applied a multiple comparison correction. Look back at the paper and see what differences this makes. 


```r
The pattern of evaluations by professional recruiters replicated the pattern observed in Experiments 1 through 3b (see Fig. 7). Bonferroni-corrected t-tests found that in particular, the recruiters believed that the job candidates had greater intellect---were more competent, thoughtful, and intelligent---when they listened to pitches (M = `r results_intellect$estimate1%>% round(2)`, SD = `r round(group_means$sd[3], 2)`) than when they read pitches (M = `r results_intellect$estimate1%>% round(2)`, SD = `r round(group_means$sd[6], 2)`), t(`r round(results_intellect$parameter, 2)`) = `r round(results$statistic,2)`, p < `r results$p.adjusted[3] %>% round(3)`, 95% CI of the difference = [`r round(results_intellect$conf.low, 2)`, `r round(results_intellect$conf.high, 2)`], d = `r round(intellect_d,2)`. 

The recruiters also formed more positive impressions of the candidates---rated them as more likeable and had a more positive and less negative impression of them---when they listened to pitches (M = `r results_impression$estimate1%>% round(2)`, SD = `r round(group_means$sd[2], 2)`) than when they read pitches (M = `r results_impression$estimate2%>% round(2)`, SD = `r round(group_means$sd[5], 2)`, t(`r round(results_impression$parameter,2)`) = `r round(results_impression$statistic,2)`, p < `r results$p.adjusted[2] %>% round(3)`, 95% CI of the difference = [`r round(results_impression$conf.low, 2)`, `r round(results_impression$conf.high, 2)`], d = `r round(impression_d, 2)`. 

Finally, they also reported being more likely to hire the candidates when they listened to pitches (M = `r results_hire$estimate1 %>% round(2)`, SD = `r round(group_means$sd[1], 2)`) than when they read the same pitches (M = `r results_hire$estimate2 %>% round(2)`, SD = `r round(group_means$sd[4],2)`), t(`r round(results_hire$parameter,2)`) = `r round(results_hire$statistic,2)`, p < `r results$p.adjusted[1] %>% round(3)`, 95% CI of the difference = [`r round(results_hire$conf.low, 2)`, `r round(results_hire$conf.high, 2)`], d = `r round(hire_d,2)`.
```


> The pattern of evaluations by professional recruiters replicated the pattern observed in Experiments 1 through 3b (see Fig. 7). Bonferroni-corrected t-tests found that in particular, the recruiters believed that the job candidates had greater intellect---were more competent, thoughtful, and intelligent---when they listened to pitches (M = 5.64, SD = 1.61) than when they read pitches (M = 5.64, SD = 1.91), t(33.43) = 2.64, 2.82, 3.48, p < 0.004, 95% CI of the difference = [0.83, 3.15], d = 1.12. 

> The recruiters also formed more positive impressions of the candidates---rated them as more likeable and had a more positive and less negative impression of them---when they listened to pitches (M = 5.97, SD = 1.92) than when they read pitches (M = 4.07, SD = 2.23, t(33.8) = 2.82, p < 0.024, 95% CI of the difference = [0.53, 3.26], d = 0.91. 

> Finally, they also reported being more likely to hire the candidates when they listened to pitches (M = 4.71, SD = 2.26) than when they read the same pitches (M = 2.89, SD = 2.05), t(36.86) = 2.64, p < 0.036, 95% CI of the difference = [0.42, 3.23], d = 0.84.

## Activity 10: Paired-samples t-test

For the final activity we will run a paired-samples t-test for a within-subject design but we will do this much quicker than for the Welch test and just point out the differences in the code.

For this example we will again draw from the [Open Stats Lab](https://sites.trinity.edu/osl/data-sets-and-activities/t-test-activities) and look at data from the following paper:

[Mehr, S. A., Song. L. A., & Spelke, E. S. (2016). For 5-month-old infants, melodies are social. Psychological Science, 27, 486-501.](https://journals.sagepub.com/stoken/default+domain/d5HcBHg85XamSXGdYqYN/full)

Parents often sing to their children and, even as infants, children listen to and look at their parents while they are singing. Research by Mehr, Song, and Spelke (2016) sought to explore the psychological function that music has for parents and infants, by examining the hypothesis that particular melodies convey
important social information to infants. Specifically, melodies convey information about social affiliation.

The authors argue that melodies are shared within social groups. Whereas children growing up in one culture may be exposed to certain songs as infants (e.g., “Rock-a-bye Baby”), children growing up in other cultures (or even other groups within a culture) may be exposed to different songs. Thus, when a novel person (someone who the infant has never seen before) sings a familiar song, it may signal to the infant that this new person is a member of their social group.

To test this hypothesis, the researchers recruited 32 infants and their parents to complete an experiment. During their first visit to the lab, the parents were taught a new lullaby (one that neither they nor their infants had heard before). The experimenters asked the parents to sing the new lullaby to their child every day for the next 1-2 weeks. Following this 1-2 week exposure period, the parents and their infant returned to the lab to complete the experimental portion of the study. Infants were first shown a screen with side-by-side videos of two unfamiliar people, each of whom were silently smiling and looking at the infant. The researchers recorded the looking behaviour (or gaze) of the infants during this ‘baseline’ phase. Next, one by one, the two unfamiliar people on the screen sang either the lullaby that the parents learned or a different lullaby (that had the same lyrics and rhythm, but a different melody). Finally, the infants saw the same silent video used at baseline, and the researchers again recorded the looking behaviour of the infants during this ‘test’ phase. For more details on the experiment’s methods, please refer to Mehr et al. (2016) Experiment 1. 


* First, download <a href="Mehr Song and Spelke 2016 Experiment 1.csv" download>Mehr Song and Spelke 2016 Experiment 1.csv</a> and run the below code to load and wrangle the data into the format we need - this code selects only the data we need for the analysis and renames variables to make them easier to work with.


```r
gaze <- read_csv("Mehr Song and Spelke 2016 Experiment 1.csv") %>%
  filter(exp1 == 1) %>%
  select(id, Baseline_Proportion_Gaze_to_Singer,Test_Proportion_Gaze_to_Singer) %>%
  rename(baseline = Baseline_Proportion_Gaze_to_Singer,
         test = Test_Proportion_Gaze_to_Singer)
```

## Activity 12: Assumptions

The assumptions for the paired-samples t-test are a little different (although very similar) to the independent t-test.

1. The dependent variable must be continuous (interval/ratio).  
2. All participants should appear in both conditions/groups. 
3. The difference scores should be normally distributed. 

Aside from the data being paired rather than independent, the key difference is that for the paired-samples test, the assumption of normality if that the differences between each pair of scores are normally distributed, rather than the scores themselves.

* Run the below code to calculate the difference scores and then conduct the Shapriro-Wilk and QQ-plot as with the independent test.


```r
gaze <- gaze %>%
  mutate(diff = baseline - test)
```

As you can see, from both the Shapiro-Wilk test and the QQ-plot, the data meet the assumption of normality so we can proceed.

## Activity 13: Descriptives and visualisations

It made sense to keep the data in wide-form until this point to make it easy to calculate a column for the difference score, but now we will transform it to tidy data so that we can easily create descriptives and plot the data using `tidyverse` tools.

* Run the below code to tidy the data and calculate descriptives and then create the same violin-boxplot as you did for the independent t-test (hint: it is perfectly acceptable to copy and paste the code from above and change the data and variable names).


```r
gaze_tidy <- gaze %>%
  gather(key = time, value = looking, baseline, test) %>%
  select(-diff) %>%
  arrange(time, id)

gaze_descriptives <- gaze_tidy %>%
  group_by(time) %>%
  summarise(mean_looking = mean(looking, na.rm = TRUE),
            sd_looking = sd(looking, na.rm = TRUE))
```

## Activity 14: Paired-samples t-test

Finally, we can calculate the t-test and the effect size. The code is almost identical to the independent code with two differences:

1. In `t.test()` you should specify `paired = TRUE` rather than `FALSE`
2. In `cohensD()` you should specify `method = paired` rather than `unequal`

* Run the t-test and calculate the effect size. Remember to use `tidy()`.




```r
gaze_test <- 
gaze_d <- 
```


<div class="warning">
<p>When you run <code>cohensD</code> you will get a warning that tells you “Results will be incorrect if cases do not appear in the same order for both levels of the grouping factor”. What this means it that R has to figure out which pairs of data belong together and it does this by position. It will assume that the first data point in the baseline condition will be the same participant as the first data point in the test condition. The easiest way to ensure this is the case is to use <code>arrange()</code> to sort your data. If you look back at the code we used to tidy the data above you will see that we manually sorted the data at the end. This will avoid any problems.</p>
</div>

The output of the paired-samples t-test is very similar to the independent test, with one exception. Rather than providing the means of both conditions, there is a single `estimate`. This is the mean difference score between the two conditions.

* Enter the mean estimates and t-test results (means and t-value to 2 decimal places, p-value to 3 decimal places):

    + Mean `estimate` = <input class='solveme nospaces' size='5' data-answer='["-0.07"]'/>  
    
    + t(<input class='solveme nospaces' size='2' data-answer='["31"]'/>) = <input class='solveme nospaces' size='4' data-answer='["2.42"]'/>, p = <input class='solveme nospaces' size='5' data-answer='["0.022",".022"]'/> 
    
## Activity 15: Write-up

Copy and paste the below **exactly** into **white space** in your R Markdown document and then knit the file to replicate the results section in the paper (p.489). 


```r
At test, however, the infants selectively attended to the now-silent singer of the song with the familiar melody; the proportion of time during which they looked toward her was...greater than the proportion at baseline (difference in proportion of looking: M = `r gaze_test$estimate %>% round(2)`, SD = `r sd(gaze$diff, na.rm = TRUE) %>% round(2)`, 95% CI = [`r gaze_test$conf.low %>% round(2)`, `r gaze_test$conf.high %>% round(2)`]), t(`r gaze_test$parameter`) = `r gaze_test$statistic %>% round(2)`, p = `r gaze_test$p.value %>% round(3)`, d = `r gaze_d %>% round(2)`.
```

>At test, however, the infants selectively attended to the now-silent singer of the song with the familiar melody; the proportion of time during which they looked toward her was...greater than the proportion at baseline (difference in proportion of looking: M = -0.07, SD = 0.17, 95% CI = [-0.13, -0.01]), t(31) = -2.42, p = 0.022, d = 0.43.

### Finished!

That was a long lab but now that you've done three types of statistical tests (chi-square, correlations, t-test) hopefully you will see that it really is true that the hardest part is the set-up and the data wrangling. As we've said before, you don't need to memorise lines of code - you just need to remember where to find examples and to understand which bits of them you need to change. Play around with the examples we have given you and see what changing the values does.

## Activity solutions

### Activity 1


<div class='solution'><button>Activity 1</button>


```r
library("broom")
library("car")
library("lsr")
library("tidyverse")
evaluators <- read_csv("evaluators.csv")
```

</div>
  

**click the tab to see the solution**
<br>

### Activity 2


<div class='solution'><button>Activity 2</button>


```r
evaluators <- evaluators %>%
  mutate(sex_labels = dplyr::recode(sex, "1" = "male", "2" = "female"),
         sex_labels = as.factor(sex_labels),
         condition = as.factor(condition))
summary(evaluators)
```

</div>
  

**click the tab to see the solution**
<br>

### Activity 6


<div class='solution'><button>Activity 6</button>


```r
intellect <- filter(ratings2, Category == "intellect")
hire <- filter(ratings2, Category == "hire")
impression <- filter(ratings2, Category == "impression")
```

</div>
  

**click the tab to see the solution**
<br>

### Activity 7


<div class='solution'><button>Activity 7</button>


```r
intellect_d <- cohensD(Rating ~ condition, method = "unequal", data = intellect)
hire_d <- cohensD(Rating ~ condition, method = "unequal", data = hire)
impression_d <- cohensD(Rating ~ condition, method = "unequal", data = impression)
```

</div>
  

### Activity 12


<div class='solution'><button>Activity 12</button>


```r
shapiro.test(x = gaze$diff)

qqPlot(gaze$diff)
```

</div>


**click the tab to see the solution**
<br>

### Activity 13


<div class='solution'><button>Activity 13</button>


```r
# create summary data to use with `geom_pointrange()`
summary_gaze<-gaze_tidy%>%
  group_by(time)%>%
  summarise(mean = mean(looking),
            min = mean(looking) - qnorm(0.975)*sd(looking)/sqrt(n()), #confidence intervals
            max = mean(looking) + qnorm(0.975)*sd(looking)/sqrt(n()))


ggplot(gaze_tidy, aes(x = time, y = looking)) +
  geom_violin(trim = FALSE) +
  geom_boxplot(aes(fill = time), width = .2, show.legend = FALSE) + 
  geom_pointrange(data = summary_gaze,
                  aes(x = time, y = mean, ymin=min, ymax=max),
                  shape = 20, 
                  position = position_dodge(width = 0.1), show.legend = FALSE)
```

</div>


**click the tab to see the solution**
<br>

### Activity 14


<div class='solution'><button>Activity 14</button>


```r
gaze_test <- t.test(looking ~ time, paired = TRUE, data = gaze_tidy) %>% tidy()
gaze_d <- cohensD(looking ~ time, method = "paired", data = gaze_tidy)
```

</div>


**click the tab to see the solution**
<br>
