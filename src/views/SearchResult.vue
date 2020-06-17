<template>
  <div class="container" :class="darkMode ? 'dark' : ''">
    <h6 v-if="foundPost" class="pt-3 mb-0">Showing result of "{{ $route.params.item }}"</h6>
    <hr v-if="foundPost">
    <div v-if="foundPost">
      <SearchResultItem v-for="cocktail in searchResultArray" :cocktail="cocktail" :key="cocktail.recipe_id" />
    </div>
    <p v-if="!foundPost" class="mt-5">Sorry, we can't find cocktail related to <strong>"{{ $route.params.item }}"</strong></p>
    <p v-if="rootIsLoggedIn && !foundPost">
      Would you like to
      <b-link to="/create" id="createLink">
        <b><i>CREATE</i></b>
      </b-link>
       one?
    </p>
  </div>
</template>

<script>
import SearchResultItem from '@/components/SearchResultItem'
export default {
  name: 'SearchResult',
  components: {
    SearchResultItem
  },
  data () {
    return {
      searchResultArray: Array,
      searchItem: '',
      foundPost: false
    }
  },
  props: {
    rootIsLoggedIn: Boolean,
    darkMode: Boolean
  },
  methods: {
    async searchThis (value) {
      this.$emit('overlay-control', true)
      const response = await fetch('/api/ws.php?method=search&searchfield=' + value, {
        method: 'GET',
        cache: 'no-cache',
        credentials: 'include'
      })
      const data = await response.json()
      if (response.ok) {
        this.searchResultArray = data.data
        this.foundPost = true
      }
      if (!response.ok) {
        const fetchResult = {
          response, data
        }
        this.foundPost = false
        this.$emit('display-alert', fetchResult)
      }
      this.$emit('overlay-control', false)
    }
  },
  watch: {
    searchItem: {
      handler () {
        this.searchThis(this.searchItem)
      }
    }
  },
  created () {
    this.searchItem = this.$route.params.item
  },
  updated () {
    this.searchItem = this.$route.params.item
  }
}
</script>
<style scoped>
a#createLink {
  color: black;
}
.dark a#createLink {
  color: white;
}
</style>
