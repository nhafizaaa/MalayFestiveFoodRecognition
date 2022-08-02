folder = pwd;
S = dir(fullfile(folder,'*.jpg'));
fprintf('Found %d PNG files.\n', length(S));
hFig = figure;
hFig.WindowState = 'maximized';
angles = [90, 180, 270];
for k = 1 : 3
	originalFilename = fullfile(folder, S(k).name);
	[~, baseFileNameNoExt, ~] = fileparts(lower(originalFilename))
	originalImage = imread(originalFilename);
	fprintf('\nRead in %s.\n', originalFilename);
	subplot(2, 2, 1);
	imshow(originalImage);
	title(['Original image : ', S(k).name], 'FontSize', 15);
	
	% Skip files that are the outputs from prior runs.  
	% They will contain '-n.png'
	if endsWith(baseFileNameNoExt, ' -1') || ...
	endsWith(baseFileNameNoExt, ' -2') || ...
	endsWith(baseFileNameNoExt, ' -3')
		continue; % Skip this image.
	end
	
	for angleIndex = 1 : 3
		thisAngle = angles(angleIndex);
		rotatedImage = imrotate(originalImage, thisAngle);
		subplot(2, 2, angleIndex + 1);
		imshow(rotatedImage);
		% Create new name with -1, -2, or -3 appended to the original base file name.
		rotatedName = sprintf('%s -%d.png', baseFileNameNoExt, angleIndex);
		title(rotatedName, 'FontSize', 15);
		fullFileName = fullfile(folder, rotatedName);
		imwrite(rotatedImage, fullFileName);
		fprintf('    Wrote out %s.\n', fullFileName);
	end
	
	promptMessage = sprintf('Do you want to Continue processing,\nor Quit processing?');
	titleBarCaption = 'Continue?';
	buttonText = questdlg(promptMessage, titleBarCaption, 'Continue', 'Quit', 'Continue');
	if contains(buttonText, 'Quit')
		break;
	end
end
close(hFig);