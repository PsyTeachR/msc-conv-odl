
# Revision 1: Intro to R {#ref2}

There are nine activities in total for this chapter, but don't worry, they are broken down into very small steps!

## Activity 1: Programming basics

Please read Chapter \@ref(ref3) and watch [RStudio Essentials 1](https://www.rstudio.com/resources/webinars/rstudio-essentials-webinar-series-part-1/) from the R Studio team. The video lasts ~30 minutes and gives a tour of the main parts of R Studio. 

## Activity 2: Create the working directory 

If you want to load data into R, or save the output of what you've created (which you almost always will want to do), you first need to tell R where the **working directory** is. All this means is that we tell R where the files we need (such as raw data) are located and where we want to save any files you have created. Think of it just like when you have different subjects, and you have separate folders for each topic e.g. biology, history and so on. When working with R, it's useful to have all the data sets and files you need in one folder. 

We recommend making a new folder called "Research Methods R" with sub-folders for each chapter and saving any data, scripts, and portfolio files for each chapter in these folders. We suggest that you create this folder on the M: drive. This is your personal area on the University network that is safe and secure so it is much better than flashdrives or desktops. 


<div class="figure" style="text-align: center">
<img src="images/folders.png" alt="Folder structure" width="100%" />
<p class="caption">(\#fig:img-folders)Folder structure</p>
</div>

First, choose a location for your book work and then create the necessary folders for each chapter.

## Activity 3: Set the working directory

Once you have created your folders, open R Studio. To set the working directory click `Session` -> `Set Working Directory` -> `Choose Directory` and then select the RM2 Revision 1 folder as your working directory. 

<div class="figure" style="text-align: center">
<img src="images/working-dir.png" alt="Setting the working directory" width="100%" />
<p class="caption">(\#fig:img-working-dir)Setting the working directory</p>
</div>

## R Markdown for R book work and portfolio assignments

For the R book work and portfolio assignments you will use a worksheet format called R Markdown (abbreviated as Rmd) which is a great way to create dynamic documents with embedded chunks of code. These documents are self-contained and fully reproducible (if you have the necessary data, you should be able to run someone else's analyses with the click of a button) which makes it very easy to share. This is an important part of your open science training as one of the reasons we are using R Studio is that it enables us to share open and reproducible information. Using these worksheets enables you to keep a record of all the code you write during this course, and when it comes time for the portfolio assignments, we can give you a task you can and then fill in the required code. 

For more information about R Markdown feel free to have a look at their main webpage sometime http://rmarkdown.rstudio.com. The key advantage of R Markdown is that it allows you to write code into a document, along with regular text, and then **knit** it using the package `knitr` to create your document as either a webpage (HTML), a PDF, or Word document (.docx). 

## Activity 4: Open and save a new R Markdown document

To open a new R Markdown document click the 'new item' icon and then click 'R Markdown'. You will be prompted to give it a title, call it "Revision 1". Also, change the author name to your GUID as this will be good practice for the portfolio assignments. Keep the output format as HTML.

<div class="figure" style="text-align: center">
<img src="images/new-markdown.png" alt="Opening a new R Markdown document" width="100%" />
<p class="caption">(\#fig:img-new-markdown)Opening a new R Markdown document</p>
</div>

Once you've opened a new document be sure to save it by clicking `File` -> `Save as`. Name this file "Revision 1". If you've set the working directory correctly, you should now see this file appear in your file viewer pane.

<div class="figure" style="text-align: center">
<img src="images/file-dir.png" alt="New file in working directory" width="100%" />
<p class="caption">(\#fig:img-file-dir)New file in working directory</p>
</div>

## Activity 5: Create a new code chunk

When you first open a new R Markdown document you will see a bunch of welcome text that looks like this:

<div class="figure" style="text-align: center">
<img src="images/markdown-default.png" alt="New R Markdown text" width="100%" />
<p class="caption">(\#fig:img-markdown-default)New R Markdown text</p>
</div>

Do the following steps:  
* Delete **everything** below line 7  
* On line 8 type "About me"  
* Click `Insert` -> `R`  

Your Markdown document should now look something like this:

<div class="figure" style="text-align: center">
<img src="images/new-chunk.png" alt="New R chunk" width="100%" />
<p class="caption">(\#fig:img-new-chunk)New R chunk</p>
</div>

What you have created is a **code chunk**. In R Markdown, anything written in the white space is regarded as normal text, and anything written in a grey code chunk is assumed to be code. This makes it easy to combine both text and code in one document.


<div class="warning">
<p>When you create a new code chunk you should notice that the grey box starts and ends with three back ticks ```. One common mistake is to accidentally delete these back ticks. Remember, code chunks are grey and text entry is white - if the colour of certain parts of your Markdown doesn’t look right, check that you haven’t deleted the back ticks.</p>
</div>


## Activity 6: Write some code

Now we're going to use the code examples you read about in \@ref(ref3) to add some simple code to our R Markdown document. In your code chunk write the below code but replace the values of name/age/birthday with your own details). Note that text values and dates need to be contained in quotation marks but numerical values do not. Missing and/or unnecessary quotation marks are a common cause of code not working - remember this!


```r
name <- "Emily" 
age <- 33
today <- Sys.Date()
next_birthday <- as.Date("2019-07-11")
```

## Running code

When you're working in an R Markdown document, there are several ways to run your lines of code.

First, you can highlight the code you want to run and then click `Run` -> `Run Selected Line(s)`, however this is very slow.

<div class="figure" style="text-align: center">
<img src="images/run1.png" alt="Slow method of running code" width="100%" />
<p class="caption">(\#fig:img-run1)Slow method of running code</p>
</div>

Alternatively, you can press the green "play" button at the top-right of the code chunk and this will run **all** lines of code in that chunk.

<div class="figure" style="text-align: center">
<img src="images/run2.png" alt="Slightly better method of running code" width="100%" />
<p class="caption">(\#fig:img-run2)Slightly better method of running code</p>
</div>

Even better though is to learn some of the keyboard shortcuts for R Studio. To run a single line of code, make sure that the cursor is in the line of code you want to run (it can be anywhere) and press `ctrl + enter`. If you want to run all of the code in the code chunk, press `ctrl + shift + enter`. Learn these shortcuts, they will make your life easier!

## Activity 7: Run your code

Run your code using one of the methods above. You should see the variables `name`, `age`, `today`, and `next_birthday` appear in the environment pane.

## Activity 8: Inline code

An incredibly useful feature of R Markdown is that R can insert values into your writing using **inline code**. If you've ever had to copy and paste a value or text from one file in to another, you'll know how easy it can be to make mistakes. Inline code avoids this. It's easier to show you what inline code does rather than to explain it so let's have a go.

First, copy and paste this text exactly (do not change anything) to the **white space** underneath your code chunk.



```r
My name is `r name` and I am `r age` years old. It is `r next_birthday - today` days until my birthday.
```

## Activity 9: Knitting your file

Nearly finished! As our final step we are going to "knit" our file. This simply means that we're going to compile our code into a document that is more presentable. To do this click `Knit` -> `Knit to HMTL`. R Markdown will create a new HTML document and it will automatically save this file in your working directory. 

As if by magic, that slightly odd bit of text you copied and pasted now appears as a normal sentence with the values pulled in from the objects you created. 

**My name is Emily and I am 33 years old. It is -177 days until my birthday.**

We're not going to use this function very often in the rest of the course but hopefully you can see just how useful this would be when writing up a report with lots of numbers! R Markdown is an incredibly powerful and flexible format - this book was written using it! If you want to push yourself with R, additional functions and features of R Markdown would be a good place to start.

Before we finish, there are a few final things to note about knitting that will be useful for the portfolio and mini-project:  

* R Markdown will only knit if your code works - this is a good way of checking for the portfolio assignments whether you've written legal code!  
* You can choose to knit to a Word document rather than HTML. This can be useful for e.g., sharing with others, however, it may lose some functionality and it probably won't look as good so we'd recommend always knitting to HTML.  
* You can choose to knit to PDF, however, this requires an LaTex installation and is quite complicated. If you don't already know what LaTex is and how to use it, do not knit to PDF. If you do know how to use LaTex, you don't need us to give you instructions! 
* R will automatically open the knitted HTML file in the viewer, however, you can also navigate to the folder it is stored in and open the HTML file in your web browser (e.g., Chrome or Firefox).  

## Finished

And you're done! On your very first time using R you've not only written functioning code but you've written a reproducible output! You could send someone else your R Markdown document and they would be able to produce exactly the same HTML document as you, just by pressing knit.

The key thing we want you to take away from this chapter is that R isn't scary. It might be very new to a lot of you, but we're going to take you through it step-by-step. You'll be amazed at how quickly you can start producing professional-looking data visualisations and analysis.

If you have any questions about anything contained in this chapter or in \@ref(ref3), you can use the Slack forum or Moodle.
