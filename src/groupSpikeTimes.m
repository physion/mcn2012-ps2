% Copyright (c) 2012 Physion Consulting LLC

function spikeTimes = groupSpikeTimes(epochGroup)
% Gets a cell array of spike times (one entry per Epoch) from the given EpochGroup
%
%	spikeTimes = groupSpikeTimes(epochGroup)


	epochs = epochGroup.getEpochs();
	spikeTimes = cell(1, length(epochs));

	for i = 1:length(epochs)
		e = epochs(i);
		
        spikeDerivedResponses = e.getDerivedResponses('spikes');
        if(length(spikeDerivedResponses) > 1)
            warning('ovation:mcn2012',...
                'Epoch has more than one DerivedResponse with the name "spikes"');
        end
        
		spikeTimes{i} = spikeDerivedResponses(1).getFloatingPointData()';
	end
end