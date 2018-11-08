%HBP Task (Schandry 1981)
%This script plays the HBP wav file and produces markers for each interval

% Define the adress of the parallel port:
port_adr = parallel_port_setup();

% Define intervals:
HBP_intervals = [25 15 15];

%Define markers
HBP_mrkrs = [101:110];
start_idx = 1:2:9;
end_idx = 2:2:10;


%Check setup

disp('Have you checked:')
disp('1)HBP form and 2) Speakers?')
disp('If both yes, then press y to start')

start_HBP = input('', 's');
while 1
    switch start_HBP
        case 'y'
            
            %wavfilename = 'HBP.wav';
            ready_wav = 'bereit.wav';
            count_wav = 'zaehlen.wav';
            stop_wav = 'stop_notierenSie.wav';
            [ready_y, ready_freq] = audioread(ready_wav);
            [count_y, count_freq] = audioread(count_wav);
            [stop_y, stop_freq] = audioread(stop_wav);
            ready_wavedata = ready_y';
            count_wavedata = count_y';
            stop_wavedata = stop_y';
            ready_nrchannels = size(ready_wavedata,1);
            count_nrchannels = size(ready_wavedata,1);
            stop_nrchannels = size(ready_wavedata,1);
            InitializePsychSound(1);
            ready_pahandle = PsychPortAudio('Open', [], [], 0, ready_freq, ready_nrchannels);
            count_pahandle = PsychPortAudio('Open', [], [], 0, count_freq, count_nrchannels);
            stop_pahandle = PsychPortAudio('Open', [], [], 0, stop_freq, stop_nrchannels);
            
            
            for iinterv=1:length(HBP_intervals)
                PsychPortAudio('FillBuffer', ready_pahandle, ready_wavedata);
                PsychPortAudio('Start', ready_pahandle, 1, 0);
                WaitSecs(3);

                PsychPortAudio('FillBuffer', count_pahandle, count_wavedata);

                PsychPortAudio('Start', count_pahandle, 1, 0);
                WaitSecs(0.7);
                send_mrkr_v2(HBP_mrkrs(start_idx(iinterv)), port_adr);

                WaitSecs(HBP_intervals(iinterv));
                
                PsychPortAudio('FillBuffer', stop_pahandle, stop_wavedata);
                PsychPortAudio('Start', stop_pahandle, 1, 0);
                WaitSecs(0.5);
                send_mrkr_v2(HBP_mrkrs(end_idx(iinterv)), port_adr);
                WaitSecs(13);
            end
            
            WaitSecs(4);
           
            
        break
        otherwise
            disp('Start HBP recording nevertheless? yes(y) or no(n)');
            fprintf('\n');
            start_HBP_2 = input('', 's');
            if start_HBP_2 == 'y'
                start_HBP = 'y';
                continue
            elseif start_rest_2 == 'n'
                disp('We skip HBP!');
                pause(1);
                return
            else
                disp('Please press either y or n!');
                disp('Have you started the HBP file?');
                disp('y = yes, let''s go!');
                
                start_HBP = input('?', 's');
            end
            
    end
end