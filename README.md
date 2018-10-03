# Spam email Classifier using SVM

A miniaturized spam classifier which classifies a given input email as SPAM / NOT-SPAM. <a href="https://en.wikipedia.org/wiki/Support_vector_machine">Support Vector Machine (SVM)</a> is used to build the classifier. The training set (spamTrain.mat) contains 4000 training examples of spam and non-spam email, while the test set (spamTest.mat) contains 1000 test examples. The classifier achieves a training accuracy of about 99.8% and a test accuracy of about 98.5%. The dataset is based on a a subset of the <a href="http://spamassassin.apache.org/old/publiccorpus/">SpamAssassin Public Corpus</a>. This project is implemented as part of the <a href="https://github.com/adityachandupatla/ML_Coursera">machine learning course</a> from Coursera, while I was learning the Support Vector Machines chapter.

<h2>Running the Project</h2>
<ul>
  <li>Make sure you have Octave/MATLAB installed</li>
  <li>Clone the project to your local machine and open it in one of your favorite IDE's which supports Octave/MATLAB code</li>
  <li>Run spam_classifier.m</li>
  <li>The SVM is first trained and tested on the datasets present in the project repository</li>
  <li>A list of words which the algorithm thinks as being top predictors for spam are shown</li>
  <li>Input the filename which contains the email which you want to classify as spam/non-spam</li>
  <li>The application first pre-processes the email and shows the user the pre-processed email which will be sent as input to SVM</li>
  <li>The prediction is done</li>
</ul>
If you find any problem deploying the project in your machine, please do let me know.

<h2>Technical Skills</h2>
This project is developed to showcase my following programming abilities:
<ul>
  <li><h3>Programming in Octave/MATLAB: </h3><p>Although R/Python is the default programming language choice for building any machine learning application, GNU Octave or MATLAB will be easier to develop new mathematical models quickly. Moreover, it is good to have new programming languages in your arsenal!</p></li>
  <li><h3>Support Vector Machines: </h3><p>A Support Vector Machine (SVM) is a discriminative classifier formally defined by a separating hyperplane. In other words, given labeled training data (supervised learning), the algorithm outputs an optimal hyperplane which categorizes new examples.</p></li>
  <li><h3>Data pre-processing: </h3><p>Spam classification involves lot of data pre-processing and feature engineering before we can even train the model. Apart from this, for a data scientist, data pre-processing is a crucial step in any real-life machine learning problem. The exact steps followed for spam-classification are described in detail in the sections which follow.</p></li>
</ul>

<h2>Development</h2>
<ul>
  <li>Sublimt Text has been used to program the application. No IDE has been used.</li>
  <li>Command line has been used to interact with the application.</li>
  <li>The project has been tested on Octave version: 3.8.0.</li>
</ul>

<h2>Working</h2>
<p>Our goal is to train a classifier to classify whether a given email, <i>x</i>, is spam (<i>y</i> = 1) or non-spam (<i>y</i> = 0). We need to convert each email into a <i>N</i> dimensional feature vector '<i>x</i>'.</p><br/>
<p>
Sample spam email:

> Anyone knows how much it costs to host a web portal ?
> 
> Well, it depends on how many visitors youre expecting. This can be anywhere from less than 10 bucks a month to a couple of $100. You should checkout http://www.rackspace.com/ or perhaps Amazon EC2 if youre running something big..
> 
> To unsubscribe yourself from this mailing list, send an email to: groupname-unsubscribe@egroups.com</p><br/>

<p>Before starting on a machine learning task, it is usually insightful to take a look at examples from the dataset. The above snippet shows a sample email that contains a URL, an email address (at the end), numbers, and dollar amounts. While many emails would contain similar types of entities (e.g., numbers, other URLs, or other email addresses), the specific entities (e.g., the specific URL or specific dollar amount) will be different in almost every email. Therefore, one method often employed in processing emails is to “normalize” these values, so that all URLs are treated the same, all numbers are treated the same, etc. For example, we could replace each URL in the email with the unique string “httpaddr” to indicate that a URL was present. This has the effect of letting the spam classifier make a classification decision based on whether any URL was present, rather than whether a specific URL was present. This typically improves the performance of a spam classifier, since spammers often randomize the URLs, and thus the odds of seeing any particular URL again in a new piece of spam is very small.</p><br/>
<p>We implement the following preprocessing steps:</p><br/>
<ul>
  <li><b>Lower-casing:</b> The entire email is converted into lower case, so that captialization is ignored (e.g., IndIcaTE is treated the same as Indicate).</li>
  <li><b>Stripping HTML</b>: All HTML tags are removed from the emails. Many emails often come with HTML formatting; we remove all the HTML tags, so that only the content remains.</li>
  <li><b>Normalizing URLs:</b> All URLs are replaced with the text “httpaddr”.</li>
  <li><b>Normalizing Email Addresses:</b> All email addresses are replaced with the text “emailaddr”.</li>
  <li><b>Normalizing Numbers:</b> All numbers are replaced with the text “number”.</li>
  <li><b>Normalizing Dollars:</b> All dollar signs ($) are replaced with the text “dollar”.</li>
  <li><b>Word Stemming:</b> Words are reduced to their stemmed form. For example, “discount”, “discounts”, “discounted” and “discounting” are all replaced with “discount”. Sometimes, the Stemmer actually strips off additional characters from the end, so “include”, “includes”, “included”, and “including” are all replaced with “includ”. (Porter Stemmer: Algorithm is taken from Porter, 1980, An algorithm for suffix stripping)</li>
  <li>__Removal of non-words:__ Non-words and punctuation have been removed. All white spaces (tabs, newlines, spaces) have all been trimmed to a single space character.</li>
</ul>
<p>Applying this preprocessing to the above email, we will be leftover with the following:</p><br/>
<p> Pre processed email:
  
> anyon know how much it cost to host a web portal well it depend on how
> mani visitor your expect thi can be anywher from less than number buck
> a month to a coupl of dollarnumb you should checkout httpaddr or perhap
> amazon ecnumb if your run someth big to unsubscrib yourself from thi
> mail list send an email to emailaddr</p><br/>
<p>After preprocessing the emails, we have a list of words for each email. The next step is to choose which words we would like to use in our classifier and which we would want to leave out.
For this task, we have chosen only the most frequently occuring words which are listed in the vocabulary list. Since words that occur rarely in the training set are only in a few emails, they might cause the model to overfit our training set. The complete vocabulary list is in the file vocab.txt. The vocabulary list was selected by choosing all words which occur at least a 100 times in the spam corpus, resulting in a list of 1899 words.</p><br/>
<p>Given the vocabulary list, we can now map each word in the preprocessed emails into a list of word indices that contains the index of the word in the vocabulary list. Finally, we convert the features into one-hot encoded forms.</p><br/>
<h2>TO DO</h2>
<ul>
  <li>As with _most_ of the machine learning algorithms, a bigger dataset yields a better performance. In the upcoming version I plan on training on a larger data set for building a real-life spam-classifier.</li>
  <li>The SVM is implemented in svmTrain.m. This particular implementation was chosen to maximize compatibility with Octave/MATLAB, and is not very efficient. In the next version I will try to use a highly optimized SVM toolbox such as <a href="https://www.csie.ntu.edu.tw/~cjlin/libsvm/">LIBSVM</a> or <a href="http://svmlight.joachims.org/">SVMLight</a>.</li>
  <li>Use a bigger vocabulary list to further improve the accuracy.</li>
  <li>UI support. It would be better if the email can be dragged and dropped in a window rather than manually entering the filename.</li>
</ul>
<br/><br/>
Use this, report bugs, raise issues and Have fun. Do whatever you want! I would love to hear your feedback :)

~ Happy Coding
