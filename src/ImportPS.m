%% Cell 1

parameters.probe.epochDurationSeconds=60*60;
parameters.probe.stimParameters.sampleRate = 100;
parameters.probe.stimParameters.sampleRateUnits = 'Hz';

parameters.test.epochDurationSeconds=60*60;
parameters.test.stimParameters.numRepetitions = 120;
parameters.test.stimParameters.durationSeconds = parameters.test.epochDurationSeconds / parameters.test.stimParameters.numRepetitions;
parameters.test.stimParameters.sampleRate = 100;
parameters.test.stimParameters.sampleRateUnits = 'Hz';

%% Cell 4

parameters.probe.epochDurationSeconds=60*20;
parameters.probe.stimParameters.sampleRate = 1000;
parameters.probe.stimParameters.sampleRateUnits = 'Hz';

parameters.test.epochDurationSeconds=20*60;
parameters.test.stimParameters.numRepetitions = 120;
parameters.test.stimParameters.durationSeconds = parameters.test.epochDurationSeconds / parameters.test.stimParameters.numRepetitions;
parameters.test.stimParameters.sampleRate = 1000;
parameters.test.stimParameters.sampleRateUnits = 'Hz';