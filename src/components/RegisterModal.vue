<template>
  <b-modal
    centered
    hide-footer
    id="register-form-modal"
    ref="register-form-modal"
    size="sm"
    :headerBgVariant="darkMode ? 'dark' : 'light'"
    :headerTextVariant="!darkMode ? 'dark' : 'light'"
    :bodyBgVariant="darkMode ? 'dark' : 'light'"
    :bodyTextVariant="!darkMode ? 'dark' : 'light'"
  >
    <template v-slot:modal-title>
      <p class="mb-0">Register <b-icon-person /></p>
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
        <b-button :disabled="invalid" block type="submit" :variant="darkMode ? 'info' : 'primary'">Register</b-button>
      </b-form>
    </ValidationObserver>
  </b-modal>
</template>

<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
export default {
  name: 'RegisterModal',
  components: {
    ValidationObserver,
    ValidationProvider
  },
  props: {
    RegFormTrigger: Boolean,
    darkMode: Boolean
  },
  data () {
    return {
      form: {
        username: '',
        password: ''
      }
    }
  },
  watch: {
    RegFormTrigger: {
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
        this.register()
        // Resetting Values
        this.form = {
          username: '',
          password: ''
        }

        // Wait until the models are updated in the UI
        this.$nextTick(() => {
          this.$refs.form.reset()
        })
      })
    },
    async register () {
      this.$emit('overlay-control', true)
      const response = await fetch('/api/ws.php?method=register', {
        method: 'POST',
        cache: 'no-cache',
        credentials: 'include',
        body: JSON.stringify(this.form)
      })
      const data = await response.json()
      if (response.ok) {
        this.toggleModal()
        this.form = {
          username: '',
          password: ''
        }

        // Wait until the models are updated in the UI
        this.$nextTick(() => {
          this.$refs.form.reset()
        })
        this.$emit('control-modal', 'login')
      }
      const fetchResult = {
        response, data
      }
      this.$emit('display-alert', fetchResult)
      this.$emit('overlay-control', false)
    },
    toggleModal () {
      this.$refs['register-form-modal'].toggle()
    }
  }
}
</script>
