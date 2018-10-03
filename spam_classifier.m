% Spam Classification with SVMs
% Driver program

%% Close any open windows and clear the console
cleanup();

% Train Linear SVM for Spam Classification

% Load the Spam Email dataset
% You will have X, y in your environment
load('spamTrain.mat');

fprintf('\nTraining Linear SVM (Spam Classification)\n')
fprintf('(this may take maximum 2 minutes) ...\n')

C = 0.1;
model = svmTrain(X, y, C, @linearKernel);

p = svmPredict(model, X);

fprintf('Training Accuracy: %f\n', mean(double(p == y)) * 100);

%  Test Spam Classification: After training the classifier, we can evaluate it on a test set

% Load the test dataset
% You will have Xtest, ytest in your environment
load('spamTest.mat');

fprintf('\nEvaluating the trained Linear SVM on a test set ...\n')

p = svmPredict(model, Xtest);

fprintf('\nTest Accuracy: %f\n', mean(double(p == ytest)) * 100);

%  Top Predictors of Spam: The following code finds the words with
%  the highest weights in the classifier. Informally, the classifier
%  'thinks' that these words are the most likely indicators of spam.

% Sort the weights and obtain the vocabulary list
[weight, idx] = sort(model.w, 'descend');
vocabList = getVocabList();

fprintf('\nTop predictors of spam: \n\n');
for i = 1:15
    fprintf(' %-15s (%f) \n', vocabList{idx(i)}, weight(i));
end

fprintf('\n\n');

%  Try user defined Emails: Reads in one of user given emails and then uses the 
%  learned SVM classifier to determine whether the email is Spam or Not Spam

while true
	
	% Ask the user to input a filename (Fully qualified)
	filename = inputUserFileName();

	% If the user enters 'quit', then exit the program
	if strcmp(filename, "exit") == 1,
		quit();
	end
	
	%  Email Preprocessing: As a preprocessing step, we first convert each email
	%  into a vector of features 

	fprintf('\nPreprocessing email %s\n', filename);
	% Read and predict
	file_contents = readFile(filename);
	word_indices  = processEmail(file_contents);

	printPreprocessedEmail(word_indices)

	x = emailFeatures(word_indices);
	p = svmPredict(model, x);

	result = ""
	if p == 1,
		result = "SPAM EMAIL"
	else
		result = "NON-SPAM EMAIL"
	end

	fprintf('\nProcessed %s\n\nSpam Classification: %s\n', filename, result);
end