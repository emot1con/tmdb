# Flutter TMDB App

A Flutter application that fetches and displays movie data from The Movie Database (TMDb) API.

## Features
- Browse popular, top-rated, and upcoming movies.
- Search for movies.
- View detailed movie information.
- Responsive and modern UI.

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/emot1con/tmdb.git
   ```
2. Navigate to the project directory:
   ```sh
   cd tmdb
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Add your TMDb API key:
   - Create a `.env` file in the root directory.
   - Add the following line:
     ```env
     TMDB_API_KEY=your_api_key_here
     ```
5. Run the app:
   ```sh
   flutter run
   ```

## API Key Setup
To use TMDb API, get your API key from [TMDb Developer Portal](https://www.themoviedb.org/settings/api) and replace `your_api_key_here` in the `.env` file.

