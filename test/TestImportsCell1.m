% Copyright (c) 2012 Physion Consulting LLC

classdef TestImportsCell1 < TestMCN2012PS1Base
    methods
        function self = TestImportsCell1(name)
            self = self@TestMCN2012PS1Base(name);
        end
        
        function testFdName = federationName(~)
            testFdName = 'mcn2012_cell1';
        end
        
        function parameters = getImportParameters(~)
            parameters.probe.epochDurationSeconds=60*60;
            parameters.probe.stimParameters.sampleRate = 100;
            parameters.probe.stimParameters.sampleRateUnits = 'Hz';
            
            parameters.test.epochDurationSeconds=60*60;
            parameters.test.stimParameters.numRepetitions = 120;
            parameters.test.stimParameters.durationSeconds = parameters.test.epochDurationSeconds / parameters.test.stimParameters.numRepetitions;
            parameters.test.stimParameters.sampleRate = 100;
            parameters.test.stimParameters.sampleRateUnits = 'Hz';
        end
        
        
        function testShouldImportTwoEpochGroups(self)
            import ovation.*
            
            probeStimPath = fullfile(self.dataPath, 'stim_long_1hr.txt');
            testStimPath = fullfile(self.dataPath, 'stim_repeat_30s.txt');
            
            probeSpikesPath = fullfile(self.dataPath, 'cell1_probe_spks.txt');
            testSpikesPath = fullfile(self.dataPath, 'cell1_test_spks.txt');
            
            expt = self.project.insertExperiment('Cell 1',...
                datetime(2012, 7, 30));
            
            parameters = self.getImportParameters();
            
            ImportCell(self.context,...
                expt,...
                'cell1',...
                probeStimPath,...
                probeSpikesPath,...
                testStimPath,...
                testSpikesPath,...
                parameters);
            
            assertEqual(2, length(expt.getEpochGroups()), 'Number of EpochsGroups');
        end
        
        function testShouldImportProbeAsSingleEpoch(self)
            import ovation.*
            
            probeStimPath = fullfile(self.dataPath, 'stim_long_1hr.txt');
            testStimPath = fullfile(self.dataPath, 'stim_repeat_30s.txt');
            
            probeSpikesPath = fullfile(self.dataPath, 'cell1_probe_spks.txt');
            testSpikesPath = fullfile(self.dataPath, 'cell1_test_spks.txt');
            
            expt = self.project.insertExperiment('Cell 1',...
                datetime(2012, 7, 30));
            
            parameters = self.getImportParameters();
            
            ImportCell(self.context,...
                expt,...
                'cell1',...
                probeStimPath,...
                probeSpikesPath,...
                testStimPath,...
                testSpikesPath,...
                parameters);
            
            probeGroup = expt.getEpochGroups('probe');
            probeGroup = probeGroup(1);
            
            assertEqual(1, probeGroup.getEpochCount(), 'single probe group');
        end
        
        function testShouldImportTestAsPerRepeatEpoch(self)
            import ovation.*
            
            probeStimPath = fullfile(self.dataPath, 'stim_long_1hr.txt');
            testStimPath = fullfile(self.dataPath, 'stim_repeat_30s.txt');
            
            probeSpikesPath = fullfile(self.dataPath, 'cell1_probe_spks.txt');
            testSpikesPath = fullfile(self.dataPath, 'cell1_test_spks.txt');
            
            expt = self.project.insertExperiment('Cell 1',...
                datetime(2012, 7, 30));
            
            parameters = self.getImportParameters();
            
            ImportCell(self.context,...
                expt,...
                'cell1',...
                probeStimPath,...
                probeSpikesPath,...
                testStimPath,...
                testSpikesPath,...
                parameters);
            
            testGroup = expt.getEpochGroups('test');
            testGroup = testGroup(1);
            
            assertEqual(parameters.test.stimParameters.numRepetitions,...
                testGroup.getEpochCount(), 'test Epoch count');
        end
        
        function testShouldSetResponseSampleRate(self)
            import ovation.*
            
            probeStimPath = fullfile(self.dataPath, 'stim_long_1hr.txt');
            testStimPath = fullfile(self.dataPath, 'stim_repeat_30s.txt');
            
            probeSpikesPath = fullfile(self.dataPath, 'cell1_probe_spks.txt');
            testSpikesPath = fullfile(self.dataPath, 'cell1_test_spks.txt');
            
            expt = self.project.insertExperiment('Cell 1',...
                datetime(2012, 7, 30));
            
            parameters = self.getImportParameters();
            
            ImportCell(self.context,...
                expt,...
                'cell1',...
                probeStimPath,...
                probeSpikesPath,...
                testStimPath,...
                testSpikesPath,...
                parameters);
            
            
            itr = expt.getEpochs();
            while(itr.hasNext())
                e = itr.next();
                assertEqual(parameters.probe.stimParameters.sampleRate,...
                    e.getResponse('Model Cell').getSampleRates());
                
                actual = e.getResponse('Model Cell').getSamplingUnits();
                assertEqual(parameters.probe.stimParameters.sampleRateUnits,...
                    actual{1});
            end
            
        end
        
        function testShouldSetProbeDuration(self)
            import ovation.*
            import org.joda.time.*;
            
            probeStimPath = fullfile(self.dataPath, 'stim_long_1hr.txt');
            testStimPath = fullfile(self.dataPath, 'stim_repeat_30s.txt');
            
            probeSpikesPath = fullfile(self.dataPath, 'cell1_probe_spks.txt');
            testSpikesPath = fullfile(self.dataPath, 'cell1_test_spks.txt');
            
            expt = self.project.insertExperiment('Cell 1',...
                datetime(2012, 7, 30));
            
            parameters = self.getImportParameters();
            
            ImportCell(self.context,...
                expt,...
                'cell1',...
                probeStimPath,...
                probeSpikesPath,...
                testStimPath,...
                testSpikesPath,...
                parameters);
            
            probeGroup = expt.getEpochGroups('probe');
            probeGroup = probeGroup(1);
            
            itr = probeGroup.getEpochsIterable().iterator();
            while(itr.hasNext())
                e = itr.next();
                assertEqual(parameters.probe.epochDurationSeconds,...
                Seconds.secondsBetween(e.getStartTime(), e.getEndTime()).getSeconds());
            end
        end
        
        function testShouldSetTestEpochDuration(self)
                        import ovation.*
            import org.joda.time.*;
            
            probeStimPath = fullfile(self.dataPath, 'stim_long_1hr.txt');
            testStimPath = fullfile(self.dataPath, 'stim_repeat_30s.txt');
            
            probeSpikesPath = fullfile(self.dataPath, 'cell1_probe_spks.txt');
            testSpikesPath = fullfile(self.dataPath, 'cell1_test_spks.txt');
            
            expt = self.project.insertExperiment('Cell 1',...
                datetime(2012, 7, 30));
            
            parameters = self.getImportParameters();
            
            ImportCell(self.context,...
                expt,...
                'cell1',...
                probeStimPath,...
                probeSpikesPath,...
                testStimPath,...
                testSpikesPath,...
                parameters);
            
            testGroup = expt.getEpochGroups('test');
            testGroup = testGroup(1);
            
            itr = testGroup.getEpochsIterable().iterator();
            while(itr.hasNext())
                e = itr.next();
                assertEqual(parameters.test.stimParameters.durationSeconds,...
                Seconds.secondsBetween(e.getStartTime(), e.getEndTime()).getSeconds());
            end
        end
        
        function testShouldSaveProbeStimulus(self)
            import ovation.*
            import org.joda.time.*;
            
            probeStimPath = fullfile(self.dataPath, 'stim_long_1hr.txt');
            testStimPath = fullfile(self.dataPath, 'stim_repeat_30s.txt');
            
            probeSpikesPath = fullfile(self.dataPath, 'cell1_probe_spks.txt');
            testSpikesPath = fullfile(self.dataPath, 'cell1_test_spks.txt');
            
            expt = self.project.insertExperiment('Cell 1',...
                datetime(2012, 7, 30));
            
            parameters = self.getImportParameters();
            
            ImportCell(self.context,...
                expt,...
                'cell1',...
                probeStimPath,...
                probeSpikesPath,...
                testStimPath,...
                testSpikesPath,...
                parameters);
            
            probeGroup = expt.getEpochGroups('probe');
            probeGroup = probeGroup(1);
            
            itr = probeGroup.getEpochsIterable().iterator();
            while(itr.hasNext())
                e = itr.next();
                data = e.getStimulus('Stimulator').getStimulusParameters().get('stimData');
                assertFalse(isempty(data));
            end
        end
        
        function testShouldSaveTestStimulus(self)
            import ovation.*
            import org.joda.time.*;
            
            probeStimPath = fullfile(self.dataPath, 'stim_long_1hr.txt');
            testStimPath = fullfile(self.dataPath, 'stim_repeat_30s.txt');
            
            probeSpikesPath = fullfile(self.dataPath, 'cell1_probe_spks.txt');
            testSpikesPath = fullfile(self.dataPath, 'cell1_test_spks.txt');
            
            expt = self.project.insertExperiment('Cell 1',...
                datetime(2012, 7, 30));
            
            parameters = self.getImportParameters();
            
            ImportCell(self.context,...
                expt,...
                'cell1',...
                probeStimPath,...
                probeSpikesPath,...
                testStimPath,...
                testSpikesPath,...
                parameters);
            
            testGroup = expt.getEpochGroups('test');
            testGroup = testGroup(1);
            
            itr = testGroup.getEpochsIterable().iterator();
            while(itr.hasNext())
                e = itr.next();
                data = e.getStimulus('Stimulator').getStimulusParameters().get('stimData');
                assertFalse(isempty(data));
            end
        end
        
        function testShouldSaveProbeSpikeTimesInDerivedResponse(self)
            import ovation.*
            import org.joda.time.*;
            
            probeStimPath = fullfile(self.dataPath, 'stim_long_1hr.txt');
            testStimPath = fullfile(self.dataPath, 'stim_repeat_30s.txt');
            
            probeSpikesPath = fullfile(self.dataPath, 'cell1_probe_spks.txt');
            testSpikesPath = fullfile(self.dataPath, 'cell1_test_spks.txt');
            
            expt = self.project.insertExperiment('Cell 1',...
                datetime(2012, 7, 30));
            
            parameters = self.getImportParameters();
            
            ImportCell(self.context,...
                expt,...
                'cell1',...
                probeStimPath,...
                probeSpikesPath,...
                testStimPath,...
                testSpikesPath,...
                parameters);
            
            probeGroup = expt.getEpochGroups('probe');
            probeGroup = probeGroup(1);
            
            probeSpikes = readTextData(probeSpikesPath);
            itr = probeGroup.getEpochsIterable().iterator();
            while(itr.hasNext())
                e = itr.next();
                assertEqual(probeSpikes,...
                    e.getMyDerivedResponse('spikes').getFloatingPointData());
            end
        end
        
        function testShouldSaveTestSpikeTimesInDerivedResponse(self)
                        import ovation.*
            import org.joda.time.*;
            
            probeStimPath = fullfile(self.dataPath, 'stim_long_1hr.txt');
            testStimPath = fullfile(self.dataPath, 'stim_repeat_30s.txt');
            
            probeSpikesPath = fullfile(self.dataPath, 'cell1_probe_spks.txt');
            testSpikesPath = fullfile(self.dataPath, 'cell1_test_spks.txt');
            
            expt = self.project.insertExperiment('Cell 1',...
                datetime(2012, 7, 30));
            
            parameters = self.getImportParameters();
            
            ImportCell(self.context,...
                expt,...
                'cell1',...
                probeStimPath,...
                probeSpikesPath,...
                testStimPath,...
                testSpikesPath,...
                parameters);
            
            testGroup = expt.getEpochGroups('test');
            testGroup = testGroup(1);
            
            testSpikes = readTextData(testSpikesPath);
            itr = testGroup.getEpochsIterable().iterator();
            
            actualSpikes = {};
            while(itr.hasNext())
                e = itr.next();
                actualSpikes{end+1} = e.getMyDerivedResponse('spikes').getFloatingPointData(); %#ok<AGROW>
            end
            
            assertEqual(testSpikes, cell2mat(actualSpikes));
        end
        
    end
end