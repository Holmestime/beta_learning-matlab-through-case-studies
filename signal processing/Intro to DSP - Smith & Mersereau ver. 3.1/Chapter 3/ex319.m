% Exercise 3.1.9. The Multiplication Property.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.
clc; clear; close all;

%% Signal Definitions.
ff = [0.029515 0.08774473 0.1672274 0.2398594 0.2715347 0.2398594 0.1672274 0.08774473 0.029515];
n = 0:8; % signal ff starts at n=0.

gg = [0.00307787 0.001838499 0.0009756996 0.02195124 0.06561216 0.09 0.06561216 0.02195124 ...
          0.0009756996 0.001838499 0.00307787];

ff_ext = [0 ff 0]; % To make its length equal to length(gg);

ffgg = ff_ext.*gg; % Product signal in time domain.
      
n1 = 0:10; % signal starts at n1=0;

% Plot the signals in time domain.
figure('Name','Exercise 3.1.9. The Multiplication Property');
subplot(4,1,1);
stem(n,ff,'*');
title('ff[n]');
grid on;

subplot(4,1,2);
stem(n1,gg,'r*');
title('gg[n]');
grid on;

subplot(4,1,3);
stem(n1,ff_ext,'c*');
title('ff_e_x_t[n]');
grid on;

subplot(4,1,4);
stem(n1,ffgg,'g*');
title('ff_e_x_t[n]*gg[n]'); 
grid on;

%% Step (c).  Calculate and Display the magnitudes of FF(j�) and GG(j�).

% Computation of an approximation of the DTFT of ff[n]:
[w FF] = my_DTFT(ff_ext,n1);

% Plot the magnitude and the phase of the FF(j�):
figure('Name','Exercise 3.1.9. The Multiplication Property');
subplot(3,2,1);
plot(w,abs(FF),'c');
title('|FF(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

subplot(3,2,2);
plot(w,unwrap(angle(FF)),'m');
title('{\angle}FF(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

% Computation of an approximation of GG(j�):
[w GG] = my_DTFT(gg,n1);

% Plot the magnitude and the phase of GG(j�):
subplot(3,2,3);
plot(w,abs(GG),'r');
title('|GG(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

subplot(3,2,4);
plot(w,unwrap(angle(GG)),'g');
title('{\angle}GG(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

%% Calculate the DTFT of the product ff[n]*gg[n]: 
[w FFGG] = my_DTFT(ffgg,n1);

subplot(3,2,5);
plot(w,abs(FFGG),'b');
hold on;
title('|FF(j\omega)\astGG(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4',' 0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

subplot(3,2,6);
plot(w,angle(FFGG),'k');
hold on;
title('{\angle}FF(j\omega)\astFF(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

%% Calculate the circular convolution of FF(j�) and GG(j�) and plot its magnitude and phase:
% Calculate the circular convolution as a continuous time Riemann Integral from formula (3.5).
NSamples = 1024;
Y = zeros(1,2*NSamples+1);
dtheta = pi/NSamples; % This is d� i.e. the digital frequency differential.
GGrev = fliplr(GG);        % This corresponds to GG(-�). � in rad. 
                                        % circshift(GGrev,[0  i]) corresponds to GG(�-�). 
for i=-NSamples:NSamples      
      k = i + NSamples + 1;
      Y(k) = 1/(2*pi)*FF*(circshift(GGrev,[0  i])).'*dtheta; 
end

%% Plot the Convolution as calculated by the above Riemann Integral approximation:
disp('Hit any key to see the conv(FF(j�),GG(j�)) computed using the definition formula.'); 
pause(); 
subplot(3,2,5); 
stem(w,abs(Y),'r.','Marker','none');
hold on; 

subplot(3,2,6);
stem(w,angle(Y),'r.','Marker','none');
