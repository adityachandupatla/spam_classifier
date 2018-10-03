function file_contents = readFile(filename)
%	A utility function which reads a file and returns its entire contents
fid = fopen(filename);
if fid
    file_contents = fscanf(fid, '%c', inf);
    fclose(fid);
else
    file_contents = '';
    fprintf('Unable to open the file: %s\n', filename);
end

end

