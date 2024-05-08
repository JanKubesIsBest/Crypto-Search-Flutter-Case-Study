# Crypto app 📱
As I know that the "Mobile Developer" position expects a knowledge of english, I will write this in English. 🇬🇧

At the end of the day, my school is heavy english based and I write most of my code in english, so this should not be a problem. 

## Plan 🧭
Technologies: 
- **Flutter** (Ofcourse :D)
    - This means that the app works on both **IOS and Anroid** 🔥
- **SQLite** database 
    - I have worked with SQLite multiple times and we had a big project on it recently in school. 
    - I'm going to make a SQL er diagram, so we can keep things simple and clean. 
- **Crypto API**
    - [[Coin Gecko](https://docs.coingecko.com)]

### Design 🧑‍💻
I'm going to start with light theme, but if there is enough time, I can do dark theme as well.

- **Material 3**
    - Design is mainly for Android, but it looks quite good on IOS too.
- **Cards**

#### Menu 
- Page view builder
    - First page: trending
    - Second page: favourites
        - Searched via ID from SQL database

#### Search bar
- Updates continously 
- Searched items are like a widgets
- Something like Trading 212

#### Coin page
- Graph
- Todays range
    - Visually shows you how the change in price looked like today
    - This is quite fun way of visualizing this, and it looks like a battle between profit and loss 

### Database 📈
- **SQLite**
    - Stores data locally 

<img src="https://github.com/JanKubesIsBest/nfctron-case-study/blob/main/crypto_app/lib/model/database/model_diagram/model_diagram.png">

#### CryptoCoin vs FullCryptoCoin
FullCryptoCoin extends CryptoCoin, for the purpose of getting more data.

Basically, **CryptoCoin is used when getting lists, FullCryptoCoin is used on the CoinPage**. FullCryptoCoin is then stored in the database.

# What I have learned 🚀
I have learned a lot of things...

First off, I have not had that big of a expiriance with Rest APIs, because in my previous projects I worked mainly with Firebase api and packages.

Next thing I learned was Fl_charts, which is quite fun way of displaying data. I had quite a struggle making it work, but in the end, it was worth it.

Although I have worked with MySQL library before, I think this has strengthened my proficincy in combining Flutter and MySQL.

### Graph 📈
Graph function is pretty cool, but it has limitations.

It uses different api, called tiingo. 

I did not find sufficient data about the assets tiingo can retrieve, so it is a little guess if the api will return the historical data or not.

**I know that big coins work, for example: Etherium, Bitcoin, Solana.**

## Room for more features
I know that there could be many features added, like:

- Storing the images locally.
- Storing the graphs locally.
- Adding "i_bought" table in MySQL
    - This could be fun way for users to track their profit/loss
    - "i_bought" would contain:
        - coin_id
        - date
    - Then you could just calculate profit/loss from historical data


## Limitations
Most errors come from the api overload. This is most visible in the CoinPage, where it shows the "Could not load data" text.