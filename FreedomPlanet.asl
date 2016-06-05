state("FP", "1.20.6")
{
    int frame : "FP.exe", 0x1DD4D50;
    double igtPure : "FP.exe", 0x1DA02E0;
    double tally : "FP.exe", 0x1DA0280;
    double altTally : "FP.exe", 0x1DA0268;

    double minutes : "FP.exe", 0x01DD7E20, 0x68;
    double seconds : "FP.exe", 0x01DD7DE0, 0x68;
    double milliseconds : "FP.exe", 0x01DD7DA0, 0x68;

    double charX : "FP.exe", 0x1DA0A70;
    double charY : "FP.exe", 0x1DA0A78;
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

    settings.Add("enablePOSText", false, "Replace a Text Component starting with \"" + vars.tokenFPPOS + "\" with Position information.");
    settings.Add("enableSPDText", false, "Replace a Text Component starting with \"" + vars.tokenFPSPD + "\" with (estimated) Velocity information.");
    settings.Add("enableSCRNText", false, "Replace a Text Component starting with \"" + vars.tokenFPSCRN + "\" with the Screen ID Number.");
}

init
{
    // Define useful Methods
    vars.InitializeVars = new Action (() =>
    {
        // Version Detection
        vars.fp_size_1_20_6 = 32583680;
        vars.fp_size_1_20_4 = 32362496;

        // Version Dependant
        vars.frameIdFortuneNightEnd = 34;

        // Other userful vars.
        vars.fullRunMins = 0.0d;
        vars.fullRunSecs = 0.0d;
        vars.fullRunMils = 0.0d;

        vars.timeSpanTally = TimeSpan.Zero;
	      vars.onScreenTime = TimeSpan.Zero;
        vars.igtMod = TimeSpan.Zero;

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
      	vars.lastNonZeroTime = TimeSpan.Zero;
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
        print("@@@@@ Detected Version: " + version);
    });
    vars.DetectVersion();
    
    vars.CalcStageTallies = new Func<int, TimeSpan>((int cutoffScreen) =>
	{
		TimeSpan result = TimeSpan.Zero;
		for (int i = 0; (i < vars.arrTimes.Count && i <= cutoffScreen); i++)
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
  vars.igtMod = TimeSpan.FromMilliseconds(current.igtPure - 17);
    // Calculate additional values based on game state.
	if (vars.igtMod != TimeSpan.Zero) {vars.lastNonZeroTime = vars.igtMod;}

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
    // Runs every tick: AutoStart the Timer when the Timer goes from 0 to less than one second.
    if (vars.startPlz && !vars.started)
    {
        vars.started = true;
        return true;
    }
    return false;
}

reset
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

split
{
	// Split just before the Results Tally is Displayed.
	int alt = old.frame;
    if (vars.tallyChanged)
    {
        vars.postTally = true;
		vars.arrTimes[current.frame] = vars.igtMod;
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
	else if (alt == 8 && current.frame == 35){
		vars.splitPlz = true;
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
	
    if (vars.postTally)
    {
		// Don't display the sum until moving to a new Frame/Screen.
        gt = vars.timeSpanTally;
    }
    else
    {
		gt = (vars.timeSpanTally + (vars.igtMod));
    }
	
	//When the run ends, add 0.06 seconds to estimate the final time, because of the milliseconds.
	//ending cutscene = 85
	//if(current.frame == 85)
		//gt += new TimeSpan(0, 0, 0, 0, 6 * 10); 
	
    return gt;
}
