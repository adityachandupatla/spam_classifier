function x = emailFeatures(word_indices)
%	This function takes in a word_indices vector and produces a feature vector
%	from the word indices (one-hot encoded form)

% Total number of words in the dictionary
n = 1899;
x = zeros(n, 1);

% If an email has the text:
%	
%    The quick brown fox jumped over the lazy dog.
%	
% Then, the word_indices vector for this text might look 
% like:
% 
%     60  100   33   44   10     53  60  58   5
%	
% where, each word is mapped onto a number, for example:
%	
%     the   -- 60
%     quick -- 100
%     ...
%	
% This function takes in one such word_indices vector and constructs
% a binary feature vector that indicates whether a particular
% word occurs in the email. That is, x(i) = 1 when word i
% is present in the email.

for i = 1:length(word_indices),
	x(word_indices(i)) = 1;
end

end
