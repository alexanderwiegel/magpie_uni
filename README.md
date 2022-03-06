# Magpie

**Setup guide**

1. Clone the Gitlab repository

2. Follow the instructions from https://docs.flutter.dev/get-started/install to install the latest stable version of Flutter, an IDE that is supported on your OS and an emulator, since the app only runs on emulators at the moment.

3. Download MySQL workbench from https://dev.mysql.com/downloads/workbench/ 

4. In MySQL workbench, run the database script Magpie.sql

5. Inside backend/sql.js in line 8 change the “password” and set it to your MySQL password which is the same as your workbench password (by default its “root”)

6. Download Docker from https://www.docker.com/products/docker-desktop and install it, including WSL2

7. Open a terminal inside the root directory and write "docker-compose up" to start the Docker container

8. Go into the backend directory and start the backend by writing “node server.js”

9. Run the app by clicking on the run button
