%% Load Data and Dependencies
load('single_slice_prepared');
addpath('utils');

%% Setup Parameters
Nt = 128;
Nc = 32;
Nro = 576;
Nx = 288;
Ns = size(data,2);

%% Generate K-Space Sampling Locations
k = gen_k(0,Nro,Ns);

%% Estimate Sensitivities
% Reconstruct temporal mean image
E = xfm_NUFFT([Nx,Nx,1,1],[],reshape(k,[],1,2));
for i = 1:Nc
    tmp(:,i) = E.iter(reshape(data(:,:,i),[],1).*E.w, @pcg, 1E-4, 10, [1 1 0 0]);
end

% Adaptive combine weights for sensitivities
sens = estimate_sens(permute(reshape(tmp,Nx,Nx,Nc),[3,1,2]),15,0.1);

%% Image Reconstruction
% Construct forward model operator
E = xfm_NUFFT([Nx,Nx,1,Nt],sens,reshape(k,[],Nt,2),'wi',1);

% Conjugate Gradient reconstruction with temporal smoothing
Niters = 200;
lambda = 1E5;
img = E.iter(reshape(data,[],Nt,Nc), @pcg, 1E-4, Niters, [0 0 0 lambda]);
img = reshape(img, Nx, Nx, Nt);