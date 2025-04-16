# Crypto App 📱
*Note: **This app was developed as a case study for my summer internship/first real work experience in NFCtron**, this is not a project I have ever worked on for a longer period of time.*

## Overview 📖
This project is a mobile application developed using Flutter for tracking cryptocurrency prices and information. It provides users with features to view trending coins, search for specific cryptocurrencies, see detailed data including price charts, and manage a list of favorite coins stored locally.

## Technologies Used 🛠️

* **Flutter:** The core framework used for building the application, allowing for cross-platform deployment on both **iOS and Android** from a single codebase. 🔥
* **SQLite:** Employed for local database storage, primarily to persist the user's list of favorite cryptocurrencies.
* **Crypto APIs:** Integrates with third-party APIs (e.g., [CoinGecko](https://docs.coingecko.com), [Tiingo](https://www.tiingo.com)) to fetch real-time market data and historical price information.

## Core Features ✨

* **Main View (Page View):**
    * **Trending Page:** Displays currently trending cryptocurrencies based on market data.
    * **Favorites Page:** Shows coins that the user has marked as favorites, retrieved from the local SQLite database.
* **Search Functionality:**
    * Allows users to search for cryptocurrencies dynamically.
    * Search results are presented clearly, often using widget-based list items.
* **Coin Detail Page:**
    * Provides in-depth information about a selected cryptocurrency.
    * Includes a **graph** displaying historical price data.
    * Features a visual representation of the day's price range (high/low).
* **Local Storage:**
    * User's favorite coins are saved locally using the SQLite database.

## Design 🎨

* Built following **Material 3** design guidelines, offering a modern look and feel primarily optimized for Android but functional on iOS.
* Utilizes **Card-based layouts** for presenting information chunks clearly.
* Developed initially with a **light theme**, with the possibility of adding a dark theme in the future.

Enjoy simple snapshot from the app👇

![Image](https://github.com/user-attachments/assets/4a25b8a6-1806-4c02-923c-1ec7e01a5842)

## Database 📈

* **SQLite** is used for on-device storage.
* The primary use case is storing the IDs of the user's favorite coins.

#### Database Schema Diagram

<img src="https://github.com/JanKubesIsBest/nfctron-case-study/blob/main/crypto_app/lib/model/database/model_diagram/model_diagram.png" alt="Database ER Diagram">

#### Data Models: `CryptoCoin` vs `FullCryptoCoin`

The application uses two distinct models for handling cryptocurrency data:

* `CryptoCoin`: A basic model containing essential information suitable for displaying lists (e.g., search results, trending coins).
* `FullCryptoCoin`: Extends `CryptoCoin` with more detailed attributes required for the coin detail page (e.g., historical data points, extended description). This `FullCryptoCoin` object is typically what gets stored in the database when a user favorites a coin.

## Potential Future Enhancements 🚀

* **Local Caching:** Implement caching for images and graph data to reduce API calls and improve loading times.
* **Portfolio Tracking:** Add functionality for users to log their cryptocurrency purchases (coin ID, date, amount, price) and track their overall profit/loss based on current and historical data.
* **Advanced Filtering/Sorting:** Introduce more options for sorting and filtering coin lists (e.g., by market cap, price change).
* **Push Notifications:** Alert users about significant price changes for their favorite coins.

## Known Limitations ⚠️

* The application relies heavily on external APIs. Performance and data availability can be affected by API rate limits or downtime.
* Fetching historical data for graphs (often using a separate API like Tiingo) might not be available for all listed cryptocurrencies, potentially leading to missing graphs for less common coins. Errors related to API limits might display messages like "Could not load data".
