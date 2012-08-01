MCN 2012 Problem Set 2
======================

This project contains Ovation code to import and read data for MCN Problem Set 2.


Import
------

The data for problem set 2 has already been imported into the MCN 2012 Ovation database. You do not need to re-import the data, but take a look at src/ImportCell.m for an example of how data import works in Ovation. ImportCell.m contains code to import a single cell's data for the problem set. 

You may also find src/readTextData.m useful. It reads a numeric array from the value-per-file text format used in the problem set's original data.


Using the data
--------------

1. Connect to the Ovation database, entering your database account username and password whem prompted. If you don't have an account, see the instructions in Barry's slides:

		>> context = NewDataContext('mcn29.local::/var/lib/ovation/data/mcn2012.connection');

1. Find the Source object representing the cell of interest:

		>> cells = context.getSources('cell1'); % or 'cell2', 'cell3', 'cell4'
		>> assert(length(cells) == 1)
		>> cell = cells(1);

1. Get the EpochGroup (a block of trials) for the condition of interest ("probe" or "test"):

		>> epochGroups = cell.getEpochGroups('probe'); % or 'test'
		>> assert(length(epochGroups) == 1)
		>> epochGroup = epochGroups(1);

1. Get a matrix of stimulus data (one row per Epoch) for this epoch group (src/ must be on your Matlab path):

		>> stimulusData = groupStimulusData(epochGroup);

1. Get a cell array of spike times (one entry per Epoch). Spike times are in seconds relative to the start of the Epoch:

		>> spikeTimes = groupSpikeTimes(epochGroup)