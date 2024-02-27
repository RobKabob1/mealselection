# Meal Selection

[![Meal Selection](https://github.com/RobKabob1/mealselection/blob/main/images/icons/github-feature-graphic.png?raw=true)](https://mealselection.web.app/)

## Project Description

[Meal Selection](https://mealselection.web.app) is a mobile and web app created with the Flutter framework. It was the first mobile app published on the Google Play Store and Android App Store by [Step Pay LLC](https://steppay.tech). 

<a href="https://apps.apple.com/us/app/meal-selection/id6476314305?platform=iphone">    <img src="https://github.com/RobKabob1/mealselection/blob/main/images/icons/apple-app-store.png?raw=true" width="200" />    </a><a href="https://play.google.com/store/apps/details?id=tech.steppay.mealselection&pli=1"><img src="https://github.com/RobKabob1/mealselection/blob/main/images/icons/google-play-store.png?raw=true" width="205" /></a>

## Table of Contents

- [Tech Stack](#tech-stack)
- [Setting Up the Project](#setting-up-the-project)
- [Understanding the Project](#understanding-the-project)
- [Status, Reporting Bugs, and Issues](#status-reporting-bugs-and-issues)
- [License](#license)

### Tech Stack

Tech | Description
-- | --
Flutter | for mobile and web apps
Firebase | for Authentication, Firestore Database, and Storage

### Setting Up The Project

1. Ensure that Flutter is installed on your machine
    1. run flutter doctor to make sure flutter is set up correctly.
    2. That means have Android Studio with an Android Emulator working. 
    3. Also Chrome. 
    4. and make sure you have VS Code installed.
2. Download the code from our GitHub repo
3. Run flutter pub get in the terminal 
4. Set up firebase on your machine to log into 
5. In firebase, setup a project. 
6. set up authentication, real time database, and storage
7. In authentication, make sure to enable email/password
8. In storage you need to make a defaultPics folder. Put the empty_profile.jpg and no_food.jpg images in there
9. Now test that everything is working by running the project in your android emulator.
10. We will have a video created showing you how to set the project up from scratch, stay tuned!

### Understanding the Project

The important files that make up what you see in the application exist in the lib folder. It is sorted as follows:

Folder | Purpose
---- | ----
Components | Screens for our add and edit dialog boxes
Models | Models that we use for each of our foods and users
Providers | Currently houses the user provider for storing our user information and logged in/out status
Resources | Contains resources for accessing firebase and for getting a random food
Responsive | Determines what screens to return based on the screen size of the device used to access the application
Screens | The majority of the user-facing screens
Utils | Reference files used by several of the screens
Widgets | Reference widgets used by several of the screens

The main.dart file is what starts the application. It begins by sending us to the responsive folder. There, the program determines the screen size of the client and sends us to a web or mobile page. Each of these pages are located in the lib/screens/web or lib/screens/mobile folders respectively. 

The first screen that we see is the login screen, which will take us to the forgot password screen or sign up screens if the user needs to navigate there. If the user signs up, they will hit the onboarding screen and then move onto the home screen. If the user logs in, they will get directly to the home screen. 

The home screen lets us choose meals and sends us to specific meal menu screens based on the  meal time that we chose. Alternatively, we can choose to go to our profile screen.

### Status, Reporting Bugs, and Issues

The general platform status for the public application is available [here](https://stats.uptimerobot.com/apT6Ukws0g).

If you think you've found a bug, go ahead and create a new GitHub issue. Be sure to include as much information as possible so we can reproduce the bug. Bonus points go to people that include screenshots!

### License

The content of this repository is bound by the following licenses:

- The computer software is licensed under the [MIT License](LICENSE.md).
