# Purpose:
A Match 3 game utilizing Cloud services (Google Firebase) for real-time database query of player statistics.  
Further leverages powerful and cutting edge technology with Google's Flutter, a native android application development framework, in combination with the Unity Game Engine.  
This allows for flexible and beautiful UI elements in the menus outside of the game, while also using a feature-intensive and flexible game engine.

## Contributors: 
- Mustafa Al-Azzawe (100617392)
- Daniyal Shah (100622173)
- Kenny Le (100616323)
- Alvin Lum (100526620)
  
  
## Comet Match 3
  
This project uses **flutter_unity_widget** to embed a **Unity Game** into a **Flutter project**.  
This project aims to take advantage of Flutter's versatile features in UI, navigation, and libs while making a **Unity3D Game**.
**Comet Match 3** is different than many other match 3 games because you can hold and drag matchables as much as you want, but you are timed, so you must match quickly.  
  
<img src="https://i.imgur.com/JUrh8rt.png" width="400" />  
  
  
## Building the Project
  
### Requirements (Warning)
  
- There was a Flutter SDK update on December 11, 2019, **v1.12.13+hotfix.5**, **DO NOT USE** when building this project.  
- Use Flutter SDK **v1.9.1+hotfix.6** (or any variant of v.1.9.1).  
  
  <img src="https://i.imgur.com/UcyG4V4.png" width="400" />   
    
  https://flutter.dev/docs/development/tools/sdk/releases  
    
  If downgrading the Flutter SDK: navigate in terminal to location of flutter SDK, git checkout v"1.9.1+hotfix.6"  
  Alternatively, restart PC, delete flutter SDK folder, replace with desired version from download link above.  
  
### Steps
  
1. Open IDE of choice (VSCode, Android Studio, etc) and open the project folder (csci4100u_finalproject), click get dependencies (Dart/Flutter).  
  
2. **VSCode**: **Flutter launch emulator**, recommended Android 8-10 (API 27-29). Then, **Debug -> Start Debugging (F5)**.  
   **Android Studio**: AVD Tools (Ctrl+Shift+A search if you can't find it), **launch emulator**. Then, **Run (Shift+F10)**.  
  
3. Project should boot up. It is compatible with x32 and x64 architecture. You may use a physical Android device with USB debugging.  
  
**If project does not boot, check that Flutter / Dart / Gradle is updated for your IDE. Do not forget to click "Get dependencies" or enter 'flutter pub get' / 'flutter packages get' when opening project for first time.**

**Tested on:**

**[√] Android Studio**  
    • Flutter plugin version 42.0.1  
    • Dart plugin version 191.8593  
    • OpenJDK (build 1.8.0_202-release-1483-b03)  
  
**[√] VS Code**  
    • Flutter extension version 3.7.1  
  
**[✓] Flutter** (**v1.9.1+hotfix.6**, on Microsoft Windows [Version 10])  
    • Flutter version **v1.12.13+hotfix.5** or <= **1.7.8+hotfix.4 WILL NOT WORK**  
    • Update to **1.9.1+hotfix.6+**  
    • Dart version 2.5.0  
  
**[✓] VS Code**    
    • Flutter extension version 3.6.0  
  
**[✓] Android Emulator x86 (Nexus, Pixel, Android 8-10, SDK 27-29), Physical Android 8 x64**  
  
  
## Building the Unity Project (Optional)
  
### This section is NOT necessary unless you wish to rebuild the already exported Unity project. This is a lengthy process. For most users please skip this step.  
  
1. In the project is the ```unity``` subfolder. If you have ```Unity 2018.3``` and wish to re-build, make sure you have the specified **Android SDK and NDK**. To check if you have them correctly linked, go to **Edit -> Preferences -> External Tools -> Android**. 
  
2. Next, in Unity, navigate to **File -> Build Settings**, set these parameters accordingly:  
  
  <img src="https://i.imgur.com/ZDsQ1qM.png" width="800" />  
  
  - **Disable Auto Graphics API**, set Package Name, Set API min and target to **19, 28** respectively, scripting backend to **IL2CPP**, target ARMv7, ARM64, (and ARM86 if you wish to test on virtual emulator). Now close, do not build.  
  
3. At the top to **'Flutter' -> 'Export Android'**. This may take a while to build. Once build is complete, navigate to android->UnityExport folder, to build.gradle, then delete:
```
bundle {
	language {
		enableSplit = false
...
```
 
4. Your project is now ready to build.     
  
  
## Navigating the Game
  
1. For your first login, you will be prompted to create a game account to login (Firebase). **(Password must be 6+ chars)**
2. In the main menu, you can navigate to a new screen by double tapping one of the icons. In order, the screens are **[Play], [Scores], [Test Console], [Settings], [Credits]**.  
3. **[Play]** allows the player to select the game mission level by tapping on one of the pegs in the map. Afterwards, Unity will launch the level.  
4. **[Scores]** displays the players scores and high scores in charts and tables (not fully working).  
5. **[Test Console]** allows the user to quickly test some functionality.  
6. **[Settings]** allows the user to change language or volume.  
7. **[Credits]** displays creators and roles.  
  
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
  
**Alvin:**  
-  Level select with map
-  UI
-  QA
  
  
DOWNLOAD LINK TO APK (Play on your phone):  https://drive.google.com/open?id=1VSDsTfzcoLyPpDcmB7K-7fxlzjqcpxtb
