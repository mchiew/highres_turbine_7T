function sens = estimate_sens(data, kernel, thresh)
%
%
% sens = estimate_sens(data, kernel, threshold)
%
%   Mark Chiew
%   May 2014
%
%   Estimate coil sensitivities using Adaptive Combine (Walsh, MRM 2000)
%
%   data is [Nc x Nx x Ny x Nz] complex data array
%   kernel is a radius 
%   thresh is the threshold for sensitivity masking
%
%   sens is a [Nc, Nx, Ny, Nz] complex sensitivity array
%   Phases are anchored to the sensitivity of the first channel
%   and sensitivities are normalised

dims    =   size(data);

N   =   prod(dims(2:end));

sens    =   zeros(size(data));
mask    =   zeros(size(data(1,:,:,:)));

for i = 1:N   
    
    [x,y,z] =   ind2sub(dims(2:end),i);
    ii      =   getROIidx(dims(2:end), [x,y,z], kernel);
    R       =   double(data(:,ii)*data(:,ii)');
    [V,D]   =   eigs(R,1);

    %   Pin coil-phase to first channel
    sens(:,i)   =   V*exp(-1j*angle(V(1)));
    mask(i)     =   sqrt(D);
end

sens    =   permute(sens.*(abs(mask)>thresh*max(abs(mask(:)))),[2,3,4,1]);

function idx = getROIidx(dims, centre, r)

if length(dims)==2
    centre  =   centre(1:2);
    if isscalar(r)
        r   =   [r r];
    end
    [sx, sy]    =   ndgrid(-r(1):r(1),-r(2):r(2));
    xy = bsxfun(@plus, centre, [sx(:) sy(:)]);
    xy = bsxfun(@min, max(xy,1), dims); 
    xy = unique(xy,'rows');                     

    test    =   sum(bsxfun(@rdivide,xy-repmat(centre,size(xy,1),1),r).^2,2).^0.5;
    roi     =   find(test <= 1);

    idx =   sub2ind(dims, xy(roi,1), xy(roi,2));
elseif length(dims) == 3
    if isscalar(r)
        r   =   [r r r];
    end
    [sx, sy, sz]    =   ndgrid(-r(1):r(1),-r(2):r(2),-r(3):r(3));
    xyz = bsxfun(@plus, centre, [sx(:) sy(:) sz(:)]);
    xyz = bsxfun(@min, max(xyz,1), dims); 
    xyz = unique(xyz,'rows');                     

    test    =   sum(bsxfun(@rdivide,xyz-repmat(centre,size(xyz,1),1),r).^2,2).^0.5;
    roi     =   find(test <= 1);

    idx =   sub2ind(dims, xyz(roi,1), xyz(roi,2), xyz(roi,3));
end
