==================================================
READ ME – ASD Emotional Intelligence VR Project
==================================================

Project Title: 
-----------------
ASD VR Emotional Intelligence Trainer (HUDINI-537)

Project Overview:
-----------------
This project delivers a virtual reality (VR) application designed to support children and teenagers with Autism Spectrum Disorder (ASD) in developing emotional intelligence. The experience allows users to practice identifying and responding to emotions through immersive, gamified scenarios in a controlled VR environment. Built using Godot Engine 4.4, the application includes tutorial levels, real-world-inspired scenarios, and avatar customization features. 

The project was developed as part of RMIT’s SEP course onsite at the Virtual Experiences Lab, with input from educators, developers, and a team member diagnosed with ASD for accessibility testing.

Release Notes:
-----------------
Version: 1.0  
Start Date: 08 March 2025  
End Date: 16 June 2025

Key Features:
- Two tutorial levels with visual and auditory emotion prompts
- Two scenario levels: mall interaction and gift-receiving scene
- Avatar customization (e.g. hand color)
- Language toggle (Arabic and English)
- Sound/music customization
- Assessor login system (non-player)
- Keyboard/mouse fallback controls (for in-editor use only)

Installation Instructions:
-----------------
**Note:** This package contains source code only. To run the application, you must install **Godot Engine 4.4** and set up the project manually.

1. Download and install **Godot 4.4** from https://godotengine.org/download
2. Clone or extract the contents of `groupname-source.zip` into a folder
3. Open **Godot**, click **'Import Project'**, and select the `project.godot` file from the extracted folder

For VR Simulation:
- Ensure you have a **Meta Quest 3** headset connected via **Meta Quest Link (USB or Air Link)**
- Launch **Meta Quest Link** on your headset and ensure the headset is visible to the PC
- Run the project from Godot with XR enabled

Running Instructions:
-----------------
Within Godot:
- Press **F5** or click **Play** to launch the application
- Use the mouse to navigate menus, and keyboard or VR controllers in-game

Controls:
- **VR mode**: Use Meta Quest 3 controllers for interaction and hand tracking
- **Keyboard/Mouse mode** (in-editor only):
   - Look around: Move mouse
   - Left hand: Hold **Q** and move mouse
   - Right hand: Hold **E** and move mouse
   - Interact: **Left-click**

Note: The `.exe` export does not currently support keyboard/mouse input; fallback is only available through Godot editor play mode.

GitHub Repository:
-----------------
https://github.com/Aqil3141/EI-in-ASD-VR

Changelog:
-----------------
- Implemented full bilingual UI with toggle support
- Added scenario levels and improved narrative design
- Created fallback desktop input system for non-VR testing
- Integrated voice prompts and customizable hand colors

Credits:
-----------------
Developed by:  
- Aqil Zaneefer (s3927741)  
- Cameron Mitchell (s3971747)  
- Mahdi Mohamadi (s3965422)  
- Jonathan Tan (s3946564)

Mentored by: Dr. James Harland  
RMIT Virtual Experiences Lab (VXLab)

==================================================