<template>
  <div>
    <b-alert
      :show="dismissCountDown"
      dismissible
      variant="warning"
      @dismissed="dismissCountDown=0"
      @dismiss-count-down="countDownChanged"
      class="mt-4"
    >
      <p>This alert will dismiss after {{ dismissCountDown }} seconds...</p>
    </b-alert>
  </div>
</template>

<script>
export default {
  name: 'FriendlyReminder',
  data () {
    return {
      dismissSecs: 3,
      dismissCountDown: 0,
      showDismissibleAlert: false
    }
  },
  methods: {
    countDownChanged (dismissCountDown) {
      this.dismissCountDown = dismissCountDown
    },
    showAlert () {
      this.dismissCountDown = this.dismissSecs
    }
  }
}
</script>

<style scoped>
</style>
