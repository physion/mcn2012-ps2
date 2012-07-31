% Copyright (c) 2012 Physion Consulting LLC

function data = readTextData(path)
   
    try
        fid = fopen(path, 'r');
        dataCell = textscan(fid, '%f32');
        data = dataCell{1}';
        fclose(fid);
    catch ME %#ok<NASGU>
        fclose(fid);
    end
    
end