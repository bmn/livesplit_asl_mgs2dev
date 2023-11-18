state("mgs2_sse") {}
state("METAL GEAR SOLID2") {}
state("METAL GEAR SOLID2.unpacked") {}


startup
{
  vars.GameTime = "0:00:00.00";
  vars.RTALoadless = vars.GameTime;
  vars.LastAreaTime = "0:00.00";


  vars.D = new ExpandoObject();
  var D = vars.D;

  D.ShortTimeFormat = @"m\:ss\.ff";
  D.LongTimeFormat = @"h\:mm\:ss\.ff";

  D.Check = new Dictionary<string, Func<bool>>();
  D.Watch = new Dictionary<string, Func<int>>();
  D.CurrentWatch = new List<string>();

  D.Menus = new HashSet<string>() {
    "n_title", "mselect", "sselect", "select", "tales"
  };

  var locationGroups = new Dictionary<string, string[]>()
  {
    { "tnk_bridge", new[]{ "w01e", "d04t" } },
    { "tnk_hold3", new[]{ "w04c", "d11t" } },
  };
  D.LocationGroups = new Dictionary<string, List<string>>();
  foreach (var locGroup in locationGroups)
  {
    foreach (var loc in locGroup.Value)
    {
      if (!D.LocationGroups.ContainsKey(loc))
        D.LocationGroups.Add(loc, new List<string>());
      D.LocationGroups[loc].Add(locGroup.Key);
    }
  }



  D.Split = (Func<string, bool>)((name) => {
    print("Splitting for setting " + name);
    return true;
  });

  D.ByteArray = (Func<IntPtr, int, dynamic>)((addr, len) => {
    dynamic ba = new ExpandoObject();
    ba.Address = addr;
    ba.Length = len;
    ba.Current = new byte[len];
    ba.Old = new byte[len];
    ba.Update = D.ByteArrayUpdateThis;
    return ba;
  });

  D.GroupToList = (Func<Dictionary<string, List<string>>, string, List<string>>)((dict, key) => {
    var result = new List<string>() { key };
    if ((dict != null) && (dict.ContainsKey(key)))
      result.AddRange(dict[key]);
    return result;
  });


  settings.Add("opt", true, "Options");
    settings.Add("opt.RTALoadless", false, "Change Game Time style to RTA Loadless (MC only)", "opt");

  settings.Add("sol", true, "Main Game Split Points");
    settings.Add("sol_setpieces", true, "Set Pieces", "sol");
    settings.CurrentDefaultParent = "sol_setpieces";
      settings.Add("s=tnk cp=24", true, "Reach Olga");
      settings.Add("s=tnk cp=26", true, "Olga");
      settings.Add("s=tnk cp=31", true, "Reach Guard Rush");
      settings.Add("s=tnk cp=33", true, "Guard Rush");
      settings.Add("watch s=tnk cp=56", true, "Tanker Results (triggers on Tanker mode)");
      settings.Add("s=tnk cp=58", true, "Tanker Complete (triggers on Tanker-Plant mode)");
      settings.Add("s=plt cp=63", true, "Reach Stillman");
      settings.Add("s=plt cp=109", true, "Reach Fortune");
      settings.Add("s=plt cp=115", true, "Fortune");
      settings.Add("s=plt cp=117", true, "Reach Fatman");
      settings.Add("s=plt cp=119", true, "Fatman");
      settings.Add("s=plt cp=153", true, "Reach B1 Hall");
      settings.Add("s=plt cp=155", true, "Ames");
      settings.Add("s=plt cp=188", true, "Reach Harrier");
      settings.Add("s=plt cp=190", true, "Harrier");
      settings.Add("s=plt cp=206", true, "Reach Prez");
      settings.Add("s=plt cp=246", true, "Reach Vamp 1");
      settings.Add("s=plt cp=254", true, "Vamp 1");
      settings.Add("s=plt cp=302", true, "Reach Sniping");
      settings.Add("s=plt cp=316", true, "Reach Vamp 2");
      settings.Add("s=plt cp=318", true, "Vamp 2");
      settings.Add("s=plt cp=328", true, "Reach Arsenal Gear");
      settings.Add("s=plt cp=382", true, "Reach Snake");
      settings.Add("s=plt ol=w44a cl=w45a", true, "Tengus 1");
      settings.Add("s=plt cp=404", true, "Tengus 2");
      settings.Add("s=plt cp=412", true, "Rays");
      settings.Add("s=plt cp=470", true, "Solidus");
      settings.Add("watch s=plt cp=486", true, "Plant Results (Substance)");
      settings.Add("watch s=plt cp=487", true, "Plant Results (Master Collection)");
    settings.Add("sol_areas", true, "Area Transitions", "sol");
      settings.Add("sol_areas_tanker", true, "Tanker", "sol_areas");
      settings.CurrentDefaultParent = "sol_areas_tanker";
        settings.Add("ol=w00a cl=w01a", true, "Aft Deck → Deck A");
        settings.Add("ol=w00a cl=w01b", true, "Aft Deck → Deck B");
        settings.Add("ol=w01a cl=w00a", true, "Deck A → Aft Deck");
        settings.Add("ol=w01a cl=w01f", true, "Deck A → Deck A Lounge");
        settings.Add("ol=w01f cl=w01a", true, "Deck A Lounge → Deck A");
        settings.Add("ol=w01f cl=w01b", true, "Deck A Lounge → Deck B");
        settings.Add("ol=w01f cl=w02a", true, "Deck A Lounge → Engine Room");
        settings.Add("ol=w01b cl=w00a", true, "Deck B → Aft Deck");
        settings.Add("ol=w01b cl=w01f", true, "Deck B → Deck A Lounge");
        settings.Add("ol=w01b cl=w01c", true, "Deck B → Deck C");
        settings.Add("ol=w01c cl=w01b", true, "Deck C → Deck B");
        settings.Add("ol=w01c cl=w01d", true, "Deck C → Deck D");
        settings.Add("ol=w01d cl=w01c", true, "Deck D → Deck C");
        settings.Add("ol=w01d cl=tnk_bridge", true, "Deck D → Deck E");
        settings.Add("ol=w01e cl=w01d", true, "Deck E → Deck D");
        settings.Add("ol=w01e cl=w00c", true, "Deck E → Navigational Deck");
        settings.Add("ol=w00c cl=w01e", true, "Navigational Deck → Deck E");
        settings.Add("ol=w02a cl=w01f", true, "Engine Room → Deck A Lounge");
        settings.Add("ol=w02a cl=w03a", true, "Engine Room → Deck-2 port");
        settings.Add("ol=w03a cl=w03b", true, "Deck-2 port → Deck-2 starboard");
        settings.Add("ol=w04a cl=w04b", true, "Hold No.1 → Hold No.2");
        settings.Add("ol=w04b cl=w04a", true, "Hold No.2 → Hold No.1");
        settings.Add("ol=w04b cl=tnk_hold3", true, "Hold No.2 → Hold No.3");
        settings.Add("ol=w04c cl=w04b", true, "Hold No.3 → Hold No.2");
        settings.Add("ol=w04c cl=d12t", true, "Hold No.3 → complete");
      settings.Add("sol_areas_plant", true, "Plant", "sol_areas");
      settings.CurrentDefaultParent = "sol_areas_plant";
        settings.Add("ol=w11a ol=w12c", true, "Strut A Deep Sea Dock → Strut A roof");
        //settings.Add("ol=w11b", true, "Strut A Deep Sea Dock (bomb)");
        settings.Add("ol=w12a cl=w12b", true, "Strut A roof → Strut A Pump Room (before Stillman)");
        settings.Add("ol=w12c cl=w12b", true, "Strut A roof → Strut A Pump Room");
        settings.Add("ol=w12b cl=w12a", true, "Strut A Pump Room → Strut A roof (before Stillman)");
        settings.Add("ol=w12b cl=w12c", true, "Strut A Pump Room → Strut A roof");
        settings.Add("ol=w12b cl=w13a", true, "Strut A Pump Room → AB connecting bridge (before Stillman)");
        settings.Add("ol=w12b cl=w13b", true, "Strut A Pump Room → AB connecting bridge");
        settings.Add("ol=w13a cl=w12b", true, "AB connecting bridge → Strut A Pump Room (before Stillman)");
        settings.Add("ol=w13b cl=w12b", true, "AB connecting bridge → Strut A Pump Room");
        settings.Add("ol=w13a cl=w14a", true, "AB connecting bridge → Strut B Transformer Room (before Stillman)");
        settings.Add("ol=w13b cl=w14a", true, "AB connecting bridge → Strut B Transformer Room");
        settings.Add("ol=w14a cl=w13a", true, "Strut B Transformer Room → AB connecting bridge (before Stillman)");
        settings.Add("ol=w14a cl=w13b", true, "Strut B Transformer Room → AB connecting bridge");
        settings.Add("ol=w14a cl=w15a", true, "Strut B Transformer Room → BC connecting bridge (before Stillman)");
        settings.Add("ol=w14a cl=w15b", true, "Strut B Transformer Room → BC connecting bridge");
        settings.Add("ol=w15a cl=w16a", true, "BC connecting bridge → Strut C Dining Hall (before Stillman)");
        settings.Add("ol=w15b cl=w16b", true, "BC connecting bridge → Strut C Dining Hall");
        settings.Add("ol=w16a cl=w15a", true, "Strut C Dining Hall → BC connecting bridge (before Stillman)");
        settings.Add("ol=w16b cl=w15b", true, "Strut C Dining Hall → BC connecting bridge");
        settings.Add("ol=w16b cl=w17a", true, "Strut C Dining Hall → CD connecting bridge");
        settings.Add("ol=w17a cl=w16b", true, "CD connecting bridge → Strut C Dining Hall");
        settings.Add("ol=w17a cl=w18a", true, "CD connecting bridge → Strut D Sediment Pool");
        settings.Add("ol=w18a cl=w17a", true, "Strut D Sediment Pool → CD connecting bridge");
        settings.Add("ol=w18a cl=w25a", true, "Strut D Sediment Pool → Shell 1-2 connecting bridge");
        settings.Add("ol=w18a cl=w19a", true, "Strut D Sediment Pool → DE connecting bridge");
        settings.Add("ol=w19a cl=w18a", true, "DE connecting bridge → Strut D Sediment Pool");
        settings.Add("ol=w19a cl=w20a", true, "DE connecting bridge → Strut E Parcel Room");
        settings.Add("ol=w20a cl=w19a", true, "Strut E Parcel Room → DE connecting bridge");
        settings.Add("ol=w20a cl=w20b", true, "Strut E Parcel Room → Strut E heliport (before Ninja)");
        settings.Add("ol=w20a cl=w20d", true, "Strut E Parcel Room → Strut E heliport");
        settings.Add("ol=w20a cl=w12b", true, "Strut E Parcel Room → Strut A Pump Room");
        settings.Add("ol=w20a cl=w14a", true, "Strut E Parcel Room → Strut B Transformer Room");
        settings.Add("ol=w20a cl=w16b", true, "Strut E Parcel Room → Strut C Dining Hall");
        settings.Add("ol=w20a cl=w22a", true, "Strut E Parcel Room → Strut F warehouse");
        settings.Add("ol=w20a cl=w21a", true, "Strut E Parcel Room → EF connecting bridge");
        settings.Add("ol=w20b cl=w20a", true, "Strut E heliport (before Ninja) → Strut E Parcel Room");
        settings.Add("ol=w20d cl=w20a", true, "Strut E heliport → Strut E Parcel Room");
        settings.Add("ol=w21a cl=w20a", true, "EF connecting bridge → Strut E Parcel Room");
        settings.Add("ol=w21a cl=w24a", true, "EF connecting bridge → Shell 1 Core, 1F");
        settings.Add("ol=w21a cl=w22a", true, "EF connecting bridge → Strut F warehouse");
        settings.Add("ol=w21b cl=w20a", true, "EF connecting bridge → Strut E Parcel Room (dusk)");
        settings.Add("ol=w21b cl=w24a", true, "EF connecting bridge → Shell 1 Core, 1F (dusk)");
        settings.Add("ol=w22a cl=w21a", true, "Strut F warehouse → EF connecting bridge");
        settings.Add("ol=w22a cl=w23a", true, "Strut F warehouse → FA connecting bridge (var 1)");
        settings.Add("ol=w22a cl=w23b", true, "Strut F warehouse → FA connecting bridge (var 2)");
        settings.Add("ol=w23a cl=w22a", true, "FA connecting bridge (var 1) → Strut F warehouse");
        settings.Add("ol=w23a cl=w12b", true, "FA connecting bridge (var 1) → Strut A Pump Room");
        settings.Add("ol=w23b cl=w22a", true, "FA connecting bridge (var 2) → Strut F warehouse");
        settings.Add("ol=w23b cl=w12b", true, "FA connecting bridge (var 2) → Strut A Pump Room");
        settings.Add("ol=w24a cl=w21a", true, "Shell 1 Core, 1F → EF connecting bridge");
        settings.Add("ol=w24a cl=w21b", true, "Shell 1 Core, 1F → EF connecting bridge (dusk)");
        settings.Add("ol=w24a cl=w24b", true, "Shell 1 Core, 1F → Shell 1 Core, B1");
        settings.Add("ol=w24a cl=w24d", true, "Shell 1 Core, 1F → Shell 1 Core, B2");
        settings.Add("ol=w24b cl=w24a", true, "Shell 1 Core, B1 → Shell 1 Core, 1F");
        settings.Add("ol=w24b cl=w24b", true, "Shell 1 Core, B1 → Shell 1 Core, B1 Hall");
        settings.Add("ol=w24b cl=w24d", true, "Shell 1 Core, B1 → Shell 1 Core, B2");
        settings.Add("ol=w24c cl=w24b", true, "Shell 1 Core, B1 Hall → Shell 1 Core, B1");
        settings.Add("ol=w24d cl=w24a", true, "Shell 1 Core, B2 Computer Room → Shell 1 Core, 1F");
        settings.Add("ol=w24d cl=w24b", true, "Shell 1 Core, B2 Computer Room → Shell 1 Core, B1");
        settings.Add("ol=w25a cl=w18a", true, "Shell 1-2 connecting bridge (before Harrier) → Strut D Sediment Pool");
        settings.Add("ol=w25b cl=w25c", true, "Shell 1-2 connecting bridge (after Harrier) → Strut L perimeter");
        settings.Add("ol=w25c cl=w31a", true, "KL connecting bridge → Shell 2 Core, 1F");
        settings.Add("ol=w25d cl=w31d", true, "KL connecting bridge → Shell 2 Core, 1F (with Emma)");
        settings.Add("ol=w31a cl=w25c", true, "Shell 2 Core, 1F Air Purification Room → KL connecting bridge");
        settings.Add("ol=w31d cl=w25d", true, "Shell 2 Core, 1F Air Purification Room → KL connecting bridge (with Emma)");
        settings.Add("ol=w31a cl=w31b", true, "Shell 2 Core, 1F Air Purification Room → Shell 2 Core, B1/1");
        settings.Add("ol=w31d cl=w31b", true, "Shell 2 Core, 1F Air Purification Room → Shell 2 Core, B1/1 (with Emma)");
        settings.Add("ol=w31b cl=w31a", true, "Shell 2 Core, B1/1 → Shell 2 Core, 1F");
        settings.Add("ol=w31b cl=w31d", true, "Shell 2 Core, B1/1 → Shell 2 Core, 1F (with Emma)");
        settings.Add("ol=w31b cl=w31f", true, "Shell 2 Core, B1/1 → Shell 2 Core, B1/2");
        settings.Add("ol=w31f cl=w31b", true, "Shell 2 Core, B1/2 → Shell 2 Core, B1/1");
        settings.Add("ol=w28a cl=w25d", true, "Strut L Sewage Treatment Facility → KL connecting bridge");
        settings.Add("ol=w41a cl=w42a", true, "Arsenal Gear - Stomach → Arsenal Gear - Jejunum");
        settings.Add("ol=w42a cl=w41a", true, "Arsenal Gear - Jejunum → Arsenal Gear - Stomach");
        settings.Add("ol=w42a cl=w43a", true, "Arsenal Gear - Jejunum → Arsenal Gear - Ascending Colon");
  settings.CurrentDefaultParent = null;
  settings.Add("tales", true, "Snake Tales Split Points");
    settings.Add("tales_a", true, "A Wrongdoing", "tales");
      settings.CurrentDefaultParent = "tales_a";
      settings.Add("s=tale1 ol=a12a cl=a12b", true, "Strut A roof → Strut A Pump Room");
      settings.Add("s=tale1 ol=a12b", true, "Strut A Pump Room → Strut A roof");
      settings.Add("s=tale1 ol=a12b ", true, "Strut A Pump Room → FA connecting bridge");
      settings.Add("s=tale1 ol=a23b", true, "FA connecting bridge → Strut A Pump Room");
      settings.Add("s=tale1 ol=a23b ", true, "FA connecting bridge → Strut F warehouse");
      settings.Add("s=tale1 cp=69", true, "Ames");
      settings.Add("s=tale1 ol=a22a", true, "Strut F warehouse → FA connecting bridge");
      settings.Add("s=tale1 ol=a22a ", true, "Strut F warehouse → EF connecting bridge");
      settings.Add("s=tale1 ol=a21a", true, "EF connecting bridge → Strut F warehouse");
      settings.Add("s=tale1 ol=a21a ", true, "EF connecting bridge → Shell 1 Core, 1F");
      settings.Add("s=tale1 ol=a21a  ", true, "EF connecting bridge → Strut E Parcel Room");
      settings.Add("s=tale1 ol=a24a", true, "Shell 1 Core, 1F → EF connecting bridge");
      settings.Add("s=tale1 ol=a24a ", true, "Shell 1 Core, 1F → Shell 1 Core, B1");
      settings.Add("s=tale1 ol=a24a  ", true, "Shell 1 Core, 1F → Shell 1 Core, B2");
      settings.Add("s=tale1 ol=a24b", true, "Shell 1 Core, B1 → Shell 1 Core, 1F");
      settings.Add("s=tale1 ol=a24b ", true, "Shell 1 Core, B1 → Shell 1 Core, B1 Hall");
      settings.Add("s=tale1 ol=a24b  ", true, "Shell 1 Core, B1 → Shell 1 Core, B2 Computer Room");
      settings.Add("s=tale1 cp=70", true, "Jennifer");
      settings.Add("s=tale1 ol=a24d", true, "Shell 1 Core, B2 Computer Room → Shell 1 Core, 1F");
      settings.Add("s=tale1 ol=a24d ", true, "Shell 1 Core, B2 Computer Room → Shell 1 Core, B1");
      settings.Add("s=tale1 ol=a20a", true, "Strut E Parcel Room → EF connecting bridge");
      settings.Add("s=tale1 ol=a20a ", true, "Strut E Parcel Room → Strut E heliport");
      settings.Add("s=tale1 cp=71", true, "Reach Fatman");
      settings.Add("s=tale1 cp=72", true, "Fatman");
      settings.Add("watch s=tale1 cp=73", true, "Results");
    settings.Add("tales_b", true, "Big Shell Evil", "tales");
    settings.Add("tales_c", true, "Confidential Legacy", "tales");
    settings.Add("tales_d", true, "Dead Man Whispers", "tales");
    settings.Add("tales_e", true, "External Gazer", "tales");


  D.CreateCodeList = (Action<List<string>, List<string>, List<string>, bool>)((workingSet, completeSet, currentSet, addSelf) => {
    foreach (string item in currentSet) {
      // add to every entry in working and also pass partial to complete
      int count = workingSet.Count;
      for (int i = 0; i < count; i++)
      {
        string newItem = workingSet[i] + " " + item;
        workingSet.Add(newItem);
        completeSet.Add(newItem);
      }
      // add the new item on its own
      if (addSelf)
      {
        workingSet.Add(item);
        completeSet.Add(item);
      }
    }
  });

}



init
{
  var D = vars.D;

  D.M = null;
  D.BA = new Dictionary<string, dynamic>();
  D.IsMasterCollection = false;
  D.IsSubstance = false;
  D.SnakeTalesMission = (byte)0;

  D.TimerModel = new TimerModel { CurrentState = timer };
  D.LoadlessTimerModel = new TimerModel { CurrentState = (LiveSplitState)timer.Clone() };


  D.ByteArrayUpdateAll = (Action<Process>)((g) => {
    foreach (var m in D.BA)
      m.Value.Update(m.Value, g);
  });
  
  // MM Update function for byte[]
  D.ByteArrayUpdateThis = (Action<dynamic, Process>)((m, g) => {
    m.Old = m.Current;
    m.Current = g.ReadBytes((IntPtr)m.Address, (int)m.Length);
  });



  // watch functions
  Func<int> watResults = () => ((current.ResultsComplete & 0x200) == 0x200) ? 1 : 0;
  D.Watch.Add("watch s=tnk cp=56", watResults);
  D.Watch.Add("watch s=plt cp=486", watResults);
  D.Watch.Add("watch s=plt cp=487", watResults);
  D.Watch.Add("watch s=tale1 cp=73", watResults);


  // Set up watchers for Substance
  if (game.ProcessName.Equals("mgs2_sse"))
  {
    D.IsSubstance = true;
    D.M = new MemoryWatcherList()
    {
      new MemoryWatcher<uint>((IntPtr)0x118AEF8) { Name = "GameTimeFrames" },
      new MemoryWatcher<uint>((IntPtr)0x118AEA4) { Name = "AreaTimeFrames" },
      new StringWatcher((IntPtr)0x118C374, 10) { Name = "Character" },
      new StringWatcher((IntPtr)0x118ADEC, 10) { Name = "Location" },
      new MemoryWatcher<ushort>((IntPtr)0x118D93C) { Name = "ProgressTanker" },
      new MemoryWatcher<ushort>((IntPtr)0x118D912) { Name = "ProgressPlant" },
      new MemoryWatcher<uint>((IntPtr)0xA5397C) { Name = "GameplayState" },
      new MemoryWatcher<byte>((IntPtr)0x118D982) { Name = "SnakeTalesMission" },
    };
    //D.BA.Add("SnakeTalesData", D.ByteArray((IntPtr)0x118D982, 6));
    D.M_Tales = new MemoryWatcherList()
    {
      new MemoryWatcher<byte>((IntPtr)0x118D983) { Name = "Progress1" },
      new MemoryWatcher<byte>((IntPtr)0x118D984) { Name = "Progress2" },
      new MemoryWatcher<byte>((IntPtr)0x118D985) { Name = "Progress3" },
      new MemoryWatcher<byte>((IntPtr)0x118D986) { Name = "Progress4" },
      new MemoryWatcher<byte>((IntPtr)0x118D987) { Name = "Progress5" },
    };

    D.IsRtaLoadlessEnabled = (Func<bool>)(() => false);
    D.M_Progress = D.M["ProgressTanker"];
    return true;
  }

  // Not Substance, prep for MC2 (actual attach logic in update)
  D.NextAttachAttempt = DateTime.Now;
  D.IsMasterCollection = true;

  D.IsRtaLoadlessEnabled = (Func<bool>)(() => settings["opt.RTALoadless"]);

  D.FindReference = (Func<int, string, IntPtr>)((patternOffset, pattern) => {
    var module = modules.First();
    var sigScanner = new SignatureScanner(game, module.BaseAddress, (int)module.ModuleMemorySize);
    return sigScanner.Scan(new SigScanTarget(patternOffset, pattern));
  });

  D.FindRelativePointer = (Func<int, string, int, string, IntPtr>)((patternOffset, pattern, pointerOffset, name) => {
    IntPtr refLocation = D.FindReference(patternOffset, pattern);
    if (refLocation == IntPtr.Zero)
    {
      print(name + " reference not found by signature scan");
      return refLocation;
    }

    int relativePointer = memory.ReadValue<int>(refLocation);
    IntPtr absolutePointer = IntPtr.Add(refLocation, relativePointer + pointerOffset);
    print("Found reference to " + name + " at " + refLocation.ToString("X") + " value " + relativePointer.ToString("X") + " > " + absolutePointer.ToString("X"));
    return absolutePointer;
  });
}



update
{
  var D = vars.D;

  // For MC2, try to find the pointers if we don't have them already
  if ((D.M == null) && (DateTime.Now >= D.NextAttachAttempt))
  {
    var pointers = new Dictionary<string, IntPtr>();

    pointers.Add("gameplayState", D.FindRelativePointer(5,
      "89 73 38 81 25 ?? ?? ?? ?? FF FF FF EF E9 ?? ?? 00 00 C7 43 3C 01 00 00 00 E9 ?? ?? 00 00", 8, "MC2 gameplay status"));
  
    pointers.Add("gameplayActive", D.FindRelativePointer(7,
      "E8 ?? ?? ?? 00 83 3D ?? ?? ?? 00 00 74 ?? 66 0F 2F 05 ?? ?? ?? ?? 73 ?? 33 C0 48 83 C4 28 C3", 5, "MC2 gameplay active status (1.2)"));
    if (pointers["gameplayActive"] == IntPtr.Zero)
      pointers["gameplayActive"] = D.FindRelativePointer(7,
        "E8 ?? ?? ?? 00 83 3D ?? ?? ?? 00 00 74 ?? 0F 2F 05 ?? ?? ?? ?? 73 ?? 33 C0 48 83 C4 28 C3", 5, "MC2 gameplay active status (1.0)");

    pointers.Add("mainData", D.FindRelativePointer(11, "81 F9 34 03 00 11 75 ?? 48 8B 05 ?? ?? ?? 00", 4, "MC2 main game data"));

    if (pointers.ContainsValue(IntPtr.Zero))
    {
      print("One or more MC2 pointers not found, unable to autosplit. Will attempt to attach again in 10 seconds.");
      D.NextAttachAttempt = DateTime.Now.AddSeconds(10);
      return false;
    }

    // Pointers have been found
    D.NextAttachAttempt = DateTime.Now.AddYears(420);

    pointers.Add("tankerData", IntPtr.Subtract(pointers["mainData"], 0x10));
    pointers.Add("plantData",  IntPtr.Subtract(pointers["mainData"], 0x8));

    D.M = new MemoryWatcherList()
    {
      new MemoryWatcher<uint>(
        new DeepPointer(pointers["mainData"], 0x138)) { Name = "GameTimeFrames" },
      new StringWatcher(
        new DeepPointer(pointers["mainData"], 0x1C), 10) { Name = "Character" },
      new StringWatcher(
        new DeepPointer(pointers["mainData"], 0x2C), 10) { Name = "Location" },
      new MemoryWatcher<ushort>(
        new DeepPointer(pointers["tankerData"], 0x6)) { Name = "ProgressTanker" },
      new MemoryWatcher<ushort>(
        new DeepPointer(pointers["plantData"], 0x68)) { Name = "ProgressPlant" },
      new MemoryWatcher<uint>(pointers["gameplayState"]) { Name = "ResultsComplete" },
      new MemoryWatcher<byte>(pointers["gameplayActive"]) { Name = "GameplayActive" },
      new MemoryWatcher<byte>(
        new DeepPointer(pointers["tankerData"], 0x25C)) { Name = "SnakeTalesMission" },
    };
    D.M_Tales = new MemoryWatcherList()
    {
      new MemoryWatcher<byte>(
        new DeepPointer(pointers["tankerData"], 0x25D)) { Name = "Progress1" },
      new MemoryWatcher<byte>(
        new DeepPointer(pointers["tankerData"], 0x25E)) { Name = "Progress2" },
      new MemoryWatcher<byte>(
        new DeepPointer(pointers["tankerData"], 0x25F)) { Name = "Progress3" },
      new MemoryWatcher<byte>(
        new DeepPointer(pointers["tankerData"], 0x260)) { Name = "Progress4" },
      new MemoryWatcher<byte>(
        new DeepPointer(pointers["tankerData"], 0x261)) { Name = "Progress5" },
    };
    D.M_Progress = D.M["ProgressTanker"];
  }

  // Update the watchers and mirror to current/old
  D.M.UpdateAll(game);
  D.ByteArrayUpdateAll(game);

  var cur = current as IDictionary<string, object>;
  foreach (var watcher in D.M)
    cur[watcher.Name] = watcher.Current;

}


isLoading
{
  var D = vars.D;

  if (D.IsSubstance)
    return true;

  if (D.LoadlessTimerModel.CurrentState.StartTime != D.TimerModel.CurrentState.StartTime) {
    D.LoadlessTimerModel = new TimerModel { CurrentState = (LiveSplitState)timer.Clone() };
    D.LastAreaLoadTime = D.LoadlessTimerModel.CurrentState.CurrentTime.RealTime;
  }

  var loadless = D.LoadlessTimerModel.CurrentState;

  if (D.M["GameplayActive"].Changed) {
    if (D.M["GameplayActive"].Current == 1)
      loadless.CurrentPhase = TimerPhase.Paused; // will become Running
    else {
      loadless.CurrentPhase = TimerPhase.Running; // will become Paused
      vars.LastAreaTime = (loadless.CurrentTime.RealTime - D.LastAreaLoadTime).ToString(@"m\:ss\.ff");
      D.LastAreaLoadTime = loadless.CurrentTime.RealTime;
    }
    D.LoadlessTimerModel.Pause();
  }

  vars.RTALoadless = loadless.CurrentTime.RealTime.ToString(D.LongTimeFormat);

  return ((!settings["opt.RTALoadless"]) || (current.GameplayActive != 1));
}


gameTime
{
  var D = vars.D;

  TimeSpan gameTime = TimeSpan.FromMilliseconds(D.M["GameTimeFrames"].Current * 1000 / 60);
  vars.GameTime = gameTime.ToString(D.LongTimeFormat);

  return (D.IsRtaLoadlessEnabled()) ?
    D.LoadlessTimerModel.CurrentState.CurrentTime.RealTime : gameTime;
}


reset
{
  var loc = vars.D.M["Location"];

  return ((loc.Changed) && (loc.Current.Equals("n_title")));
}


split
{
  var D = vars.D;

  if (D.M["Location"].Changed || D.M_Progress.Changed)
  {
    D.CurrentWatch.Clear();

    string key, cur, olde, tmp;
    var watchGroups = new List<List<string>>();
    var changeGroups = new List<List<string>>();
    var currentProgressGroup = new List<string>();

    // section
    string section = null;
    string character = D.M["Character"].Current;
    //byte tale = D.BA["SnakeTalesData"].Current[0];
    byte tale = D.M["SnakeTalesMission"].Current;

    if (character.Equals("r_tnk0"))
    {
      section = "s=tnk";
      D.M_Progress = D.M["ProgressTanker"];
    }
    else if (character.StartsWith("r_plt"))
    {
      section = "s=plt";
      D.M_Progress = D.M["ProgressPlant"];
    }
    else if (character.Equals("r_title"))
    {
      section = "s=menu";
      // todo give this an empty value
      D.M_Progress = D.M["ProgressTanker"];
    }
    else if ((tale >= 1) && (tale <= 5))
    {
      D.SnakeTalesMission = tale;
      section = "s=tale" + tale.ToString();
      D.M_Progress = D.M_Tales["Progress" + tale.ToString()];
    }
    else
    {
      // todo empty value
      D.M_Progress = D.M["ProgressTanker"];
    }

    if (section != null)
    {
      watchGroups.Add(new List<string>() { section });
      changeGroups.Add(new List<string>() { section });
    }

    // location
    bool locChanged = D.M["Location"].Changed;
    if (locChanged)
    {
      foreach (string oldLoc in D.GroupToList(D.LocationGroups, D.M["Location"].Old))
        changeGroups.Add(new List<string>() { "ol=" + oldLoc });
    }
    foreach (string curLoc in D.GroupToList(D.LocationGroups, D.M["Location"].Current))
    {
      cur = "cl=" + curLoc;
      watchGroups.Add(new List<string>() { cur });
      if (locChanged)
        changeGroups.Add(new List<string>() { cur });
    }

    // progress (todo zones)
    cur = "cp=" + D.M_Progress.Current.ToString();
    olde = "op=" + D.M_Progress.Old.ToString();
    currentProgressGroup.Add(cur);
    watchGroups.Add(new List<string>() { cur });
    if (D.M_Progress.Changed)
    {
      changeGroups.Add(new List<string> { olde });      
      changeGroups.Add(currentProgressGroup);
    }

    print("changeGroups: " + string.Join(" / ", changeGroups.SelectMany(list => list)));
    print("watchGroups: " + string.Join(" / ", watchGroups.SelectMany(list => list)));

    // generate all the watch combos
    var watchCodes = new List<string>();
    var workingSet = new List<string>();
    foreach (var group in watchGroups)
      D.CreateCodeList(workingSet, watchCodes, group, true);
    for (int i = 0; i < watchCodes.Count; i++)
      watchCodes[i] = "watch " + watchCodes[i];

    // generate all the change combos
    var changeCodes = new List<string>();
    workingSet.Clear();
    foreach (var group in changeGroups)
      D.CreateCodeList(workingSet, changeCodes, group, true);
    // Add progress as a criterion if progress hasn't changed (& therefore isn't already included)
    if (!D.M_Progress.Changed)
      D.CreateCodeList(workingSet, changeCodes, currentProgressGroup, false);

    print("new checks: " + string.Join(" / ", changeCodes));

    // find any watch function
    foreach (var code in watchCodes)
    {
      if (D.Watch.ContainsKey(code))
        D.CurrentWatch.Add(code);
    }
    print("new watches: " + string.Join(" / ", D.CurrentWatch));

    // check for a change split
    foreach (var code in changeCodes)
    {
      bool doSplit = true;
      if (D.Check.ContainsKey(code))
        doSplit = D.Check[code]();

      if (doSplit && (settings.ContainsKey(code)) && (settings[code]))
        return D.Split(code);
    }
  }

  // handle any current watch functions
  foreach (var watch in D.CurrentWatch)
  {
    int result = watch();
    if (result != 0)
    {
      D.CurrentWatch.Remove(watch);
      if (result == 1)
        return D.Split(watch);
    }
  }
  
}


start
{
  var D = vars.D;
  var loc = D.M["Location"];

  if (!loc.Changed)
    return false;

  if ((loc.Old.Equals("ending")) && (!D.Menus.Contains(loc.Current)))
    return true;
  if ((D.Menus.Contains(loc.Old)) && (!loc.Current.Equals("ending")))
    return true;
}


exit
{

}


shutdown
{

}
