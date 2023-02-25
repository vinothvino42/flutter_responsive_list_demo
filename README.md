# Flutter Dynamic Data Grid & List App

A demo app for showing dynamic data grids and list view with responsive user interface

## Getting Started

1. Open the flutter project
2. Run ```flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs``` in the root directory
3. Run ```flutter run``` to run the project

## Integration Testing
1. Run ```flutter test integration_test``` to run the integration test

NOTE: 
1. Currently, flutter integration test will not work in the Flutter Web
2. I added one dummy json file in the assets to check multiple types (string, boolean, date etc)
3. In order to work, the json file root object must be the ```data``` key of type list of json objects

## App Flow
 - Video - https://drive.google.com/file/d/1TUGIq0yyVzeIdR1hhPqSEDekc97Lny4W/view?usp=share_link

## Integration Test Flow
 - Video - https://drive.google.com/file/d/1ogRHqBm78rHwt5Vuylww2aLEdb8uR-y5/view?usp=share_link