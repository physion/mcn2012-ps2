MCN 2012 Problem Set 2
======================

This project contains Ovation code to import and read data for MCN Problem Set 2.

If Ovation is not installed on your computer, follow the installations instructions on the [wiki](https://github.com/physion/mcn2012-ps2/wiki) before continuing.


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


Saving and Sharing an Analysis Record
-------------------------------------

Once you've done your analysis from the spike times and stimulus data, you may want to save an AnalysisRecord object in the database documenting your work (and making it easy for others in your group or the class to see and make use of your results). Let's create an AnalysisRecord object describing the results of analysis of the cell above.

Ovation-based analysis functions typically have the following pattern:

		function result = myAnalysisFunction(epochsIterator, parameters)

			while(epochsIterator.hasNext())
				epoch = epochsIterator.next();
				%... do something with this epoch ...
			end

			result = ...
		end


For this project, you really want to work with the EpochGroups (see "Using the data" above), so your top-level function can be pretty simple:

		function result = analyzeEpochGroup(epochsIterator, parameters)

			epochGroups = java.util.HashSet();

			while(epochsIterator.hasNext())
				epoch = epochsIterator.next();
				epochGroups.add(epoch.getEpochGroup());
			end

			uniqueGroups = epochGroups.toArray();

			for i = 1:length(uniqueGroups)
				result{i} = myEpochGroupAnalysis(uniqueGroups(i), parameters);
			end
		end

Now, you just need to write myEpochGroupAnalysis() ;-)

1. Insert an AnalysisRecord referencing the Epochs from the experiment describing one cell. You could, of course, reference only the "test", "probe" or any subset of Epochs. Or you could create an AnalysisRecord that spanned many Epochs from any number of Sources. We recommend that you keep your source code in a version control system such as Git or Subversion. We use GitHub. Ovation's AnalysisRecord objects can store the version control system's URL and revision number of the code for that analysis. If you don't have your code in version control you can attach a zip file of the code (see below). Now, let's create an analysis record:

		>> experiments = cell.getExperiments();
		>> experiment = experiments(1); % In this case, there's only one Experiment for the Source
		>> projects = experiment.getProjects();
		>> project = projects(1); % An experiment can belong to more than one Project, but there's only one in this case.
		>> parameters = struct(...); % Matlab 
		>> analysisRecord = project.insertAnalysisRecord('MCN 2012 PS1, Cell 1',... % Pick a descriptive name
			experiment.getEpochsIterable().iterator(),... % An iterator over all the Epochs in the experiment
			'analyzeEpochGroup.m',... % Name of the entry function for your analysis
			struct2map(parameters),... % Analysis parameters
			'https://github.com/physion/mcn2012-ps2.git',... % URL of your code in a source repository. This is the URL for the problem set 2 code, but you would specifiy your own repository (if you have one)
			'23b6c71747a8c5b1aa65152d97a84c89a3bbec2f',... % Revision number of the code for *this* analysis
			);

2. You can add additional text notes to the record describing the analysis or your interpretation:

		>> ar.setNotes('Your notes as a string here...');

3. If you want to add file resources (such as a Matlab figure or PDF, an other document describing the results, or a zip file of code), use the addResource method:

		>> ar.addResource('path/to/a/PDF');

4. You can add tags and properties to AnalysisRecords (just like any other object in the database). You might, for example tag the AnalysisRecord with your group's name so that it's easy to pull out all records for the group:

		>> ar.addTag('awesome group')


You can find your analysis records by name:

		>> record = project.getMyAnalysisRecord('MCN 2012 PS1, Cell 1');

Or get a list of all Analysis Records (belonging to all users) with that name (yours should be one of them):

		>> records = project.getAnalysisRecords('MCN 2012 PS1, Cell 1');

*Note* this means that each user can have AnalysisRecords for a project. Even if they have the same name, they don't conflict.

Want to share this analysis record with someone? Send them a link (of course, your record's URI will be different than the example below):

		>> uri = ar.getURIString()
		ovation:///c9036a2e-e074-49e4-a940-312c8b99c3d1/#2-1001-1-5:1000048

Send this string to your colleauge. Then, they can open your analysis record in their Data Context:

		>> yourRecord = otherContext.objectWithURI('ovation:///c9036a2e-e074-49e4-a940-312c8b99c3d1/#2-1001-1-5:1000048')