% Copyright (c) 2012 Physion Consulting LLC

classdef TestImportsCell1 < TestMCN2012PS1Base
    methods
        function self = TestImportsCell1(name)
            self = self@TestMCN2012PS1Base(name);
        end
        
        function TestShouldImportTwoEpochGroups(self)
            import ovation.*
            
            probeStimPath = fullfile(self.dataPath, 'stim_long_1hr.txt');
            testStimPath = fullfile(self.dataPath, 'stim_repeat_30s.txt');
            
            probeSpikesPath = fullfile(self.dataPath, 'cell1_probe_spks.txt');
            testSpikesPath = fullfile(self.dataPath, 'cell1_test_spks.txt');
            
            expt = self.project.insertExperiment('Cell 1',...
                datetime(2012, 7, 30));
            
            parameters.probe.epochDurationSeconds=60*60;
            parameters.probe.stimParameters.sampleRate = 100;
            parameters.probe.stimParameters.sampleRateUnits = 'Hz';
            
            parameters.test.epochDurationSeconds=60*60;
            parameters.test.stimParameters.numRepetitions = 120;
            parameters.test.stimParameters.durationSeconds = parameters.test.epochDurationSeconds / parameters.test.stimParameters.numRepetitions;
            parameters.test.stimParameters.sampleRate = 100;
            parameters.test.stimParameters.sampleRateUnits = 'Hz';
            
            ImportCell(self.dataContext,...
                self.expt,...
                'cell1',...
                probeStimPath,...
                probeSpikesPath,...
                testStimPath,...
                testSpikesPath,...
                parameters);
            
            assertEqual(2, length(expt.getEpochGroups()), 'Number of EpochsGroups');
        end
        
        function TestShouldImportProbeAsSingleEpoch(self)
            import ovation.*
            
            probeStimPath = fullfile(self.dataPath, 'stim_long_1hr.txt');
            testStimPath = fullfile(self.dataPath, 'stim_repeat_30s.txt');
            
            probeSpikesPath = fullfile(self.dataPath, 'cell1_probe_spks.txt');
            testSpikesPath = fullfile(self.dataPath, 'cell1_test_spks.txt');
            
            expt = self.project.insertExperiment('Cell 1',...
                datetime(2012, 7, 30));
            
            parameters.probe.epochDurationSeconds=60*60;
            parameters.probe.stimParameters.sampleRate = 100;
            parameters.probe.stimParameters.sampleRateUnits = 'Hz';
            
            parameters.test.epochDurationSeconds=60*60;
            parameters.test.stimParameters.numRepetitions = 120;
            parameters.test.stimParameters.durationSeconds = parameters.test.epochDurationSeconds / parameters.test.stimParameters.numRepetitions;
            parameters.test.stimParameters.sampleRate = 100;
            parameters.test.stimParameters.sampleRateUnits = 'Hz';
            
            ImportCell(self.dataContext,...
                self.expt,...
                'cell1',...
                probeStimPath,...
                probeSpikesPath,...
                testStimPath,...
                testSpikesPath,...
                parameters);
            
            probeGroup = expt.getEpochGroups('probe');
            probeGroup = probeGroup(1);
            
            assertEquals(1, probeGroup.getEpochCount(), 'single probe group');
        end
        
        function TestShouldImportTestAsPerRepeatEpoch(self)
            import ovation.*
            
            probeStimPath = fullfile(self.dataPath, 'stim_long_1hr.txt');
            testStimPath = fullfile(self.dataPath, 'stim_repeat_30s.txt');
            
            probeSpikesPath = fullfile(self.dataPath, 'cell1_probe_spks.txt');
            testSpikesPath = fullfile(self.dataPath, 'cell1_test_spks.txt');
            
            expt = self.project.insertExperiment('Cell 1',...
                datetime(2012, 7, 30));
            
            parameters.probe.epochDurationSeconds=60*60;
            parameters.probe.stimParameters.sampleRate = 100;
            parameters.probe.stimParameters.sampleRateUnits = 'Hz';
            
            parameters.test.epochDurationSeconds=60*60;
            parameters.test.stimParameters.numRepetitions = 120;
            parameters.test.stimParameters.durationSeconds = parameters.test.epochDurationSeconds / parameters.test.stimParameters.numRepetitions;
            parameters.test.stimParameters.sampleRate = 100;
            parameters.test.stimParameters.sampleRateUnits = 'Hz';
            
            ImportCell(self.dataContext,...
                self.expt,...
                'cell1',...
                probeStimPath,...
                probeSpikesPath,...
                testStimPath,...
                testSpikesPath,...
                parameters);
            
            testGroup = expt.getEpochGroups('test');
            testGroup = testGroup(1);
            
            assertEquals(parameters.test.stimParameters.numRepetitions,...
                testGroup.getEpochCount(), 'test Epoch count');
        end
    end
end