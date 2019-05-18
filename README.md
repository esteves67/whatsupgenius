# What's up Genius?

## Please note that this application still in development and is not yet fully functional

##### Requirements
- [Ruby MRI](https://www.ruby-lang.org/) 2.5.1
- [PostgreSQL](https://www.postgresql.org/)
- [Rails](http://rubyonrails.org/) 5.2.x
- [Ngrok](https://ngrok.com/)

##### Languages / DSLs
- [Slim](http://slim-lang.com/)
- [Scss](http://sass-lang.com/)

##### Tools _(recommended, not mandatory)_
- [Visual Studio Code](https://code.visualstudio.com/)
- [Homebrew](http://brew.sh/)
- [RVM](https://github.com/rvm/rvm) (_via curl_)

## Setup

Set up the dependencies:
```bash
cd whatsupgenius
bundle install
```

Create a PostgreSQL role:
```sql
psql
CREATE ROLE whatsupgenius WITH PASSWORD 'choose_a_password';
```

Config files:
* `config/application.yml`
* `config/database.yml`

You have to fill in `database.yml` _(in order to start the app)_ with the previously created role and password.

Then set up the database:
```bash
rails db:setup
```

Start the app with:
```bash
foreman s
```

## Accounts

### Spotify
To work with the Spotify API, we have to create an application from the [Spotify developer dashboard](https://developer.spotify.com/dashboard/login). 
Create a new application, then fill the form.
- *Name*: Whatsupgenius
- *Description*: Add some songs to a collaborative playlist on Spotify and get the lyrics on Genius thanks to a WhatsApp bot. 🔥 🎶
- *Type*: Website

You are now asked if this a commercial integration, choose "*No*".
Now, copy the *Client ID* and *Client Secret*, then add them to `config/application.yml`.

**Last thing:** Click on "*Edit settings*", enter the redirect URL `http://localhost:3000/auth/spotify/callback` and click *Add*.

### Genius
The bot is able to send the song lyrics thanks to Genius's API. To do that, we have to create a client and grab an access token.
Go to [Genius API clients](https://genius.com/api-clients). You can write anything, we'll only use the access token to get the lyrics.
Now, go to `application.yml` then fill the `GENIUS_ACCESS_TOKEN` environment variable. That's all!

### Twilio
Twilio allows us to send a message to a Whatsapp number that we control. Then, Twilio will send an HTTP request, or webhook, to our application. 
We will use this to respond to incoming messages and add songs to the playlist.

Create a [Twilio account](https://www.twilio.com/try-twilio).
Than, add your *authentification token* to the `application.yml`.

### Just a last thing to do

Start Ngrok in a terminal tab like this:
```bash
./ngrok http 3000
```
Now that Ngrok is started, copy the forwarding link (*looks like http://xxxxx.ngrok.io*).
Add the `/twilio/messages` path to it like `http://xxxxx.ngrock.io/twilio/messages`.

Go to the [Twilio Whatsapp sandbox](https://www.twilio.com/console/sms/whatsapp/sandbox) and enter this URL to `WHEN A MESSAGE COMES IN`.
Now, we'll allow our phone number to send messages to the Sandbox. Follow this link: [Twilio Whatsapp Learn](https://www.twilio.com/console/sms/whatsapp/learn). 
Create a contact on your phone with the number given on the page and send to it the code (*something like `join xxx-list`*).

### That's all, let's go!

## How to add a music to the playlist?

On the homepage, click the '*I am ready*' button. Enter a playlist name and your phone number, then login with your Spotify account.
Psst, open your Spotify application: a new playlist has been created!

Now, you are able to manage this one with Whatsapp. Send to the Twilio contact your query preceded by 'wug' (What's up genius acronym).
If the first word of the query is 'wug', it's sent to Spotify and, if there's a result, Twilio returns it in the conversation.
This is the song that you wanted? Ok, so you just have to respond to the bot with something like `'yes', 'oui', 'yeah', 'ouais', 'yep', 'yup' or '👍'`.
If it's not what you wanted, type `'no', 'non', 'nah', 'nan', 'nope' or '👎'`.

You can easily add some available responses within `MessageManager` service.