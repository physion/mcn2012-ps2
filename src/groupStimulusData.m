% Copyright (c) 2012 Physion Consulting LLC

function stimData = groupStimulusData(epochGroup)
% Gets a matrix of stimulus data (row per Epoch) from the given EpochGroup
%
%	stimData = groupStimulusData(epochGroup)


	epochs = epochGroup.getEpochs();
	stimData = cell(length(epochs), 1);

	for i = 1:length(epochs)
		e = epochs(i);
		stimulus = e.getStimulus('Stimulator');
		stimData{i} = stimulus.getStimulusParameter('stimData').getFloatingPointData()';
	end

	stimData = cell2mat(stimData);
end