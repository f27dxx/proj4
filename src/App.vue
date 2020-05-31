<template>
  <div id="app">
    <b-overlay :show="showOverlay" rounded="sm" :variant="darkMode ? 'dark' : 'light'" :spinner-variant="darkMode ? 'warning' : 'dark'">
      <Header
        @log-me-out="logoutUser"
        @display-alert="displayAlert"
        :rootIsLoggedIn="rootIsLoggedIn"
        :rootUsername="rootUsername"
        :clientIp="clientIp"
        :darkMode="darkMode"
        @control-modal="controlModal"
        @overlay-control="controlOverlay"
        @control-dark-mode="controlDarkMode"
      />
      <div>
        <RegisterModal
          :darkMode="darkMode"
          @overlay-control="controlOverlay"
          @control-modal="controlModal"
          @display-alert="displayAlert"
          :RegFormTrigger="RegFormTrigger"
        />
        <LoginModal
          @overlay-control="controlOverlay"
          @display-alert="displayAlert"
          @login-details="takeLoginDetails"
          :loginFormTrigger="loginFormTrigger"
          :darkMode="darkMode"
        />
      </div>
      <div>
        <b-modal
          v-if="isAdult != 'true'"
          visible
          id="eighteen"
          title="Are you over 18?"
          hide-footer
          centered
          hide-header-close
          no-close-on-esc
          no-close-on-backdrop
          size="sm"
        >
          <div class="d-block">
            <p class="my-4">Consume alcohol under 18 years old without supervisition is prohibited in Australia.</p>
          </div>
          <b-button class="mt-3" variant="primary" block @click="setIsAdult(true)">YES, I am over 18.</b-button>
          <b-button
            @click="setIsAdult(false)"
            class="mt-3"
            block variant="light"
            href="https://www.health.gov.au/health-topics/alcohol/about-alcohol/alcohol-laws-in-australia"
          >
          No
          </b-button>
        </b-modal>
      </div>
      <b-alert
        :show="dismissCountDown"
        dismissible
        :class="alertColor"
        @dismissed="dismissCountDown=0"
        @dismiss-count-down="countDownChanged"
        class="mt-0"
      >
        <p>{{ fetchData.message }}</p>
      </b-alert>
      <router-view
        :darkMode="darkMode"
        @control-modal="controlModal"
        @display-alert="displayAlert"
        :rootUsername="rootUsername"
        :rootUserId="rootUserId"
        :rootPrivilege="rootPrivilege"
        :rootIsLoggedIn="rootIsLoggedIn"
        @overlay-control="controlOverlay"
      />
    </b-overlay>
  </div>
</template>

<script>
import Header from './components/Header'
import RegisterModal from '@/components/RegisterModal'
import LoginModal from '@/components/LoginModal'
export default {
  data () {
    return {
      clientIp: '',
      showOverlay: false,
      dismissSecs: 3,
      dismissCountDown: 0,
      showDismissibleAlert: false,
      response: {},
      fetchData: {},
      alertColor: '',
      rootUsername: '',
      rootUserId: '',
      rootPrivilege: '',
      rootIsLoggedIn: false,
      isAdult: localStorage.getItem('isAdult'),
      loginFormTrigger: false,
      RegFormTrigger: false,
      darkMode: Boolean(localStorage.getItem('theme'))
    }
  },
  components: {
    Header,
    RegisterModal,
    LoginModal
  },
  created () {
    this.getClientIp()
  },
  mounted () {
    if (this.darkMode) {
      document.querySelector('body').style.backgroundColor = '#343a40'
    } else {
      document.querySelector('body').style.backgroundColor = '#FFFFFF'
    }
  },
  watch: {
    darkMode: {
      handler () {
        if (this.darkMode) {
          document.querySelector('body').style.backgroundColor = '#343a40'
        } else {
          document.querySelector('body').style.backgroundColor = '#FFFFFF'
        }
      }
    }
  },
  methods: {
    countDownChanged (dismissCountDown) {
      this.dismissCountDown = dismissCountDown
    },
    showAlert () {
      this.dismissCountDown = this.dismissSecs
    },
    getResponseValue (value) {
      this.response = value
    },
    getDataValue (value) {
      this.fetchData = value
    },
    displayAlert (value) {
      this.showAlert()
      this.getResponseValue(value.response)
      this.getDataValue(value.data)
      this.chooseAlertColor()
    },
    chooseAlertColor () {
      if (this.response.ok) {
        this.alertColor = 'green'
      } else {
        this.alertColor = 'red'
      }
    },
    takeLoginDetails (value) {
      this.rootUserId = value.rootUserId
      this.rootPrivilege = value.rootPrivilege
      this.rootUsername = value.rootUsername
      this.rootIsLoggedIn = value.rootIsLoggedIn
      console.log(value)
    },
    logoutUser (value) {
      this.rootUserId = value.rootUserId
      this.rootPrivilege = value.rootPrivilege
      this.rootUsername = value.rootUsername
      this.rootIsLoggedIn = value.rootIsLoggedIn
      console.log(value)
    },
    setIsAdult (boo) {
      this.$bvModal.hide('eighteen')
      if (boo) {
        localStorage.setItem('isAdult', true)
      } else {
        localStorage.removeItem('isAdult')
      }
    },
    async getClientIp () {
      const response = await fetch('https://api.ipify.org?format=json')
      const data = await response.json()
      this.clientIp = data.ip
      // console.log(this.clientIp)
    },
    controlModal (value) {
      if (value === 'login') {
        this.loginFormTrigger = !this.loginFormTrigger
      }
      if (value === 'register') {
        this.RegFormTrigger = !this.RegFormTrigger
      }
    },
    controlOverlay (boo) {
      if (boo) {
        this.showOverlay = true
      } else {
        this.showOverlay = false
      }
    },
    controlDarkMode (boo) {
      if (boo) {
        localStorage.setItem('theme', 'dark')
        this.darkMode = true
        console.log('dark selected')
      }
      if (!boo) {
        localStorage.removeItem('theme')
        this.darkMode = false
        console.log('no dark')
      }
    }
  }
}
</script>
<style lang="scss">
.dark {
  background-color: #343a40;
  color: #eee;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  // text-align: center;
  color: #2c3e50;
}

.alert {
  position: fixed;
  z-index: 999;
  left: 20%;
  width: 60%;
  height: 5vh;
  padding-top: 2%;
  background-color: green;
  border: 0;
  border-radius: 50px;
  opacity: 0.8;
  p {
    text-align: center;
    color: white;
  }
  button.close {
    padding-top: 2%;
    color: white;
    padding-left: 0;
    opacity: 0.8;
  }
}
div.b-overlay-wrap[aria-busy="true"] {
  z-index: 9999999;
  min-height: 100vh;
  width: 100vw;
  position: absolute;
}

.green {
  background-color: green;
}
.red {
  background-color: red;
}

.btn-primary,
.btn-primary:hover,
.btn-primary:active,
.btn-primary:visited,
.btn-primary:focus,
.btn-primary::selection,
.btn-primary:target,
.btn-primary:not(:disabled):not(.disabled):active,
.btn-primary.disabled,
.btn-primary:disabled {
  background-color: #7da2a9;
  border: #7da2a9;
}

.btn-info,
.btn-info:hover,
.btn-info:active,
.btn-info:visited,
.btn-info:focus,
.btn-info::selection,
.btn-info:target,
.btn-info:not(:disabled):not(.disabled):active,
.btn-info.disabled,
.btn-info:disabled {
  background-color: #fff463;
  border: #fff463;
  color: #333;
}

body {
  min-height: 100vh;
}
</style>
