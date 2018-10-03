function printPreprocessedEmail(word_indices)
	% Utility function to print a pre-processed email
	% Useful while debugging since it provides an insight
	% as to what features we are incorporating into our
	% SVM
	fprintf('\nPreprocessed email:\n\n')
	vocabList = getVocabList();
	for i = 1:length(word_indices),
		fprintf('%s ', vocabList{word_indices(i)})
	end
	fprintf('\n')
end