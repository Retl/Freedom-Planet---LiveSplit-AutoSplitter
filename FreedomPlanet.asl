state("FP", "1.20.6")
{
    int frame : "FP.exe", 0x1DD4D50;
    double igtPure : "FP.exe", 0x1D7AC18;
    double tally : "FP.exe", 0x1DA0280;
    double altTally : "FP.exe", 0x1DA0268;

    double minutes : "FP.exe", 0x01DD7E20, 0x68;
    double seconds : "FP.exe", 0x01DD7DE0, 0x68;
    double milliseconds : "FP.exe", 0x01DD7DA0, 0x68;

    double charX : "FP.exe", 0x1DA0A70;
    double charY : "FP.exe", 0x1DA0A78;
}

state("FP", "steam-1.21.5-win")
{
    int frame : "FP.exe", 0x1938D40;
    double igtPure : "FP.exe", 0x1D7AC18;
    double tally : "FP.exe", 0x1D7ABB8;
    double altTally : "FP.exe", 0x1D7ABA0;

    double minutes : "FP.exe", 0x193C030, 0x68;
    double seconds : "FP.exe", 0x193BFF0, 0x68;
    double milliseconds : "FP.exe", 0x193BFB0, 0x68;

    double charX : "FP.exe", 0x1D7BC08;
    double charY : "FP.exe", 0x1D7BC10;
}

state("FP", "steam-1.21.5-win-beta")
{
    int frame : "FP.exe", 0x14BDBC8;
    double igtPure : "FP.exe", 0x00000000;
    double tally : "FP.exe", 0x1DA0280;
    double altTally : "FP.exe", 0x1DA0268;

    double minutes : "FP.exe", 0x14C0CB8, 0x68;
    double seconds : "FP.exe", 0x14C0C78, 0x68;
    double milliseconds : "FP.exe", 0x14C0C38, 0x68;

    double charX : "FP.exe", 0x14BDBC8;
    double charY : "FP.exe", 0x14BDBC8;
}

state("FP", "1.20.4")
{
    int frame : "FP.exe", 0x1DAE338;
    double igtPure : "FP.exe", 0x1D7AC18;
    double tally : "FP.exe", 0x1D7ABB8;
    double altTally : "FP.exe", 0x1D7ABA0;

    double minutes : "FP.exe", 0x01DB13A8, 0x68; // milli offset + 0x80
    double seconds : "FP.exe", 0x01DB1368, 0x68; // milli offset + 0x40
    double milliseconds : "FP.exe", 0x01DB1328, 0x68;

    double charX : "FP.exe", 0x1D7BC08;
    double charY : "FP.exe", 0x1D7BC10;
}

startup
{
    vars.tokenFPPOS = "_FP_POS";
    vars.tokenFPSPD = "_FP_SPD";
    vars.tokenFPSCRN = "_FP_SCRN";
    
    settings.Add("enableTimeTrial", true, "enableTimeTrial - Leave enabled if doing Time Trial ILs to prevent GameTime from being logged as 0:00:00.");
    //--------------------------------------------------
    settings.Add("enableLevelEndSplits", true, "Enable to allow the automatic Level-End splits on the levels checked below. They will be ignored if this is unchecked.");
    settings.Add("enableAT4_LE", true, "AT4 - Enable to allow the automatic Level-End splits for AT4.", "enableLevelEndSplits");
    settings.Add("enableDV4_LE", true, "DV4 - Enable to allow the automatic Level-End splits for DV4.", "enableLevelEndSplits");
    settings.Add("enableRM5_LE", true, "RM5 - Enable to allow the automatic Level-End splits for RM5.", "enableLevelEndSplits");
    settings.Add("enableFN6_LE", true, "FN6 - Enable to allow the automatic Level-End splits for FN6.", "enableLevelEndSplits");
    settings.Add("enableSBHUB_LE", true, "SBHUB - Enable to allow the automatic Level-End splits for SBHUB.", "enableLevelEndSplits");
    settings.Add("enableJC5_LE", true, "JC5 - Enable to allow the automatic Level-End splits for JC5.", "enableLevelEndSplits");
    settings.Add("enableTB6_LE", true, "TB6 - Enable to allow the automatic Level-End splits for TB6.", "enableLevelEndSplits");
    settings.Add("enablePL6_LE", true, "PL6 - Enable to allow the automatic Level-End splits for PL6.", "enableLevelEndSplits");
    settings.Add("enableTH3_LE", true, "TH3 - Enable to allow the automatic Level-End splits for TH3.", "enableLevelEndSplits");
    settings.Add("enableBG6_LE", true, "BG6 - Enable to allow the automatic Level-End splits for BG6.", "enableLevelEndSplits");
    settings.Add("enableFD2_LE", true, "FD2 - Enable to allow the automatic Level-End splits for FD2.", "enableLevelEndSplits");
    settings.Add("enableFD4_LE", true, "FD4 - Enable to allow the automatic Level-End splits for FD4.", "enableLevelEndSplits");
    settings.Add("enableFD6_LE", true, "FD6 - Enable to allow the automatic Level-End splits for FD6.", "enableLevelEndSplits");
    settings.Add("enableFD8_LE", true, "FD8 - Enable to allow the automatic Level-End splits for FD8.", "enableLevelEndSplits");
    //--------------------------------------------------
    settings.Add("enableScreenSplits", false, "Enable to allow the automatic Screen-Transition splits on the levels checked below. They will be ignored if this is unchecked.");
    settings.Add("enableAT1_Screen", true, "AT1 - Enable to allow the automatic Screen-Transition splits for AT1.", "enableScreenSplits");
    settings.Add("enableAT2_Screen", true, "AT2 - Enable to allow the automatic Screen-Transition splits for AT2.", "enableScreenSplits");
    settings.Add("enableAT3_Screen", true, "AT3 - Enable to allow the automatic Screen-Transition splits for AT3.", "enableScreenSplits");
    settings.Add("enableAT4_Screen", true, "AT4 - Enable to allow the automatic Screen-Transition splits for AT4.", "enableScreenSplits");
    settings.Add("enableDV1_Screen", true, "DV1 - Enable to allow the automatic Screen-Transition splits for DV1.", "enableScreenSplits");
    settings.Add("enableDV2_Screen", true, "DV2 - Enable to allow the automatic Screen-Transition splits for DV2.", "enableScreenSplits");
    settings.Add("enableDV3_Screen", true, "DV3 - Enable to allow the automatic Screen-Transition splits for DV3.", "enableScreenSplits");
    settings.Add("enableDV4_Screen", true, "DV4 - Enable to allow the automatic Screen-Transition splits for DV4.", "enableScreenSplits");
    settings.Add("enableRM1_Screen", true, "RM1 - Enable to allow the automatic Screen-Transition splits for RM1.", "enableScreenSplits");
    settings.Add("enableRM2_Screen", true, "RM2 - Enable to allow the automatic Screen-Transition splits for RM2.", "enableScreenSplits");
    settings.Add("enableRM3_Screen", true, "RM3 - Enable to allow the automatic Screen-Transition splits for RM3.", "enableScreenSplits");
    settings.Add("enableRM4_Screen", true, "RM4 - Enable to allow the automatic Screen-Transition splits for RM4.", "enableScreenSplits");
    settings.Add("enableRM5_Screen", true, "RM5 - Enable to allow the automatic Screen-Transition splits for RM5.", "enableScreenSplits");
    settings.Add("enableFN1_Screen", true, "FN1 - Enable to allow the automatic Screen-Transition splits for FN1.", "enableScreenSplits");
    settings.Add("enableFN2_Screen", true, "FN2 - Enable to allow the automatic Screen-Transition splits for FN2.", "enableScreenSplits");
    settings.Add("enableFN3_Screen", true, "FN3 - Enable to allow the automatic Screen-Transition splits for FN3.", "enableScreenSplits");
    settings.Add("enableFN4_Screen", true, "FN4 - Enable to allow the automatic Screen-Transition splits for FN4.", "enableScreenSplits");
    settings.Add("enableFN5_Screen", true, "FN5 - Enable to allow the automatic Screen-Transition splits for FN5.", "enableScreenSplits");
    settings.Add("enableFN6_Screen", true, "FN6 - Enable to allow the automatic Screen-Transition splits for FN6.", "enableScreenSplits");
    settings.Add("enableSBHUB_Screen", true, "SBHUB - Enable to allow the automatic Screen-Transition splits for SBHUB.", "enableScreenSplits");
    settings.Add("enableSB1_Screen", true, "SB1 - Enable to allow the automatic Screen-Transition splits for SB1.", "enableScreenSplits");
    settings.Add("enableSB2_Screen", true, "SB2 - Enable to allow the automatic Screen-Transition splits for SB2.", "enableScreenSplits");
    settings.Add("enableSB3_Screen", true, "SB3 - Enable to allow the automatic Screen-Transition splits for SB3.", "enableScreenSplits");
    settings.Add("enableJC1_Screen", true, "JC1 - Enable to allow the automatic Screen-Transition splits for JC1.", "enableScreenSplits");
    settings.Add("enableJC2_Screen", true, "JC2 - Enable to allow the automatic Screen-Transition splits for JC2.", "enableScreenSplits");
    settings.Add("enableJC3_Screen", true, "JC3 - Enable to allow the automatic Screen-Transition splits for JC3.", "enableScreenSplits");
    settings.Add("enableJC4_Screen", true, "JC4 - Enable to allow the automatic Screen-Transition splits for JC4.", "enableScreenSplits");
    settings.Add("enableJC5_Screen", true, "JC5 - Enable to allow the automatic Screen-Transition splits for JC5.", "enableScreenSplits");
    settings.Add("enableTB1_Screen", true, "TB1 - Enable to allow the automatic Screen-Transition splits for TB1.", "enableScreenSplits");
    settings.Add("enableTB2_Screen", true, "TB2 - Enable to allow the automatic Screen-Transition splits for TB2.", "enableScreenSplits");
    settings.Add("enableTB3_Screen", true, "TB3 - Enable to allow the automatic Screen-Transition splits for TB3.", "enableScreenSplits");
    settings.Add("enableTB4_Screen", true, "TB4 - Enable to allow the automatic Screen-Transition splits for TB4.", "enableScreenSplits");
    settings.Add("enableTB5_Screen", true, "TB5 - Enable to allow the automatic Screen-Transition splits for TB5.", "enableScreenSplits");
    settings.Add("enableTB6_Screen", true, "TB6 - Enable to allow the automatic Screen-Transition splits for TB6.", "enableScreenSplits");
    settings.Add("enablePL1_Screen", true, "PL1 - Enable to allow the automatic Screen-Transition splits for PL1.", "enableScreenSplits");
    settings.Add("enablePL2_Screen", true, "PL2 - Enable to allow the automatic Screen-Transition splits for PL2.", "enableScreenSplits");
    settings.Add("enablePL3_Screen", true, "PL3 - Enable to allow the automatic Screen-Transition splits for PL3.", "enableScreenSplits");
    settings.Add("enablePL4_Screen", true, "PL4 - Enable to allow the automatic Screen-Transition splits for PL4.", "enableScreenSplits");
    settings.Add("enablePL5_Screen", true, "PL5 - Enable to allow the automatic Screen-Transition splits for PL5.", "enableScreenSplits");
    settings.Add("enablePL6_Screen", true, "PL6 - Enable to allow the automatic Screen-Transition splits for PL6.", "enableScreenSplits");
    settings.Add("enableTH1_Screen", true, "TH1 - Enable to allow the automatic Screen-Transition splits for TH1.", "enableScreenSplits");
    settings.Add("enableTH2_Screen", true, "TH2 - Enable to allow the automatic Screen-Transition splits for TH2.", "enableScreenSplits");
    settings.Add("enableTH3_Screen", true, "TH3 - Enable to allow the automatic Screen-Transition splits for TH3.", "enableScreenSplits");
    settings.Add("enableBG1_Screen", true, "BG1 - Enable to allow the automatic Screen-Transition splits for BG1.", "enableScreenSplits");
    settings.Add("enableBG2_Screen", true, "BG2 - Enable to allow the automatic Screen-Transition splits for BG2.", "enableScreenSplits");
    settings.Add("enableBG3_Screen", true, "BG3 - Enable to allow the automatic Screen-Transition splits for BG3.", "enableScreenSplits");
    settings.Add("enableBG4_Screen", true, "BG4 - Enable to allow the automatic Screen-Transition splits for BG4.", "enableScreenSplits");
    settings.Add("enableBG5_Screen", true, "BG5 - Enable to allow the automatic Screen-Transition splits for BG5.", "enableScreenSplits");
    settings.Add("enableBG6_Screen", true, "BG6 - Enable to allow the automatic Screen-Transition splits for BG6.", "enableScreenSplits");
    settings.Add("enableFD1_Screen", true, "FD1 - Enable to allow the automatic Screen-Transition splits for FD1.", "enableScreenSplits");
    settings.Add("enableFD2_Screen", true, "FD2 - Enable to allow the automatic Screen-Transition splits for FD2.", "enableScreenSplits");
    settings.Add("enableFD3_Screen", true, "FD3 - Enable to allow the automatic Screen-Transition splits for FD3.", "enableScreenSplits");
    settings.Add("enableFD4_Screen", true, "FD4 - Enable to allow the automatic Screen-Transition splits for FD4.", "enableScreenSplits");
    settings.Add("enableFD5_Screen", true, "FD5 - Enable to allow the automatic Screen-Transition splits for FD5.", "enableScreenSplits");
    settings.Add("enableFD6_Screen", true, "FD6 - Enable to allow the automatic Screen-Transition splits for FD6.", "enableScreenSplits");
    settings.Add("enableFD7_Screen", true, "FD7 - Enable to allow the automatic Screen-Transition splits for FD7.", "enableScreenSplits");
    //--------------------------------------------------
    settings.Add("enableDataViewing", false, "Enabled Data-Viewing options. Only tested with steam-windows-1.20.4");
    settings.Add("enablePOSText", false, "Replace a Text Component starting with \"" + vars.tokenFPPOS + "\" with Position information.", "enableDataViewing");
    settings.Add("enableSPDText", false, "Replace a Text Component starting with \"" + vars.tokenFPSPD + "\" with (estimated) Velocity information.", "enableDataViewing");
    settings.Add("enableSCRNText", false, "Replace a Text Component starting with \"" + vars.tokenFPSCRN + "\" with the Screen ID Number.", "enableDataViewing");
    
    //--------------------------------------------------
    settings.Add("enableOldSplitStyle", false, "If enabled, split on every room (except Fortune Night) by looking for the Black Load save screen ID.");
    //--------------------------------------------------
}

init
{
    // Define useful Methods
    vars.InitializeVars = new Action (() =>
    {
        // Version Detection
        vars.fp_size_1_20_6 = 32583680;
        vars.fp_size_1_20_4 = 32362496;
        vars.fp_size_1_21_5_beta = 23064576;
        vars.fp_size_1_21_5 = 28114944;

	// Version Dependant
	vars.frameIdFortuneNightEnd = 34;

        // Other userful vars.
        vars.fullRunMins = 0.0d;
        vars.fullRunSecs = 0.0d;
        vars.fullRunMils = 0.0d;

        vars.timeSpanTally = TimeSpan.Zero;
	vars.onScreenTime = TimeSpan.Zero;

        // String tokens to identify text fields to replace.
        vars.tokenFPPOS = "_FP_POS";
        vars.tokenFPSPD = "_FP_SPD";
        vars.tokenFPSCRN = "_FP_SCRN";

	// For displaying Output, if enabled.
	vars.txtWhich = -1;
	
	vars.txtPOS = null;
	vars.txtPOSWhich = -1;
	vars.txtPOSOriginal = "";

	vars.txtSPD = null;
	vars.txtSPDWhich = -1;
	vars.txtSPDOriginal = "";

	vars.txtSCRN = null;
	vars.txtSCRNWhich = -1;
	vars.txtSCRNOriginal = "";

        // Contain the running tally of TimeSpans for each Frame/Screen with Results Screen
        vars.arrTimes = System.Collections.ArrayList.Repeat(null, 90);

        // For triggering AutoStart/ Split / Reset.
        vars.startPlz = false;
        vars.splitPlz = false;
        vars.resetPlz = false;

        vars.started = false;

        // For rough estimate of character velocity.
        vars.deltCharaX = 0.0d;
        vars.deltCharaY = 0.0d;
        vars.deltCharaMagnitude = 0.0d;

        // Indicates if Results Tally just appeared.
        vars.tallyChanged = false;
        vars.postTally = false; // Tally was shown, but on same Frame/Screen.

        // For tracking the current Frame/Screen.
        vars.frameChanged = false;
        vars.frameChangedSinceTimerZero = false;
        vars.lastFrameSinceTimerZero = 0;
	vars.lastNonZeroTime = 0;
    });
    vars.InitializeVars();

    vars.DetectVersion = new Action (() => 
	{
        version = "UNKNOWN";
        print("@@@@@ MODULE SIZE: " + modules.First().ModuleMemorySize.ToString());
        if (modules.First().ModuleMemorySize == vars.fp_size_1_20_6)
            version = "1.20.6";
        else if (modules.First().ModuleMemorySize == vars.fp_size_1_20_4)
            version = "1.20.4";
        else if (modules.First().ModuleMemorySize == vars.fp_size_1_21_5_beta)
            version = "steam-1.21.5-win-beta";
        else if (modules.First().ModuleMemorySize == vars.fp_size_1_21_5)
            version = "steam-1.21.5-win";
        print("@@@@@ Detected Version: " + version);
    });
    vars.DetectVersion();

    vars.CalcStageTallies = new Func<int, TimeSpan>((int cutoffScreen) =>
	{
		TimeSpan result = TimeSpan.Zero;
		for (int i = 0; (i < vars.arrTimes.Count); i++)
		{
			if (vars.arrTimes[i] != null)
			{
				result += vars.arrTimes[i];
				print("Individual Tally[" + i.ToString() + "]: " + vars.arrTimes[i].ToString());
			}
			else
			{
				print("Individual Tally[" + i.ToString() + "]: is null!");
			}
		}
		print("Calculating Stage Tallies: " + result.ToString());
		return result;
	});

    vars.RestoreTextFields = new Action (() =>
	{
        if (settings["enablePOSText"])
        {
            vars.SetTextComponentText(vars.txtPOS, vars.txtPOSWhich, vars.txtPOSOriginal);
        }
        if (settings["enableSPDText"])
        {
            vars.SetTextComponentText(vars.txtSPD, vars.txtSPDWhich, vars.txtSPDOriginal);
        }
        if (settings["enableSCRNText"])
        {
            vars.SetTextComponentText(vars.txtSCRN, vars.txtSCRNWhich, vars.txtSCRNOriginal);
        }
    });

    vars.FindTextComponentByToken = new Func<String, dynamic>((String tokenToReplace) =>
    {
		vars.txtWhich = -1;
        dynamic foundTxtComponent = null;
        foreach (LiveSplit.UI.Components.LayoutComponent lc in vars.layoutComponents)
        {
            if (lc.Component.GetType().ToString() == "LiveSplit.UI.Components.TextComponent")
            {
                vars.comp = lc.Component;
                if (true)
                {
                    if (vars.comp.Settings.Text1.ToUpper().StartsWith(tokenToReplace.ToUpper()))
                    {
                        foundTxtComponent = vars.comp.Settings;
                        vars.txtWhich = 1; // Hack
                        break;
                    }
                    else if (vars.comp.Settings.Text2.ToUpper().StartsWith(tokenToReplace.ToUpper()))
                    {
                        foundTxtComponent = vars.comp.Settings;
                        vars.txtWhich = 2; // Hack
                        break;
                    }
                    else { vars.txtWhich = -1; }
                }
            }
        }
		return foundTxtComponent;
	});

		vars.GetTextComponentText = new Func<dynamic, int, String>((dynamic textComponent, int whichText) =>
		{
			if (whichText == 1) {return textComponent.Text1;}
			else if (whichText == 2) {return textComponent.Text2;}
			else {return "Not found.";}
		});

		vars.SetTextComponentText = new Func<dynamic, int, String, bool>((dynamic textComponent, int whichText, String newString) =>
		{
			if (whichText == 1) {textComponent.Text1 = newString;}
			else if (whichText == 2) {textComponent.Text2 = newString;}
			return true;
		});

    vars.locateDefaultTexts = new Action (() =>
    {
        bool result = true;
        try
        {
            // Get Text Fields to Show Variables In:
            vars.openForms = Application.OpenForms;
            vars.mainForm = vars.openForms[0];
            vars.layout = vars.mainForm.Layout;
            vars.layoutComponents = vars.layout.LayoutComponents;

            vars.comp = null;

            // TODO: Refactor Component ref + WhichTextNum + Original Text into ExpandoObjects
            // TODO: Refactor into new method instead of copypasta nightmare.
            if (settings["enablePOSText"])
            {
                vars.txtPOS = vars.FindTextComponentByToken(vars.tokenFPPOS);
                vars.txtPOSWhich = vars.txtWhich;
                if (vars.txtPOSWhich > -1)
                {
					vars.txtPOSOriginal = vars.GetTextComponentText(vars.txtPOS, vars.txtPOSWhich);
                }
            }

            if (settings["enableSPDText"])
            {
                vars.txtSPD = vars.FindTextComponentByToken(vars.tokenFPSPD);
                vars.txtSPDWhich = vars.txtWhich;
                if (vars.txtSPDWhich > -1)
                {
                    vars.txtSPDOriginal = vars.GetTextComponentText(vars.txtSPD, vars.txtSPDWhich);
                }
            }

            if (settings["enableSCRNText"])
            {
                vars.txtSCRN = vars.FindTextComponentByToken(vars.tokenFPSCRN);
                vars.txtSCRNWhich = vars.txtWhich;
                if (vars.txtSCRNWhich > -1)
                {
                    vars.txtSCRNOriginal = vars.GetTextComponentText(vars.txtSCRN, vars.txtSCRNWhich);
                }
            }


        }
        catch (Exception e) { result = false; }
    });
    vars.locateDefaultTexts();
}

update
{
	vars.onScreenTime = new TimeSpan(0, 0, Convert.ToInt32(current.minutes), Convert.ToInt32(current.seconds), Convert.ToInt32((current.milliseconds) * 10));
    // Calculate additional values based on game state.
	if (vars.onScreenTime != TimeSpan.Zero) {vars.lastNonZeroTime = vars.onScreenTime;}

    if (current.charX != null
        && current.charY != null
        && old.charX != null
        && old.charY != null)
    {
        vars.deltCharaX = current.charX - old.charX;
        vars.deltCharaY = current.charY - old.charY;
        vars.deltCharaMagnitude = current.charY - old.charY;
    }

    vars.tallyChanged = (current.tally != old.tally && current.tally != 0);
    if (vars.tallyChanged) { print("@@@@@Tally Changed: " + vars.tallyChanged.ToString()); }
    vars.frameChanged = (current.frame != old.frame && (current.frame != 0 && current.frame != -1));

    if (vars.frameChanged)
    {
        vars.frameChangedSinceTimerZero = true;
        vars.lastFrameSinceTimerZero = old.frame;
		vars.postTally = false;
		print("Frame Changed: " + old.frame + " => " + current.frame );
    }

    //vars.timerWasReset = (old.minutes > 0 && current.minutes == 0 && current.seconds == 0 && current.milliseconds <= 50);

    // Update text displays
    if (settings["enablePOSText"] && vars.txtPOS != null)
    {
         String posTxt = "(X,Y): ("
            + String.Format("{0:0.000}", current.charX)
            + "," + String.Format("{0:0.000}", current.charY)
            + ")";

			vars.SetTextComponentText(vars.txtPOS, vars.txtPOSWhich, posTxt);
    }

    if (settings["enableSPDText"] && vars.txtSPD != null)
    {
        String spdTxt = "(XSPD,YSPD): ("
            + String.Format("{0:0.000}", vars.deltCharaX)
            + "," + String.Format("{0:0.000}", vars.deltCharaY)
            + ")";
			vars.SetTextComponentText(vars.txtSPD, vars.txtSPDWhich, spdTxt);
    }

    if (settings["enableSCRNText"] && vars.txtSCRN != null)
    {
        String scrnTxt = "Screen ID: " + String.Format("{0:0}", current.frame);
		vars.SetTextComponentText(vars.txtSCRN, vars.txtSCRNWhich, scrnTxt);
    }

	// If Enabled, Triggers AutoStart/Split/Reset.
	//screen 87 = credits
	
    vars.splitPlz = vars.tallyChanged;
    vars.resetPlz = (current.frame == 3 && old.frame != 3);
					/*
    vars.startPlz = (current.frame != 3 && current.minutes == 0 
		&& current.seconds == 0 && current.milliseconds <= 90 
		&& current.milliseconds > 0);

		*/
	//timer starts when either Dragon Valley or Aqua Tunnel first screens are loaded out of the character select.
	//ID 83 = Brevon Ship Crash cutscene (for Adventure Mode)
	vars.startPlz = ((old.frame == 6) && (current.frame == 20 || current.frame == 16 || current.frame == 83)
	//The next comparison makes this compatible with Adventure Mode on 1.20.x
	|| (old.frame == 3 && current.frame == 83));
    if (vars.frameChanged) { vars.started = false; }
}

exit
{
	// Triggers when FP.exe is closed.
    vars.RestoreTextFields();
	vars.InitializeVars();
}

shutdown
{
	// Triggers when Scriptable AutoSplit Component removed or LiveSplit closed.
    vars.InitializeVars();
}

start
{
    if (settings["enableTimeTrial"])
    {
        // Quick and hacky hardcoding of the usual playble level range.
        if (current.frame != old.frame 
        && old.frame == 5
        && current.frame >= 16
        && current.frame <= 72        ) {return true;}
    }
    else 
    {
        // Runs every tick: AutoStart the Timer when the Timer goes from 0 to less than one second.
        if (vars.startPlz && !vars.started)
        {
            vars.started = true;
            return true;
        }
        return false;
    }
    
}

reset
{
    if (settings["enableTimeTrial"])
    {
        // Autoreset on the Time Trial menu.
        if (current.frame != old.frame
            && current.frame == 5) {
            return true;
        }
        return false;
    }
    else
    {
        // Runs every tick: AutoReset the Timer on the Main Menu.
        if (vars.resetPlz)
        {
            print("Performing reset.");
            vars.InitializeVars();
            return true;
        }
        return false;
    }
}

split
{
	// Split just before the Results Tally is Displayed.
	int alt = old.frame;
    if (vars.tallyChanged)
    {
        vars.postTally = true;
		vars.arrTimes[current.frame] = vars.onScreenTime;
        vars.timeSpanTally = vars.CalcStageTallies(current.frame);
    }
	else if (alt == vars.frameIdFortuneNightEnd && current.frame == 8)
	/*
	for FN, the split happens after the screen transition happened.
	so the split process has 2 parts, one for each screen transition.
	*/
	{
		print("FORTUNE NIGHT SPLIT.");
		vars.arrTimes[alt] = vars.lastNonZeroTime;
		vars.timeSpanTally = vars.CalcStageTallies(alt+1);
		
	}
	else if (settings["enableOldSplitStyle"]) 
    {
        if (alt == 8 && current.frame == 35){
            vars.splitPlz = true;
        }
    }
    else if (settings["enableScreenSplits"]) 
    {
        if (current.frame != old.frame) {
            if (old.frame == 16 && settings["enableAT1_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 17 && settings["enableAT2_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 18 && settings["enableAT3_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 19 && settings["enableAT4_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 20 && settings["enableDV1_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 21 && settings["enableDV2_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 22 && settings["enableDV3_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 23 && settings["enableDV4_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 24 && settings["enableRM1_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 25 && settings["enableRM2_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 26 && settings["enableRM3_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 27 && settings["enableRM4_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 28 && settings["enableRM5_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 29 && settings["enableFN1_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 30 && settings["enableFN2_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 31 && settings["enableFN3_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 32 && settings["enableFN4_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 33 && settings["enableFN5_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 34 && settings["enableFN6_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 35 && settings["enableSBHUB_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 36 && settings["enableSB1_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 37 && settings["enableSB2_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 38 && settings["enableSB3_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 39 && settings["enableJC1_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 40 && settings["enableJC2_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 41 && settings["enableJC3_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 42 && settings["enableJC4_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 43 && settings["enableJC5_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 44 && settings["enableTB1_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 45 && settings["enableTB2_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 46 && settings["enableTB3_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 47 && settings["enableTB4_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 48 && settings["enableTB5_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 49 && settings["enableTB6_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 50 && settings["enablePL1_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 51 && settings["enablePL2_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 52 && settings["enablePL3_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 53 && settings["enablePL4_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 54 && settings["enablePL5_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 55 && settings["enablePL6_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 56 && settings["enableTH1_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 57 && settings["enableTH2_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 58 && settings["enableTH3_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 59 && settings["enableBG1_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 60 && settings["enableBG2_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 61 && settings["enableBG3_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 62 && settings["enableBG4_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 63 && settings["enableBG5_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 64 && settings["enableBG6_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 65 && settings["enableFD1_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 66 && settings["enableFD2_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 67 && settings["enableFD3_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 68 && settings["enableFD4_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 69 && settings["enableFD5_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 70 && settings["enableFD6_Screen"]) {vars.splitPlz = true;}
            if (old.frame == 71 && settings["enableFD7_Screen"]) {vars.splitPlz = true;}
        } 
    }
    else if (settings["enableLevelEndSplits"]) 
    {
        if (current.frame != old.frame) {
            if (old.frame == 19 && settings["enableAT4_LE"]) {vars.splitPlz = true;}
            if (old.frame == 23 && settings["enableDV4_LE"]) {vars.splitPlz = true;}
            if (old.frame == 28 && settings["enableRM5_LE"]) {vars.splitPlz = true;}
            if (old.frame == 34 && settings["enableFN6_LE"]) {vars.splitPlz = true;}
            if (old.frame == 35 && settings["enableSBHUB_LE"]) {vars.splitPlz = true;}
            if (old.frame == 43 && settings["enableJC5_LE"]) {vars.splitPlz = true;}
            if (old.frame == 49 && settings["enableTB6_LE"]) {vars.splitPlz = true;}
            if (old.frame == 55 && settings["enablePL6_LE"]) {vars.splitPlz = true;}
            if (old.frame == 58 && settings["enableTH3_LE"]) {vars.splitPlz = true;}
            if (old.frame == 64 && settings["enableBG6_LE"]) {vars.splitPlz = true;}
            if (old.frame == 66 && settings["enableFD2_LE"]) {vars.splitPlz = true;}
            if (old.frame == 68 && settings["enableFD4_LE"]) {vars.splitPlz = true;}
            if (old.frame == 70 && settings["enableFD6_LE"]) {vars.splitPlz = true;}
            if (old.frame == 72 && settings["enableFD8_LE"]) {vars.splitPlz = true;}
        } 
    }
    return (vars.splitPlz);
}

isLoading
{
    return true; // Disable time interpolation.
}

gameTime
{
	// Runs every tick: Sets the Game Time for the LiveSplit Timer.
    TimeSpan gt;
    
	if (!settings["enableTimeTrial"]) 
    {
        if (vars.postTally)
        {
            // Don't display the sum until moving to a new Frame/Screen.
            gt = vars.timeSpanTally; // Adventure / Classic Mode only?
        }
        else
        {
            gt = (vars.timeSpanTally + (vars.onScreenTime));
        }
    }
    else 
    {
        gt = vars.lastNonZeroTime;
    }
    
	
	//When the run ends, add 0.06 seconds to estimate the final time, because of the milliseconds.
	//ending cutscene = 85
	if(current.frame == 85)
		gt += new TimeSpan(0, 0,0, 0, 6 * 10); 
	
    return gt;
}
