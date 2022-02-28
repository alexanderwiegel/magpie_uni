# Magpie

**Setup guide**

1. Clone the Gitlab repository and switch to the development branch or download the source code directly from the development branch

2. Follow the instructions from https://docs.flutter.dev/get-started/install to install the latest stable version of Flutter, an IDE that is supported on your OS and an emulator, since the app only runs on emulators at the moment.

3. Start the emulator and drop "app-release.apk" in it

4. Download MySQL workbench from https://dev.mysql.com/downloads/workbench/ 

5. In MySQL workbench, run the database script db_schema.sql

6. Inside backend/sql.js in line 8 change the “password” and set it to your MySQL password which is the same as your workbench password (by default its “root”)

7. Download Docker from https://www.docker.com/products/docker-desktop and install it, including WSL2

8. Open a terminal inside the root directory and write "docker-compose up" to start the Docker container

9. Go into the backend directory and start the backend by writing “node server.js”

10. Run the app by clicking on the run button
