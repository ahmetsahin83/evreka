# Evreka Application Development Task

This project is created to fulfill the application development task provided by Evreka company.

## Introduction

This application is a mobile app developed using Flutter and designed to run on the Android platform. The app is intended to show the fill rate of containers in a city and allow the user to update the locations of these containers. Additionally, it checks the user's internet connection and provides appropriate warnings regarding connection issues. If an error occurs, Sentry will provide us with information for resolution and analysis.

## User Login Screen

- When the user clicks on the login button, the internet connection is first checked.
- If there is no internet connection, an appropriate warning is shown to the user.
- User enters username and password.
- Server-side authentication is performed.
- If incorrect username or password is entered, an appropriate error message is displayed.


## Operation Screen

- Displays a map using Google Maps.
- There are 1,500 containers created with random data on Firebase Firestore.
- These containers are brought based on the view of the camera. All 1500 containers are not fetched at once. If the camera is zoomed out, more containers will be fetched as the area increases. As the map is manipulated, container information in the visible areas is fetched.
- When the user clicks on any container on the map, it displays the container's last known fill rate, information from sensors, and temperature measurements.
- User can update the container's location as specified in the design.
- If an error occurs during any operation, the user is notified and an error message is sent to me via Sentry.

## Running the Application

To access the application, use the following login credentials:

- Email: test@account.com
- Password: testaccount

Additionally, you can download the released .apk file from [here](https://github.com/ahmetsahin83/evreka/blob/main/evreka_app.apk).

