<template>
  <b-container fluid class="px-0" id="navbar-view">
    <b-navbar class="px-0" :variant="darkMode ? 'dark' : 'light'">
      <b-row>
        <b-col cols="3">
          <b-button v-b-toggle.sidebar-backdrop :variant="darkMode ? 'dark' : 'light'">
            <b-icon-list />
          </b-button>
        </b-col>
        <b-col cols="6">
          <b-navbar-brand to="/" class="ml-5 mr-0">
            <h4 id="cocktailer" class="my-0" :class="darkMode ? 'dark' : ''">
              Cocktailer
            </h4>
          </b-navbar-brand>
        </b-col>
        <b-col cols="3" class="pr-0">
          <b-button
            :class="visible ? null : 'collapsed'"
            :aria-expanded="visible ? 'true' : 'false'"
            aria-controls="searchbar"
            @click.stop="visible = !visible"
            id="addCommentIcon"
            :variant="darkMode ? 'dark' : 'light'"
            class="float-right"
          >
            <b-icon-search />
          </b-button>
        </b-col>
      </b-row>
    </b-navbar>
    <b-collapse id="searchbar" v-model="visible">
      <b-input-group>
        <b-form-input v-model="searchItem" @keyup.enter="searchThis" placeholder="Enter cocktail name or ingredient..."/>
        <b-input-group-append>
          <b-button @click="searchThis"
          :variant="darkMode ? 'dark' : 'light'"
          size="sm"
        >
          <b-icon-arrow-return-left />
        </b-button>
        </b-input-group-append>
      </b-input-group>
      <!-- <input v-model="searchItem" @keyup.enter="searchThis" type="text" placeholder="Enter cocktail name or ingredient...">
      <b-icon-arrow-return-left @click="searchThis"/> -->
    </b-collapse>
    <b-sidebar
      id="sidebar-backdrop"
      :title="rootUsername"
      backdrop shadow
      :bg-variant="darkMode ? 'dark' : 'light'"
      :text-variant="darkMode ? 'light' : 'dark'"
    >
      <template v-slot:default="{ hide }">
        <div class="px-3 py-2">
          <nav class="mb-3">
            <b-nav vertical :class="darkMode ? 'local-dark' : ''">
              <b-nav-item v-if="rootIsLoggedIn && superAdmin" to="/admin" @click="hide">Admin</b-nav-item>
              <b-nav-item v-if="rootIsLoggedIn" to="/create" @click="hide">Create Recipe</b-nav-item>
              <b-nav-item to="/search/vodka" @click="hide">Vodka</b-nav-item>
              <b-nav-item to="/search/tequila" @click="hide">Tequila</b-nav-item>
              <b-nav-item to="/search/rum" @click="hide">Rum</b-nav-item>
              <b-nav-item to="/search/brandy" @click="hide">Brandy</b-nav-item>
              <b-nav-item to="/search/whiskey" @click="hide">Whiskey</b-nav-item>
              <b-nav-item to="/search/gin" @click="hide">Gin</b-nav-item>
            </b-nav>
          </nav>
        </div>
      </template>
      <template v-slot:footer>
        <div class="d-flex align-items-center px-3 py-2" :class="darkMode ? 'local-secondary' : ['bg-dark', 'text-light']">
          <strong class="mr-auto">
            <b-icon-sun v-if="darkMode" @click="sendDarkMode(false)" id="sun"/>
            <b-icon-moon v-if="!darkMode" @click="sendDarkMode(true)" id="moon"/>
          </strong>
          <b-button @click="controlModal('login')" v-if="!rootIsLoggedIn" variant="link" class="text-light">Login </b-button>
          <b-button @click="controlModal('register')" v-if="!rootIsLoggedIn"  :variant="darkMode ? 'info' : 'primary'">Sign Up</b-button>
          <b-button @click="logout" v-if="rootIsLoggedIn" :variant="darkMode ? 'info' : 'primary'">Logout</b-button>
        </div>
      </template>
    </b-sidebar>
  </b-container>
</template>

<script>
export default {
  name: 'Header',
  data () {
    return {
      searchItem: '',
      visible: false,
      superAdmin: false
    }
  },
  props: {
    rootUsername: String,
    rootIsLoggedIn: Boolean,
    clientIp: String,
    darkMode: Boolean
  },
  mounted () {
    this.verifySuperadmin()
  },
  watch: {
    clientIp: {
      immediate: true,
      handler () {
        this.verifySuperadmin()
      }
    }
  },
  methods: {
    sendDarkMode (boo) {
      if (boo) {
        this.$emit('control-dark-mode', true)
      }
      if (!boo) {
        this.$emit('control-dark-mode', false)
      }
    },
    searchThis () {
      this.$router.push({ path: `/search/${this.searchItem}` })
      this.showSearchBar = false
      this.searchItem = ''
      this.visible = !this.visible
    },
    controlModal (modal) {
      this.$emit('control-modal', modal)
    },
    async logout () {
      this.$emit('overlay-control', true)
      const response = await fetch('/api/ws.php?method=logout', {
        method: 'GET',
        credentials: 'include'
      })
      const data = await response.json()
      if (response.ok) {
        const logout = {
          rootUserId: '',
          rootPrivilege: '',
          rootUsername: '',
          rootIsLoggedIn: false
        }
        this.$emit('log-me-out', logout)
      }
      const fetchResult = {
        response, data
      }
      console.log(fetchResult)
      this.$emit('display-alert', fetchResult)
      this.$emit('overlay-control', false)
    },
    verifySuperadmin () {
      // console.log(process.env.VUE_APP_IP)
      if (process.env.VUE_APP_IP.includes(this.clientIp)) {
        this.superAdmin = true
      }
      if (process.env.VUE_APP_IP.includes(this.clientIp) === false) {
        this.superAdmin = false
      }
    }
  }
}
</script>

<style scoped>
.local-dark li a {
  color: #eee;
}
.local-secondary {
  background-color: #212529;
}
.row {
  width: 100vw;
}
.navbar-brand {
  text-align: center;
  font-size: 1.3em;
}
.nav-link {
  text-align: left;
  color: black;
}

.b-sidebar-outer,
.b-sidebar-footer {
  z-index: 5;
}
#sun {
  color: white;
}
#moon {
  color: yellow;
}

#cocktailer {
  width: 138px;
  position: absolute;
  margin-left: -69px;
  left: 50%;
  top: 5px;
}
</style>
