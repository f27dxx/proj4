<template>
  <div :class="darkMode ? 'dark' : ''">
    <h1>404</h1>
  </div>
</template>

<script>
export default {
  name: 'NotFound',
  props: {
    darkMode: Boolean
  }
}
</script>
