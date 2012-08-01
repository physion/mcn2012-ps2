% Copyright (c) 2012 Physion Consulting LLC

function spikeTimes = groupSpikeTimes(epochGroup)
% Gets a cell array of spike times (one entry per Epoch) from the given EpochGroup
%
%	spikeTimes = groupSpikeTimes(epochGroup)


	epochs = epochGroup.getEpochs();
	spikeTimes = cell(length(epochGroups), 1)

	for i = 1:length(epochs)
		e = epochs(i);
		spikeDerivedResponses = e.getDerivedResponses('spikes')
		if(length(spikeDerivedResponses) > 1)

		end
		spikeTimes{i} = spikeDerivedResponses(1).getFloatingPointData()';
	end
end