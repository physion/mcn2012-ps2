% Copyright (c) 2012 Physion Consulting LLC

classdef TestMCN2012PS1Base < TestMatlabSuite
    
    properties
        dataPath;
        project
    end
    
    methods
        function self = TestMCN2012PS1Base(name)
            self = self@TestMatlabSuite(name);
            
            self.dataPath = fullfile(fileparts(mfilename('fullpath')),...
                '..',...
                'problem_set1');
            
        end
        
        function setUp(self)
            import ovation.*
            
            setUp@TestMatlabSuite(self)
            
            self.project = projectForInsertion(self.context,...
                'Problem Set 2',...
                '2012/07/30',...
                'MCN 2012 Problem Set 2');
            
        end
        
        function testFdName = federationName(~)
            testFdName = 'mcn2012';
        end
    end
end