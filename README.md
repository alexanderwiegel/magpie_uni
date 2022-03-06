# Magpie

**Setup guide**

1. Clone the repository or download the source code

2. Follow the instructions from https://docs.flutter.dev/get-started/install to install:
   - the latest stable version of *Flutter*, 
   - *Android Studio* (on Windows) or *XCode* (on MacOS), 
   - and an emulator, since the app only runs on emulators at the moment.

3. Download *Docker* from https://www.docker.com/products/docker-desktop and install it, *including WSL2*

4. Open a terminal inside the root directory and write "*docker-compose up*" to start the Docker container

5. Download *MySQL workbench* from https://dev.mysql.com/downloads/workbench/ 

6. In MySQL workbench:
   - add a new connection using the default settings and the password "password",
   - open and run the database script *Magpie.sql*

7. Go into the backend directory, execute "npm install", and start the backend by writing “*node server.js*”

8. Run the app by clicking on the run button
