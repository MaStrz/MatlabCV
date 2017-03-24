% Auto-generated by cameraCalibrator app on 07-Jan-2017
%-------------------------------------------------------


% Define images to process
imageFileNames = {'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230241_001.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230248_002.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230253_003.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230300_004.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230310_005.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230314_006.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230323_007.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230335_008.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230347_009.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230416_010.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230432_011.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230437_012.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230439_013.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230500_014.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230504_015.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230512_016.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230525_017.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230626_022.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_230642_023.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_232817_001.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_232829_002.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_232832_003.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_232837_004.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_232845_005.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_232853_006.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_232900_007.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_232904_008.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233312_001.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233317_002.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233327_003.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233334_004.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233337_005.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233345_006.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233352_007.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233359_008.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233406_009.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233411_010.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233415_011.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233417_012.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233420_013.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0415_233423_014.JPG',...
    'X:\Computer_Vision\kalibracja\HD_1080p\chess_10mm\2016_0416_013619_001.JPG',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Generate world coordinates of the corners of the squares
squareSize = 10;  % in units of 'mm'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', true, 'EstimateTangentialDistortion', true, ...
    'NumRadialDistortionCoefficients', 3, 'WorldUnits', 'mm');

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams, 'BarGraph');

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
originalImage = imread(imageFileNames{1});
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('SparseReconstructionExample')
