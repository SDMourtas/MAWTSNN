# Multi-function activated WASD for time-series Neural Network
Implementation of a 3-layer feed-forward neural network (NN) model for time-series modeling and forecasting problems that is trained using a multi-function activated WASD (weights-and-structure-determination) for time-series algorithm, called MAWTS.
The purpose of this package is to solve time-series modeling and forecasting problems. The MAWTS algorithm employs four activation functions (AFs) to determine the MAWTSNN’s optimal weights and structure, while employing cross-validation to avoid overfitting.
The main article used is the following:
*	S.D.Mourtas, V.N.Katsikis, "Continuous-Time Black-Litterman Portfolio Optimization: A Neural Network Approach", (submitted)

Also, the package includes the following two datasets:
*	Board of Governors of the Federal Reserve System (US), Industrial Production: Utilities: Electric and Gas Utilities (NAICS = 2211,2) [IPG2211A2N], retrieved from FRED at https://fred.stlouisfed.org/series/IPG2211A2N
*	Board of Governors of the Federal Reserve System (US), Industrial Production: Mining, Quarrying, and Oil and Gas Extraction: Gold Ore and Silver Ore Mining (NAICS = 21222) [IPG21222S], retrieved from FRED at https://fred.stlouisfed.org/series/IPG21222S

# M-files Description
*	Main_MAWTSNN.m: the main function
*	problem.m: input data and parameters of the MAWTSNN
*	MAWTS.m: function for finding the optimal number of hidden-layer neurons, along with the optimal activation function power at each hidden-layer neuron
*	LSVM.m: function for creating a neural network model based on linear SVM method
*	EGPR.m: function for creating a neural network model based on exponential GPR method
*	EBT.m: function for creating a neural network model based on ensemble bagged trees method
*	WASD_PFN.m: function for creating a WASD-based PFN model
*	OHLW.m: function for finding the optimal hidden-layer neurons weights of the PFN
*	WASD.m: function for finding the optimal input-layers number of the PFN
*	testPFN.m: function for testing the optimal hidden-layer neurons weights of the PFN
*	Normalization.m: function for normalization
*	Qmatrix.m: function for calculating the matrix Q
*	Qmatrix2.m: function for calculating the matrix Q
*	predictN.m: function for forecasting with MAWTSNN
*	predictNN.m: function for forecasting with LSVM, EGPR and EBT
*	error_pred.m: function for calculating the R-squared, MAPE, MAE and RMSE of the test data
*	test_NN.m: a function that prepares input data for use with NNs
*	Problem_figures.m: function for creating the results figures

# Installation
*	Unzip the file you just downloaded and copy the MAWTSNN directory to a location,e.g.,/my-directory/
*	Run Matlab/ Octave, Go to /my-directory/MAWTSNN/ at the command prompt
*	run 'Main_MAWTSNN (Matlab/Octave)

# Results
After running the 'Main_MAWTSNN.m file, the package outputs are the following:
*	The optimal number of hidden-layer neurons and the optimal input variables number.
*	The models predictions and statistics on the testing samples.
*	The graphic illustration of the training and forecasting performance.

# Environment
The MAWTSNN package has been tested in Matlab 2021a on OS: Windows 10 64-bit.
