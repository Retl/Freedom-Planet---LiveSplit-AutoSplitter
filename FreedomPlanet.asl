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
    settings.Add("enablePosText", false, "Show Position/Speed/Screen in top 3 Text Elements");
    // settings.Add("setVersion-1-20-4", false, "Enable this if playing version 1.20.4");
}

init
{
  // Detect Version
  vars.fp_size_1_20_6 = 32583680;
  vars.fp_size_1_20_4 = 32362496;

  version = "UNKNOWN";
  print("@@@@@ MODULE SIZE: " + modules.First().ModuleMemorySize.ToString());
  if (modules.First().ModuleMemorySize == vars.fp_size_1_20_6)
      version = "1.20.6";
  else if (modules.First().ModuleMemorySize == vars.fp_size_1_20_4)
      version = "1.20.4";

  print("@@@@@ Detected Version: " + version);

  // Init other vars after hooking the game.
  vars.playerpos = "";
  vars.fullRunMins = 0.0d;
  vars.fullRunSecs = 0.0d;
  vars.fullRunMils = 0.0d;

  vars.timeSpanTally = new TimeSpan(0);

  vars.tokenFPPOS = "_FP_POS";
  vars.tokenFPSPD = "_FP_SPD";
  vars.tokenFPSCRN = "_FP_SCRN";
  vars.tokenFPSTAL = "_FP_TAL";

  vars.arrTimes = System.Collections.ArrayList.Repeat(null, 150);

  vars.calcStageTallies = new Func<int, TimeSpan>((int cutoffScreen) =>
  {
    //Placeholder.
    TimeSpan result = new TimeSpan(0);
    for (int i = 0; (i < vars.arrTimes.Count && i <= cutoffScreen); i++) {
      if (vars.arrTimes[i] != null) {
        result += vars.arrTimes[i];
        print("Individual Tally["+ i.ToString() +"]: " + vars.arrTimes[i].ToString());
      }
      else
      {
        print("Individual Tally["+ i.ToString() +"]: is null!");
      }
    }
    print("Calculating Stage Tallies: " + result.ToString());
    return result;
  });

  vars.locateDefaultTexts = new Func<bool>(() =>
  {
    bool result = true;
	try {
	// Get Text Fields to Show Variables In:
	vars.openForms = Application.OpenForms;
	vars.activeForm = vars.openForms[0];
	vars.layout = vars.openForms[0].Layout;
	vars.layoutComponents = vars.layout.LayoutComponents;
	vars.txtOut = "";
	vars.comp = null;
	vars.txtPOS = null;
	vars.txtPOSOriginal = "";
	vars.txtSPD = null;
	vars.txtSPDOriginal = "";
	vars.txtSCRN = null;
	vars.txtSCRNOriginal = "";

	if (settings["enablePosText"]) {
		vars.txtPOS = vars.layoutComponents[0].Component.Settings;
		vars.txtPOSOriginal = vars.txtPOS.Text1;
		vars.txtSPD = vars.layoutComponents[1].Component.Settings;
		vars.txtSPDOriginal = vars.txtSPD.Text1;
		vars.txtSCRN = vars.layoutComponents[2].Component.Settings;
		vars.txtSCRNOriginal = vars.txtSCRN.Text1;
	  }
	}
	catch (Exception e) { result = false;}

    return result;
  });
  vars.locateDefaultTexts();

  vars.doStart = false;

  vars.deltCharaX = 0.0d;
  vars.deltCharaY = 0.0d;
  vars.deltCharaMagnitude = 0.0d;

  vars.tallyChanged = false;

  vars.frameChanged = false;
  vars.frameChangedSinceTimerZero = false;
  vars.lastFrameSinceTimerZero = 0;

  //print("@@@" + "vars.txtPOS: " + vars.txtPOS.ToString() + "\nvars.txtSPD: " + vars.txtSPD.ToString()+ "@@@");
}

update
{
// Calculate additional values based on game state.
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
  if (vars.tallyChanged) {print("@@@@@Tally Changed: " + vars.tallyChanged.ToString());}
  vars.frameChanged = (current.frame != old.frame && (current.frame != 0 && current.frame != -1));

  if (vars.frameChanged) {
    vars.frameChangedSinceTimerZero = true;
    vars.lastFrameSinceTimerZero = old.frame;
  }

  vars.timerWasReset = (old.minutes > 0  && current.minutes == 0 && current.seconds == 0 && current.milliseconds <= 50);

  // Update text displays
  if (settings["enablePosText"]) {
  if (vars.txtPOS != null
      && vars.txtPOS.Text1 is String) {
    vars.txtPOS.Text1 = "(X,Y): ("
      + String.Format("{0:0.000}", current.charX)
      + "," + String.Format("{0:0.000}", current.charY)
      + ")";
  }

  if (vars.txtSPD != null
      && vars.txtSPD.Text1 is String) {
    vars.txtSPD.Text1 = "(XSPD,YSPD): ("
      + String.Format("{0:0.000}", vars.deltCharaX)
      + "," + String.Format("{0:0.000}", vars.deltCharaY)
      + ")";
  }


  if (vars.txtSCRN != null
    && vars.txtSCRN.Text1 is String) {
      vars.txtSCRN.Text1 = "Screen ID: " + String.Format("{0:0}", current.frame);
    }
  }

  // Always reset these:

  vars.splitPlz = false;

}

exit
{
    vars.playerpos = "";
    vars.fullRunMins = 0.0d;
    vars.fullRunSecs = 0.0d;
    vars.fullRunMils = 0.0d;
    vars.doStart = false;

  vars.txtPOS.Text1 = vars.txtPOSOriginal;
  vars.txtSPD.Text1 = vars.txtSPDOriginal;
  vars.txtSCRN.Text1 = vars.txtSCRNOriginal;
}

shutdown
{
    vars.playerpos = "";
    vars.fullRunMins = 0.0d;
    vars.fullRunSecs = 0.0d;
    vars.fullRunMils = 0.0d;
    vars.doStart = false;
}

start
{
    return (current.frame != 3 && current.minutes == 0 && current.seconds == 0 && current.milliseconds <= 90 && current.milliseconds > 0);
}

reset
{
  if (current.frame == 3)
    vars.fullRunMins = 0.0d;
    vars.fullRunSecs = 0.0d;
    vars.fullRunMils = 0.0d;
  return (vars.frameChanged && (current.frame == 3));
}
split
{
  /*
  if (vars.timerWasReset
  && vars.frameChangedSinceTimerZero
  && (
      vars.lastFrameSinceTimerZero == 19
      || vars.lastFrameSinceTimerZero == 23
      || vars.lastFrameSinceTimerZero == 28
      || vars.lastFrameSinceTimerZero == 34
      || vars.lastFrameSinceTimerZero == 38
      || vars.lastFrameSinceTimerZero == 43
      || vars.lastFrameSinceTimerZero == 49
      || vars.lastFrameSinceTimerZero == 55
      || vars.lastFrameSinceTimerZero == 58
      || vars.lastFrameSinceTimerZero == 64
      || vars.lastFrameSinceTimerZero == 66
      || vars.lastFrameSinceTimerZero == 68
      || vars.lastFrameSinceTimerZero == 70
      )
    ) {
  vars.fullRunMins += old.minutes;
  vars.fullRunSecs += old.seconds;
  vars.fullRunMils += old.milliseconds;
  vars.frameChangedSinceTimerZero = false;
  vars.splitPlz = true;
  vars.lastFrameSinceTimerZero = 0;
  }*/

  if (vars.tallyChanged) {
    vars.splitPlz = true;
    vars.arrTimes[current.frame] = new TimeSpan(0, 0, Convert.ToInt32(current.minutes), Convert.ToInt32(current.seconds), Convert.ToInt32((current.milliseconds) * 10));
    vars.timeSpanTally = vars.calcStageTallies(current.frame);
  }

    return(vars.splitPlz);
}

isLoading
{
    return true;
}

gameTime
{
    //return(new TimeSpan(0, 0, Convert.ToInt32(vars.fullRunMins + current.minutes), Convert.ToInt32(vars.fullRunSecs + current.seconds), Convert.ToInt32((vars.fullRunMils + current.milliseconds) * 10)));

    return(vars.timeSpanTally + (new TimeSpan(0, 0, Convert.ToInt32(current.minutes), Convert.ToInt32(current.seconds), Convert.ToInt32((current.milliseconds) * 10))));
}
