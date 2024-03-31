% This function initializes a new landmark by adding its position in the
% state vector and update the corresponding covariance.
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
%       zi: ith observation of the measurement z 
%           z(1) = distance to the landmark (in meters)
%           z(2) = bearing to the landmark  (radians)
%           z(3) = id/signature of the landmark 
% Output:
%       state: updated state structure after initializing a new landmark
function state = initialize_new_landmark(state, zi)
% TODO: Initialize a new landmark

state.num_lm = state.num_lm + 1;
ind_lm(1) = state.mu(1,1) + zi(1)*cos(zi(2) + state.mu(3));
ind_lm(2) = state.mu(2,1) + zi(1)*sin(zi(2) + state.mu(3));
state.s_lm(state.num_lm) =  zi(3);

state.mu(2*state.num_lm + 2:2*state.num_lm + 3,1) =  [ind_lm(1) ; ind_lm(2) ];

state.ind_lm{state.num_lm} = [size(state.mu,1)-4 ; size(state.mu,1)-3 ];
state.cov(2*state.num_lm + 2,2*state.num_lm + 2) = 1;
state.cov(2*state.num_lm + 3,2*state.num_lm + 3) = 1;

end