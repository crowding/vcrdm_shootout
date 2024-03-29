function exerciseDots
    import OSXdots.*

    %Collects some "fake" dots data, by capturing calls to rand() and
    %Screen.
    
    try
        %initialize the screen
        % touchscreen is 34, laptop is 32, viewsonic is 38
        screenInfo = openExperiment(34,50,0);
        %screenInfo = setupScreen(38,50)
        % initialize dots
        % look at createMinDotInfo to change parameters
        dotInfo = createMinDotInfo(1);

        [frames, rseed, start_time, end_time, response, response_time] = dotsX(screenInfo, dotInfo);
        %showTargets(screenInfo, targets, [1 2 3])
        pause(0.5)

        % clear the screen and exit
        closeExperiment;
        %closeScreen(screenInfo.curWindow, screenInfo.oldclut)
    catch
        disp('caught')
        %screenInfo
        closeExperiment;
        %closeScreen(screenInfo.curWindow, screenInfo.oldclut)
    end;
end