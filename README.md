A Music App made in Flutter with Riverpod and MVVM Architecture, Hive for local data, Python and FastAPI for backend and PostgreSQL for database.


## Project Structure

```plaintext
.
├── client/          # Flutter client application
└── server/          # Python server application
```

## Client Setup (Flutter)

To get the Flutter client up and running, follow these steps:

1. **Clone the repository:**

   ```sh
   git clone https://github.com/MAhmad329/music-app-flutter.git
   cd music-app-flutter/client
   ```

2. **Install dependencies:**

   Make sure you have Flutter installed on your machine. You can find installation instructions [here](https://flutter.dev/docs/get-started/install).

   Then, run the following command:

   ```sh
   flutter pub get
   ```

3. **Run the application:**

   Connect a device or start an emulator, then run:

   ```sh
   flutter run
   ```

## Server Setup (Python)

To set up the Python server, follow these steps:

1. **Clone the repository:**

   If you haven't already cloned the repository, do so now:

   ```sh
   git clone https://github.com/MAhmad329/music-app-flutter.git
   cd music-app-flutter/server
   ```

2. **Set up a virtual environment:**

   It's recommended to use a virtual environment to manage your Python dependencies. You can set one up with the following commands:

   ```sh
   python -m venv venv
   source venv/bin/activate   # On Windows, use `venv\Scripts\activate`
   ```

3. **Install dependencies:**

   Install the required dependencies using `requirements.txt`:

   ```sh
   pip install -r requirements.txt
   ```

4. **Configure database connection:**

   This project utilizes a PostgreSQL database. You'll need to set up a PostgreSQL instance and configure the connection details within the code.

5. **Run the server:**

   Start the server with the following command:

   ```sh
   python main.py
   ```

## Usage

After setting up both the client and server, you can use the application by running the Flutter client and ensuring the Python server is running in the background.



