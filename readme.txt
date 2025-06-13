==================================================
READ ME – ASD Emotional Intelligence VR Project
==================================================

Project Title: 
-----------------
ASD VR Emotional Intelligence Trainer (HUDINI-537)

Project Overview:
-----------------
This project delivers a virtual reality (VR) application designed to support children and teenagers with Autism Spectrum Disorder (ASD) in developing emotional intelligence. The experience allows users to practice identifying and responding to emotions through virtual scenarios in a controlled VR environment. Built using Godot Engine 4.4, the application includes tutorial levels, real-world-inspired scenarios, and additional features such as avatar and language toggle. 

The project was developed as part of RMIT’s Programming Project 1 course.

Release Notes:
-----------------
Version: 1.72  
Start Date: 08 March 2025  
End Date: 16 June 2025

Key Features so far:
- Two tutorial levels with visual and auditory emotion prompts
- Two scenario levels: mall interaction and playarea scene
- Virtual hand color customization
- Language toggle (Arabic and English)
- Sound/music volume toggle
- Assessor login screen (for admins, not connected to database)
- Keyboard/mouse fallback controls (within Godot engine only)

Installation Instructions:
-----------------
**Note:** This package contains source code only. To run the application, you must install **Godot Engine 4.4** and set up the project manually.

1. Download and install the **Godot 4.4** engine from https://godotengine.org/download/archive/4.4-stable/ (choose 'Standard' version for your device)
2. Clone or extract the contents of this repository into a folder
3. Open the **Godot 4.4** engine, click **Import**, and select the project folder where you had extracted repository

For VR Simulation:
- Ensure you have a **Meta Quest 3** headset connected via **Meta Quest Link (USB or Air Link)**
- Launch **Meta Quest Link** on your headset and ensure the headset is visible to the PC
- Run the project from Godot project whilst the headset is linked

Running Instructions:
-----------------
Within Godot Engine:
- Open the project in Godot Engine (You will know it's open when the top middle of the engine has "2D 3D Script Game AssetLib" written)
- Then press F5 to launch the application
- If you are not using a VR headset, a popup ALERT will appear which you just need to press OK to (This is just to remind you that a headset is not connected)
- If a popup for "Files have been modified outside Godot" appear, you can press "Reload from disk"

Controls:
- **VR mode**: Use Meta Quest 3 controllers for interaction and hand tracking
- **Keyboard/Mouse mode** (in-editor only):
   - Look around: Move movement
   - Left hand: Hold **Q** and move mouse
   - Right hand: Hold **E** and move mouse
   - Interact: Hold Q or E and press **Left-click**

Note: The `.exe` export does not currently support keyboard/mouse input; fallback is only available through Godot editor play mode.

GitHub Repository:
-----------------
https://github.com/Aqil3141/EI-in-ASD-VR


Credits:
-----------------
Developed by:  
- Aqil Zaneefer (s3927741)  
- Cameron Mitchell (s3971747)  
- Mahdi Mohamadi (s3965422)  
- Jonathan Tan (s3946564)

Mentored by: James Harland  

==================================================
