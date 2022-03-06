# Magpie

**Setup guide**

1. Clone the repository or download the source code

2. Download *Docker* from https://www.docker.com/products/docker-desktop and install it, *including WSL2*

3. Open a terminal inside the root directory and write "*docker-compose up*" to start the Docker container

4. Download *MySQL workbench* from https://dev.mysql.com/downloads/workbench/ 

5. In MySQL workbench:
   - add a new connection using the default settings and the password "*password*",
   - open and run the database script *Magpie.sql* from the repository

6. In a terminal, go to the *backend* directory, execute "*npm install*" to install the backend packages, and start the backend by writing “*node server.js*”

7. Download and install *Android Studio* (on Windows) from https://developer.android.com/studio/ or *XCode* (on MacOS) from https://developer.apple.com/xcode/resources/

8. In the respective IDE, create an emulator, since the app only runs on emulators at the moment

9. Start the emulator, drag the *Magpie.apk* file in it and click on it to run the app
