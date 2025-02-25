% ENG6 Project 1 Solution

% Copyright (c) 2012, S. Hsu
% All rights reserved.

% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in the
%       documentation and/or other materials provided with the distribution.
%     * Neither the name of the University of California, Davis nor the
%       names of its contributors may be used to endorse or promote products
%       derived from this software without specific prior written permission.

% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
% ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
% ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


clear all

% Task 26
load Xstate.mat
load Ystate.mat
load myState.mat
load weather.mat
imdata=imread('PartUSA.tif');
imshow(imdata);
city_index = -1;
exit = 0;
while(city_index == -1 && exit == 0)
    [x y] = ginput(1);
    for i=1:11
        in_boundary = inpolygon(x,y,Xstate(i,:),Ystate(i,:));
        if in_boundary == 1
            city_index = i;
            exit = 1;
            break;
        end
    end
    if in_boundary == 0
        disp('Out of Bound! Click Again!');
    else
        fprintf('You clicked on: %s - (%d,%d)\n\n',myState(city_index,:),x,y);
    end
end

for i=1:length(wind(:,1)),
    if strcmp(myState(city_index,:),state(i,:));
        fprintf('%s, %s has %2.2f kWh of average monthly solar insolation.\n', deblank(city(i,:)), deblank(state(i,:)), sum(solar(i,:))/12);
        fprintf('%s, %s has %2.2f mph of average monthly wind speed.\n', deblank(city(i,:)), deblank(state(i,:)), sum(wind(i,:))/12);
    end
end
