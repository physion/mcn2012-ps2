% Copyright (c) 2012 Physion Consulting LLC

classdef TestMCN2012PS1Base < TestMatlabSuite
    
    properties
        dataPath;
        project
    end
    
    methods
        function self = TestMCN2012PS1Base(name)
            self = self@TestMatlabSuite(name);
            self.dataPath = fullfile(mfilename('fullpath'),...
                '..',...
                'problem_set1');
            
            self.project = projectForInsertion(self.dataContext,...
                'Problem Set 2',...
                '2012/07/30',...
                'MCN 2012 Problem Set 2');
            
        end
    end
end