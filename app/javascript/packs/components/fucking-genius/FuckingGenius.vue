<template lang="html">

  <div class="fg d-flex h-100 w-100 align-items-center" :class="{open: open}">
    <div class="fg-container">
      <div class="card bg-dark">
        <div class="card-header text-center">
          <h4>Abracadabra...</h4>
        </div>

        <div class="card-body">
          <label for="playlist_name" class="mb-3">
            Choisis un nom pour ta playlist
            <span class="text-muted"><small>
              ({{maxLength}} charactères maximum)
            </small></span>
          </label>
          <div class="input-group">
            <input v-model="playlist_name" :maxLength="maxLength" id="playlist_name" placeholder="What's up Genius?" class="form-control">
            <div class="input-group-append">
              <span class="input-group-text">{{maxLength - playlist_name.length}} caractères restants</span>
            </div>
          </div>
          <p class="text-center mt-4" v-if="playlist_name">
            Après connexion à Spotify, la playlist 
            <span class="font-italic">"{{playlist_name}}"</span>
            sera créée sur ton compte. 🤘
          </p>
        </div>

        <div class="card-footer text-center">
          <button class="btn btn-lg btn-success" @click="submit" :disabled="!playlist_name.length">
            Connexion à Spotify <i class="fab fa-spotify"></i>
          </button>
        </div>
      </div>
    </div>
  </div>

</template>

<script>

function defaultData() {
  return {
    open: false,
    playlist_name: '',
    maxLength: 25
  }
}

export default {
  data: defaultData,
  mounted: function() {
    var self = this;

    var newFuckingGenius = document.querySelectorAll('.fucking-genius');
    for (var i = 0; i < newFuckingGenius.length; i++) {
      newFuckingGenius[i].addEventListener('click', function(){
        self.open = true;
      });
    }
  },

  methods: {
    submit: function() {
      document.cookie  = 'playlist_name=' + this.playlist_name + ';';
      var authorizeURL = window.location.href + 'auth/spotify';

      window.location = authorizeURL;
    }
  }
}

</script>

<style lang="scss">

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
      }
    }

    &.open {
      pointer-events: auto;
      opacity: 1;
      
      .fg-container {
        transform: scale(1);
      }
    }
  }

</style>
