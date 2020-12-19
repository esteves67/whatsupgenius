# What's up Genius?

> This application is not intended to be published. I don't want to monetize it, so the costs would be too important.
Think of it as a technical gateway demonstration between the Twilio's API, Spotify and Genius.com.
I developed it with Ruby on Rails and the web application form is a Vue.js component.
Feel free to install it, try it and even modify it to learn new things to the bot, it's pretty cool!

![What's up Genius? demo 1](https://media.giphy.com/media/GeTuWzucRMZp27d2U0/giphy.gif)
![What's up Genius? demo 1](https://media.giphy.com/media/Nq6T8LX3CEpegoA1BO/giphy.gif)

---

##### Requirements
- [Ruby MRI](https://www.ruby-lang.org/) 2.7.2
- [Rails](http://rubyonrails.org/) 6.0.x
- [PostgreSQL](https://www.postgresql.org/)
- [Ngrok](https://ngrok.com/)

---

## Setup

Clone the project:
`git@github.com:escanxr/whatsupgenius.git`

Set up the dependencies:
```bash
cd whatsupgenius
bundle install
```

then
```bash
yarn install
```

Create a PostgreSQL role:
```sql
CREATE ROLE whatsupgenius WITH ENCRYPTED PASSWORD 'choose_a_password' NOSUPERUSER CREATEDB LOGIN;
```

You can now add the postgres user password to the credentials:
```bash
# In your terminal
EDITOR=nano bin/rails credentials:edit

# Edit with this:
database:
  password: 'REPLACE THIS WITH THE PASSWORD'
```

Then set up the database:
```bash
bin/rails db:setup
```

---

## Accounts

### Spotify
To work with the Spotify API, we have to create an application from the [Spotify developer dashboard](https://developer.spotify.com/dashboard/login). 
Create a new application, then fill the form.
- *Name*: Whatsupgenius
- *Description*: Add some songs to a collaborative playlist on Spotify and get the lyrics on Genius thanks to a WhatsApp bot. 🔥 🎶
- *Type*: Website

You are now asked if this a commercial integration, choose "*No*".
Now, copy the *Client ID* and *Client Secret*, then add them to your credentials:

```bash
spotify:
    client_id: 'your_client_id_key'
    client_secret: 'your_client_secret_key'
```

**Last thing:** Click on "*Edit settings*", enter the redirect URL `http://localhost:3000/auth/spotify/callback` and click *Add*.

---

### Genius
The bot is able to send the music lyrics thanks to Genius's API. To do that, we have to create a client and grab an access token.
Go to [Genius API clients](https://genius.com/api-clients). You can write anything, we'll only use the access token to get the lyrics.
Now, add the `access_token` to your credentials as seen previously:

```bash
genius:
    access_token: 'your_genius_access_token'
```

That's all!

---

### Twilio
Twilio allows us to send a message to a Whatsapp number that we control. Then, Twilio will send an HTTP request, or webhook, to our application. 
We will use this to respond to incoming messages and add songs to the playlist or get lyrics.

Create a [Twilio account](https://www.twilio.com/try-twilio) and copy your authentification token.
Now, go to [Twilio Whatsapp sandbox](https://www.twilio.com/console/sms/whatsapp/sandbox) and copy the phone number.
Also copy the code that looks like `join xxx-list`.

Edit the credentials with these informations:
```bash
twilio:
    auth_token: 'twilio_auth_token'
    phone_number: 'twilio_phone_number'
    list_code: 'join xxx-list'
```

---

### Just a last thing to do

If you never used ngrok, go to the [ngrock website](https://ngrok.com), create an account and follow the instructions to install and configure it.

Start ngrok in your terminal tab:
```bash
./ngrok http 3000
```
Now that ngrok is started, copy the forwarding link (looks like http://xxxxx.ngrok.io).
Add the `/twilio/messages` path to it like `http://xxxxx.ngrock.io/twilio/messages`.

Go back to the [Twilio Whatsapp sandbox](https://www.twilio.com/console/sms/whatsapp/sandbox), enter this URL to `WHEN A MESSAGE COMES IN` and save.

Now, we'll allow our phone number to send messages to the Sandbox. Follow this link: [Twilio Whatsapp Learn](https://www.twilio.com/console/sms/whatsapp/learn). 
Create a contact on your phone with the number given on the page and send to it the code (something like `join xxx-list`) in Whatsapp.

---

### If the sandbox reponds, well done, you're all set!

Please uncomment the code in `config/application.rb` and `config/initializers/rspotify.rb`. You would have had errors if this code was not commented out before adding the credentials of Twilio and Spotify.

You can now start the app with `foreman s` in another terminal tab and go to [http://localhost:3000](http://localhost:3000). Enjoy!

---

## How to add a music to the playlist or get the lyrics?

On the homepage, click the '*I am ready*' button. Enter a playlist name and your phone number, then login with your Spotify account.
Open your Spotify application: a new playlist has been created!

Now, you are able to manage this one with Whatsapp. Send to the Twilio contact your query preceded by 'wug' (*What's up Genius?* acronym).
If the first word of the query is 'wug', it's sent to Spotify and, if there's a result, Twilio returns it in the conversation.
This is the song that you wanted? Ok, so you just have to respond to the bot with something like `'yes', 'oui', 'yeah', 'ouais', 'yep', 'yup' or '👍'`.
If it's not what you wanted, type `'no', 'non', 'nah', 'nan', 'nope', 'nop' or '👎'`.

You can also reply to the bot by "lyrics" to get the lyrics without adding the sound to the playlist.
If you want to directly search the lyrics on Genius, just type "lyrics _your\_query_"!

You can easily add some available responses within `message_manager` locale.
