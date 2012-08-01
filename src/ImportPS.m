%% Setup

ctx = NewDataContext('mcn/mcn.connection');
datapath = '/Users/barry/development/mcn2012-ps2/problem_set1';

%% Project

proj = projectForInsertion(ctx,...
    'Problem Set 2',...
    '2012/07/30',...
    'MCN 2012 Problem Set 2');

%% Cell 1

parameters.probe.epochDurationSeconds=60*60;
parameters.probe.stimParameters.sampleRate = 100;
parameters.probe.stimParameters.sampleRateUnits = 'Hz';

parameters.test.epochDurationSeconds=60*60;
parameters.test.stimParameters.numRepetitions = 120;
parameters.test.stimParameters.durationSeconds = parameters.test.epochDurationSeconds / parameters.test.stimParameters.numRepetitions;
parameters.test.stimParameters.sampleRate = 100;
parameters.test.stimParameters.sampleRateUnits = 'Hz';

probeStimPath = fullfile(datapath, 'stim_long_1hr.txt');
testStimPath = fullfile(datapath, 'stim_repeat_30s.txt');
probeSpikesPath = fullfile(datapath, 'cell1_probe_spks.txt');
testSpikesPath = fullfile(datapath, 'cell1_test_spks.txt');

exp = proj.insertExperiment('cell 1', datetime(2012,7,30));

ImportCell(ctx,...
    exp,...
    'cell1',...
    probeStimPath,...
    probeSpikesPath,...
    testStimPath,...
    testSpikesPath,...
    parameters);

%% Cell 2
parameters.probe.epochDurationSeconds=60*60;
parameters.probe.stimParameters.sampleRate = 100;
parameters.probe.stimParameters.sampleRateUnits = 'Hz';

parameters.test.epochDurationSeconds=60*60;
parameters.test.stimParameters.numRepetitions = 120;
parameters.test.stimParameters.durationSeconds = parameters.test.epochDurationSeconds / parameters.test.stimParameters.numRepetitions;
parameters.test.stimParameters.sampleRate = 100;
parameters.test.stimParameters.sampleRateUnits = 'Hz';

probeStimPath = fullfile(datapath, 'stim_long_1hr.txt');
testStimPath = fullfile(datapath, 'stim_repeat_30s.txt');
probeSpikesPath = fullfile(datapath, 'cell2_probe_spks.txt');
testSpikesPath = fullfile(datapath, 'cell2_test_spks.txt');

exp = proj.insertExperiment('cell 2', datetime(2012,7,30));

ImportCell(ctx,...
    exp,...
    'cell2',...
    probeStimPath,...
    probeSpikesPath,...
    testStimPath,...
    testSpikesPath,...
    parameters);

%% Cell 3
parameters.probe.epochDurationSeconds=60*60;
parameters.probe.stimParameters.sampleRate = 100;
parameters.probe.stimParameters.sampleRateUnits = 'Hz';

parameters.test.epochDurationSeconds=60*60;
parameters.test.stimParameters.numRepetitions = 120;
parameters.test.stimParameters.durationSeconds = parameters.test.epochDurationSeconds / parameters.test.stimParameters.numRepetitions;
parameters.test.stimParameters.sampleRate = 100;
parameters.test.stimParameters.sampleRateUnits = 'Hz';

probeStimPath = fullfile(datapath, 'stim_long_1hr.txt');
testStimPath = fullfile(datapath, 'stim_repeat_30s.txt');
probeSpikesPath = fullfile(datapath, 'cell3_probe_spks.txt');
testSpikesPath = fullfile(datapath, 'cell3_test_spks.txt');

exp = proj.insertExperiment('cell 3', datetime(2012,7,30));

ImportCell(ctx,...
    exp,...
    'cell3',...
    probeStimPath,...
    probeSpikesPath,...
    testStimPath,...
    testSpikesPath,...
    parameters);

%% Cell 4

parameters.probe.epochDurationSeconds=60*20;
parameters.probe.stimParameters.sampleRate = 1000;
parameters.probe.stimParameters.sampleRateUnits = 'Hz';

parameters.test.epochDurationSeconds=20*60;
parameters.test.stimParameters.numRepetitions = 120;
parameters.test.stimParameters.durationSeconds = parameters.test.epochDurationSeconds / parameters.test.stimParameters.numRepetitions;
parameters.test.stimParameters.sampleRate = 1000;
parameters.test.stimParameters.sampleRateUnits = 'Hz';

probeStimPath = fullfile(datapath, 'cell4_stim.txt');
testStimPath = fullfile(datapath, 'cell4_stim_test.txt');
probeSpikesPath = fullfile(datapath, 'cell4_spikes.txt');
testSpikesPath = fullfile(datapath, 'cell4_spikes_test.txt');

exp = proj.insertExperiment('cell 4', datetime(2012,7,30));

ImportCell(ctx,...
    exp,...
    'cell4',...
    probeStimPath,...
    probeSpikesPath,...
    testStimPath,...
    testSpikesPath,...
    parameters);