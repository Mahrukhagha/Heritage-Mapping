% This function performs the data association between landmarks observed in
% the current measurement to the landmarks already in the map (state
% vector) using the landmark signatures/id.
% Input:
%       state: struct containing state variables
%           mu  =  state vector containing 2D robot pose and 2D lanmark locations
%                  [x, y, theta, l1x, l1y, ..... lnx, lny]' [(3+2N),1]
%           cov =  covariance matrix [(3+2N), (3+2N)]
%           s_lm = signature/id of the landmark
%           num_lm = number of landmarks currently in the state vector
%           ind_lm =  num_lm cell array containing indices of landmark i
%                   ind_lm{i}(1) = index for the x coordinate of landmark i   
%                   ind_lm{i}(2) = index for the y coordinate of landmark i
%       z: measurement 
%           known data assoiation [2x num_observations]
%           unknown data association [3x num_observations]
%           z(1,i) = distance to the landmark for the ith observation (in meters)
%           z(2,i) = bearing to the landmark for the ith observation (radians)
%           z(3,i) = signature/id of the ith observation (in case the ids are known)
% Output:
%        L_ids: landmarks ids/signatures in the map corresponding to each landmark  
%        in the current observation (-1 is assigned in case no
%        correspondence is found) [num_observations x 1]
function L_ids = landmark_association_known(state, z)
L_ids = zeros(1,size(z,2));
for i = 1:size(z,2)
    find_id = find(state.s_lm == z(3,i));
    if ~isempty(find_id)
        L_ids(i)= z(3,i);
    else
        L_ids(i)=-1;
    end
    %L_ids(i) = z(3,i);
end
end

