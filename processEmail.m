function word_indices = processEmail(email_contents)
%   Preprocesses the body of an email and returns a
%   list of indices of the words contained in the email

% Load Vocabulary
vocabList = getVocabList();
word_indices = [];

% For processing, make the entire email into lower case
email_contents = lower(email_contents);

% Email can sometimes contain HTML which is useless for us.
% Therefore we strip all HTML by using a regular expression with empty string
email_contents = regexprep(email_contents, '<[^<>]+>', ' ');

% We will not care what number is present in the email. So
% we simply replace any occurence of a numerical character with
% the word 'number'
email_contents = regexprep(email_contents, '[0-9]+', 'number');

% Similar to numbers, we process URLs in the email_content, and
% replace with 'httpaddr'
email_contents = regexprep(email_contents, '(http|https)://[^\s]*', 'httpaddr');

% Similar to URL's, we process email addresses in the email_content,
% and replace with 'emailaddr'
email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr');

% Replace '$' symbols with 'dollar' keyword for ease of processing
email_contents = regexprep(email_contents, '[$]+', 'dollar');


% Tokenize Email

while ~isempty(email_contents)

    % Tokenize and also get rid of any punctuation
    [str, email_contents] = ...
       strtok(email_contents, ...
              [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);
   
    % Remove any non alphanumeric characters
    str = regexprep(str, '[^a-zA-Z0-9]', '');

    % Stem the word 
    % (the porterStemmer sometimes has issues, so we use a try catch block)
    try str = porterStemmer(strtrim(str)); 
    catch str = ''; continue;
    end;

    % Skip the word if it is too short
    if length(str) < 1
       continue;
    end

    % Look up the word in the dictionary and add to word_indices if
    % found

    for i = 1:length(vocabList),
        result = strcmp(str, vocabList{i});
        if result == 1,
            word_indices = [word_indices ; i];
    end

end

end
