function k = gen_k(incr, N_r, N_proj)

%   If incr = 0, means Golden Ratio-based projection spacing

if ~isa(incr, 'function_handle')
    if incr == 0
        ang_fn  =   @(x) (x-1)*360/(1+sqrt(5));
    else
        ang_fn  =   @(x) incr*(x-1);
    end
else
    ang_fn  =   incr;
end

%   Generate radial spacing information
dr  =   1/N_r;
r   =   (-0.5:dr:(N_r-1)*dr-0.5);
shift        =   [0.5/N_r 0.5/N_r];

%   Generate angles
angles  =   mod(ang_fn(1:N_proj), 360);

%   Initialise output arrays
k0   =   zeros(N_r, N_proj);

%   Populate output arrays
for i = 1:N_proj
   k0(:,i)   =   (2*pi)*(r*exp(+1j*pi*angles(i)/180) + shift(1)*cosd(angles(i)) + 1j*shift(2)*sind(angles(i)));
end

k  =   zeros(N_r, N_proj, 2);
k(:,:,1)   =   real(k0);
k(:,:,2)   =   imag(k0);