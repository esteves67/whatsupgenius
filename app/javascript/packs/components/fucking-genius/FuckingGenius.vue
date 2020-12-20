<template lang="html">
  <div class="fg d-flex h-100 w-100 align-items-center" :class="{open: open}">
    <div class="fg-container">
      <div class="card bg-dark">
        <div class="card-header text-center">
          <h4>{{ title }}</h4>
        </div>

        <div class="fg-loader" v-if="loader">
          <p>Identification à Spotify... 🧞‍♂️</p>
          <svg class="loader" width="50" height="50" viewBox="25 25 50 50" xmlns="http://www.w3.org/2000/svg">
            <circle cx="50" cy="50" r="20" fill="none" stroke-width="2"></circle>
          </svg>
        </div>

        <div v-else>
          <div v-if="this.step == 'login'">
            <div class="card-body">
              <label for="playlistName" class="mb-3">
                Choisis un nom pour ta playlist
                <span class="text-muted"><small>
                  ({{maxLength}} charactères maximum)
                </small></span>
              </label>
              <div class="input-group">
                <input v-model="playlistName" :maxLength="maxLength" id="playlistName" autocomplete="off" placeholder="What's up Genius?" class="form-control">
                <div class="input-group-append">
                  <span class="input-group-text">{{maxLength - playlistName.length}} caractères restants</span>
                </div>
              </div>

              <div class="mt-3">
                <label for="phone_number" class="mb-3">
                  Numéro de téléphone
                </label>
                <vue-phone-number-input
                  dark
                  color="silver"
                  :translations="translations"
                  v-model="phoneNumber"
                  @update="onPhoneUpdate"
                />
                <small class="text-muted">
                  Le numéro de téléphone est nécessaire pour associer la playlist au numéro WhatsApp
                </small>
              </div>

              <p class="text-center mt-4" v-if="playlistName">
                Après connexion à Spotify, la playlist 
                <span class="font-italic">"{{playlistName}}"</span>
                sera créée sur ton compte. 🤘
              </p>
            </div>

            <div class="card-footer text-center">
              <button class="btn btn-lg btn-success" @click="spotifyLogin" :disabled="disabledButton">
                Connexion à Spotify <i class="fab fa-spotify"></i>
              </button>
            </div>
          </div>
          
          <div v-else class="card-body">
            <div class="success-body">
              <p>
                Il ne te reste plus qu'à ajouter le numéro ci-dessous sur WhatsApp
                et à lui envoyer le message "<span class="font-weight-bold">join laugh-list</span>" pour valider ton numéro.
                <div class="success-phone-number">
                  <h2>{{ this.twilioNumber }}</h2>
                  <small>N'oublie pas d'envoyer le message "<span class="font-weight-bold">{{ this.twilioListCode }}</span>" pour valider ton numéro.</small>
                </div>
                <div class="success-how-it-works">
                  <h5>Comment ça marche ?</h5>
                  <p>
                    Pour rechercher une musique sur Spotify ou les lyrics sur Genius, envoie "WUG" suivi de ta recherche.
                    Par exemple, envoie "<span class="font-italic">WUG snow moha la squale</span>"
                    et laisse-toi guider !
                  </p>
                </div>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
function defaultData() {
  return {
    open:             false,
    maxLength:        25,
    playlistName:     '',
    loader:           false,
    userCreated:      false,
    step:             'login',
    twilioNumber:     '',
    twilioListCode:   '',
    phoneNumber:      '',
    phoneNumberValid: false,
    translations:     {
      countrySelectorLabel: 'Code pays',
      countrySelectorError: 'Choisir un pays',
      phoneNumberLabel: 'Numéro de téléphone',
      example: 'Exemple :'
    }
  }
}

export default {
  data: defaultData,

  mounted: function() {
    var self = this
    var newFuckingGenius = document.querySelectorAll('.fucking-genius')

    for (var i = 0; i < newFuckingGenius.length; i++) {
      newFuckingGenius[i].addEventListener('click', function(){
        self.open = true
      });
    }

    this.fillTwilioData()
  },

  computed: {
    title: function() {
      if (this.step == 'login') {
        return 'Abracadabra...'
      } else {
        return 'Cool, la playlist a bien été créée ! 🔥'
      }
    },

    disabledButton: function() {
      if (!this.playlistName.length || !this.phoneNumberValid) {
        return 'disabled'
      }
    }
  },

  methods: {
    fillTwilioData: function() {
      this.$http.get('/twilio-data').then(response => {
        this.twilioNumber = response.data.twilioNumber
        this.twilioListCode = response.data.twilioListCode
      }, error => {
        console.log(error.data)
      })
    },

    spotifyLogin: function() {
      this.loader = true
      document.cookie = 'playlistName=' + this.playlistName
      document.cookie = 'phoneNumber=' + this.phoneNumber
      const userToken = this.generateToken()
      const self = this

      this.$http.get('/spotify-login', { params: { user_token: userToken } }).then(response => {
        window.open(response.data.uri)
      }, error => {
        console.log(error.data)
      });

      window.interval = setInterval(function() {
        self.userNotCreated(userToken)
      }, 1500)
    },

    generateToken: function() {
      return Math.random().toString(36).substr(2)
    },

    checkUserRequest: function(userToken) {
      this.$http.get('/check-user', { params: { user_token: userToken } }).then(response => {
        if(response.data.status === 'matched') {
          this.userCreated = true
        }
      });
    },

    userNotCreated: function(userToken) {
      if (!this.userCreated) {
        this.checkUserRequest(userToken)
      } else {
        clearInterval(window.interval)
        this.loader = false
        this.step = 'userCreated'
      }
    },

    onPhoneUpdate(data) {
      if (data.isValid) {
        this.phoneNumber = data.formattedNumber
        this.phoneNumberValid = true
      } else {
        this.phoneNumberValid = false
      }
    }
  }
}
</script>

<style lang="scss">
$whatsupgenius: #f76d23;

.fg {
  position: fixed;
  z-index: 100;
  opacity: 0;
  top: 0;
  left: 0;
  pointer-events: none;
  transition: opacity .25s ease-out;
  background-color: rgba(0, 0, 0, 0.75);
  will-change: transform;
  overflow: auto;
  .fg-container {
    min-width: 600px;
    min-height: 300px;
    margin: 0 auto;
    padding: 20px;
    .card {
      width: 600px;
      .card-header {
        h4 { margin-bottom: 0 }
      }
      .fg-loader {
        display:flex;
        align-items: center;
        flex-direction: column;
        justify-content: center;
        z-index: 10;
        height: 192px;
        .loader{
          animation: loading-rotation 1400ms linear infinite;
          margin: 9px 0;
          circle {
            stroke: $whatsupgenius;
            stroke-dasharray: 120;
            stroke-dashoffset: 0;
            transform-origin: center;
            animation: loading-dash 1400ms ease-in-out infinite;
          }
        }
        &.white {
          circle {
            stroke: #FFFFFF;
          }
        }
      }
      @keyframes loading-rotation {
        100% { transform: rotate(360deg) }
      }
      @keyframes loading-dash {
        0% {
          stroke-dasharray: 1,200;
          stroke-dashoffset: 0;
        }
        50% {
          stroke-dasharray: 89,200;
          stroke-dashoffset: -35;
        }
        100% {
          stroke-dasharray: 89,200;
          stroke-dashoffset: -124;
        }
      }
      .success-body {
        text-align: justify;
        .success-phone-number {
          text-align: center;
          margin: 1.5rem 0;
          h2 { color: $whatsupgenius }
          small { color: #a5a5a5 }
        }
        .success-how-it-works {
          font-size: .9rem;
          color: #eaeaea;
        }
      }
    }
  }
  &.open {
    pointer-events: auto;
    opacity: 1;
    .fg-container { transform: scale(1) }
  }
}
</style>
