# CSCI4100U - Final Group Project

## Group Members: 
- Mustafa Al-Azzawe (100617392)
- Daniyal Shah (100622173)
- Kenny Le (100616323)
- Alvin Lum (100526620)
  
  
## Comet Match 3
  
This project uses flutter_unity_widget to embed a Unity Game into a Flutter project.  
  
<img src="https://i.imgur.com/JUrh8rt.png" width="400" />  
  
  
## Building the Project
  
1. Open IDE of choice (VSCode, Android Studio, etc) and open the project folder (csci4100u_finalproject), click get dependencies (Dart/Flutter).  
  
2. **VSCode**: Flutter launch emulator, recommended Android 8-9 (API 27-28). Then Debug -> Start Debugging (F5).  
   **Android Studio**: AVD Tools (Ctrl+Shift+A search if you can't find it), launch emulator. Then Run (Shift+F10).  
  
3. Project should boot up. It is compatible with x32 and x64 architecture. You may use a physical Android device with USB debugging.  
  
  
**If project does not boot, check that Flutter / Dart / Gradle is updated for your IDE. Do not forget to click "Get dependencies" or enter 'pub get' (dart) / 'flutter packages get' (flutter) when opening project for first time.**

**Tested on:**

[√] Android Studio   
    • Flutter plugin version 42.0.1  
    • Dart plugin version 191.8593  
    • OpenJDK (build 1.8.0_202-release-1483-b03)  
  
[√] VS Code  
    • Flutter extension version 3.7.1  
  
[✓] Flutter (Channel stable, v1.9.1+hotfix.6, on Microsoft Windows [Version 10])  
    • Flutter version 1.7.8+hotfix.4 or below WILL NOT WORK  
    • Please update to 1.9.1+hotfix.6+  
    • Dart version 2.5.0  
  
[✓] VS Code, 64-bit edition (version 1.39.2)  
    • Flutter extension version 3.6.0  
  
[✓] Android Emulator x86 (Nexus, Pixel, Android 8-10, SDK 27-29), Physical Android 8 x64
  
  
**If project still does not boot, as a last resort: follow our video tutorial below:**  

[TODO: Insert Video]  

  
  
  
## Building the Unity Project
  
### This section is NOT necessary unless you wish to rebuild the Unity project. This is a lengthy process. For most users please skip this step.  
  
1. In the project is the ```unity``` subfolder. If you have ```Unity 2018.3``` and wish to re-build, make sure you have the specified Android SDK and NDK. To check if you have them correctly linked, go to Edit -> Preferences -> External Tools -> Android. 
  
2. Next, in Unity, navigate to File -> Build Settings, set these parameters accordingly:  
  
  <img src="https://i.imgur.com/ZDsQ1qM.png" width="800" />  
  
  - Disable Auto Graphics API, set Package Name, Set API min and target to 19, 28 respectively, scripting backend to IL2CPP, target ARMv7, ARM64, (and ARM86 if you wish to test on virtual emulator). Now close, do not build.  
  
3. At the top to 'Flutter' -> 'Export Android'. This may take a while to build. Once build is complete, navigate to android->UnityExport folder, to build.gradle, then delete:
```
bundle {
	language {
		enableSplit = false
...
```
 
4. Your project is now ready to build.     
  
  
## Navigating the Game
  
1. For your first login, you will be prompted to create a game account to login (Firebase).  
2. In the main menu, you can navigate to a new screen by double tapping one of the icons. In order, the screens are [Play], [Scores], [Test Console], [Settings], [Credits].  
3. [Play] allows the player to select the game mission level by tapping on one of the pegs in the map. Afterwards, Unity will launch the level.  
4. [Scores] displays the players scores and high scores in charts and tables.  
5. [Test Console] allows the user to quickly test some functionality.  
6. [Settings] allows the user to change language or volume.  
7. [Credits] displays creators and roles.
  
<img src="https://i.imgur.com/kTjbRBB.png" width="400" />  
<img src="https://i.imgur.com/GindCvk.png" width="400" />  
  
  
### Group Roles  
  
**Lines committed may not accurately reflect contribution since we used separate development branches and using pull requests, merged later, sometimes by someone else. Some members contributed in other aspects of development (graphics, design, sound, art, QA). We believe each member contributed a significant amount.**  

**Mustafa:**
- Firebase, Login, Logout
- Local Databases
- UI Design
  
**Daniyal:**  
- Sound Track
- Menu Screen, UI Designm, Local Databases
- Graphics, Design, Sound, Art, QA
  
**Kenny:**  
- Unity - Match 3 Game Design
- Base System
- 
  
**Alvin:**  
-  Level select with map
-  UI
-  QA
  
