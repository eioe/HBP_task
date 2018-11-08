%HBP Task (Schandry 1981)
%This script plays the HBP wav file and produces markers for each interval

% Setup the triggering at the beginning of script:
%config_io;

% Define the adress of the parallel port:
port_adr = hex2dec('D010');
%  and set pins to 0:
%outp(port_adr, 0);


%Define markers
HBP_1 = 101;
HBP_2 = 102;
HBP_3 = 103;
HBP_4 = 104;
HBP_5 = 105;
HBP_6 = 106;
HBP_7 = 107;
HBP_8 = 108;
HBP_9 = 109;
HBP_10= 110;

%Check setup

disp('Have you checked:')
disp('1)HBP form and 2) Speakers?')
disp('If both yes, then press y to start')

start_HBP = input('', 's');
while 1
    switch start_HBP
        case 'y'
            
            wavfilename = 'HBP.wav';
            [y, freq] = audioread(wavfilename);
            wavedata = y';
            nrchannels = size(wavedata,1);
            InitializePsychSound;
            pahandle = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
            PsychPortAudio('FillBuffer', pahandle, wavedata);
            const.HBPStart = GetSecs;
            const.HBPStartFile = PsychPortAudio('Start', pahandle, 1, 0);
            
            %Send Start Trigger (first interval)
            WaitSecs(10);
            %send_mrkr(HBP_1);
            GetSecs;
            %Send End trigger (first interval)
            WaitSecs(25);
            %send_mrkr(HBP_2);
            GetSecs;

            %Send Start Trigger (second interval)
            WaitSecs(13);
            %send_mrkr(HBP_3);
            GetSecs;
            %Send End trigger (second interval)
            WaitSecs(45);
            %send_mrkr(HBP_4);
            GetSecs;

            %Send Start Trigger (third interval)
            WaitSecs(13);
            %send_mrkr(HBP_5);
            GetSecs;
            %Send End trigger (third interval)
            WaitSecs(15);
            %send_mrkr(HBP_6);
            GetSecs;

            %Send Trigger (fourth interval)
            WaitSecs(13);
            %send_mrkr(HBP_7);
            GetSecs;
            %Send End trigger (fourth interval)
            WaitSecs(55);
            %send_mrkr(HBP_8);
            GetSecs;

            %Send Trigger (fifth interval)
            WaitSecs(13);
            %send_mrkr(HBP_9);
            GetSecs;
            %Send End trigger (fifth interval)
            WaitSecs(35);
            %send_mrkr(HBP_10);
            GetSecs;
            
            WaitSecs(4);
            
            [a, b, c, const.HBPEndFile] = PsychPortAudio('Stop', pahandle);
            PsychPortAudio('Close', pahandle); 
            
            
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