<template>
  <div>
    <b-modal
      centered
      hide-footer
      id="login-form-modal"
      ref="login-form-modal"
      size="sm"
      :headerBgVariant="darkMode ? 'dark' : 'light'"
      :headerTextVariant="!darkMode ? 'dark' : 'light'"
      :bodyBgVariant="darkMode ? 'dark' : 'light'"
      :bodyTextVariant="!darkMode ? 'dark' : 'light'"
    >
      <template v-slot:modal-title>
        <p class="mb-0">Login <b-icon-lock /></p>
      </template>
      <ValidationObserver ref="form" v-slot="{ handleSubmit, invalid }">
        <b-form @submit.prevent="handleSubmit(onSubmit)" novalidate>
          <ValidationProvider rules="required|alphaNum|min:5|max:15" name="Username" v-slot="{ valid, errors }">
            <b-form-group
              label-text-align="left"
              id="input-group-1"
              label-for="input-1"
              description=""
            >
              <b-form-input
                id="input-1"
                v-model="form.username"
                :state="errors[0] ? false : (valid ? true : null)"
                type="text"
                required
                placeholder="Enter username"
              />
              <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
            </b-form-group>
          </ValidationProvider>
          <ValidationProvider rules="required|alphaNum|min:8|max:80" name="Password" v-slot="{ valid, errors }">
            <b-form-group
              id="input-group-2"
              label-for="input-2"
              description=""
            >
              <b-form-input
                id="input-2"
                v-model="form.password"
                :state="errors[0] ? false : (valid ? true : null)"
                type="password"
                required
                placeholder="Enter password"
              />
              <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
            </b-form-group>
          </ValidationProvider>
          <input type="checkbox" v-model="checkbox" id="checkbox">
          <label for="checkbox" class="ml-2">Remember me?</label>
          <b-button :disabled="invalid" block type="submit" :variant="darkMode ? 'info' : 'primary'">Login</b-button>
        </b-form>
      </ValidationObserver>
    </b-modal>
  </div>
</template>

<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
export default {
  name: 'LoginModal',
  components: {
    ValidationObserver,
    ValidationProvider
  },
  props: {
    loginFormTrigger: Boolean,
    darkMode: Boolean
  },
  data () {
    return {
      form: {
        username: localStorage.getItem('loginName'),
        password: ''
      },
      checkbox: localStorage.getItem('loginName')
    }
  },
  watch: {
    loginFormTrigger: {
      handler () {
        this.toggleModal()
      }
    }
  },
  methods: {
    onSubmit () {
      this.$refs.form.validate().then(success => {
        if (!success) {
          return
        }
        this.jsonInput = this.form
        this.login()
      })
    },
    async login () {
      this.$emit('overlay-control', true)
      const response = await fetch('/api/ws.php?method=login', {
        method: 'POST',
        cache: 'no-cache',
        credentials: 'include',
        body: JSON.stringify(this.form)
      })
      const data = await response.json()
      console.log(response)
      console.log(data)
      if (response.ok) {
        const loginDetails = {
          rootUserId: data.user_id,
          rootPrivilege: data.privilege,
          rootUsername: data.username,
          rootIsLoggedIn: true
        }
        if (this.checkbox) {
          localStorage.setItem('loginName', this.form.username)
        } else {
          localStorage.removeItem('loginName')
        }
        // Resetting Values
        this.form = {
          username: localStorage.getItem('loginName'),
          password: ''
        }

        // Wait until the models are updated in the UI
        this.$nextTick(() => {
          this.$refs.form.reset()
        })
        this.toggleModal()
        this.$emit('login-details', loginDetails)
      }
      const fetchResult = {
        response, data
      }
      console.log(fetchResult)
      this.$emit('display-alert', fetchResult)
      this.$emit('overlay-control', false)
    },
    toggleModal () {
      this.$refs['login-form-modal'].toggle()
    }
  }
}
</script>
