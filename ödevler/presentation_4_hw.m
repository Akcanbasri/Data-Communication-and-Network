Fs = 100; % Yüksek örnekleme frekansı
t = 0:1/Fs:2; % Zaman vektörü
A = 8; % Genlik
f = 1; % Frekans
y = A * sin(2 * pi * f * t); % Sinüzoidal sinyal

% 2 Hz örnekleme
Fs1 = 2;
n1 = 0:Fs/Fs1:2*Fs;
y_sampled_2Hz = y(n1+1);

% 4 Hz örnekleme
Fs2 = 4;
n2 = 0:Fs/Fs2:2*Fs;
y_sampled_4Hz = y(n2+1);

% Kuantalama için kuanta seviyeleri
quant_levels = [-6 -2 2 6];

% Kuantalama işlemi
edges = [-Inf -4 0 4 Inf]; % Sınır değerler
[~,~,bin_idx_2Hz] = histcounts(y_sampled_2Hz,edges);
[~,~,bin_idx_4Hz] = histcounts(y_sampled_4Hz,edges);
y_quant_2Hz = quant_levels(bin_idx_2Hz); % 2 Hz'de kuantalanmış sinyal
y_quant_4Hz = quant_levels(bin_idx_4Hz); % 4 Hz'de kuantalanmış sinyal

% PCM kodlama
pcm_2Hz = de2bi(bin_idx_2Hz-1, 2, 'left-msb');
pcm_4Hz = de2bi(bin_idx_4Hz-1, 2, 'left-msb');
