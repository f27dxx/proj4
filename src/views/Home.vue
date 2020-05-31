<template>
  <div :class="darkMode ? 'dark' : ''">
    <Carousel />
    <div class="container mt-3">
      <SearchResultItem v-for="cocktail in searchResultArray" :cocktail="cocktail" :key="cocktail.recipe_id" />
    </div>
  </div>
</template>

<script>
import Carousel from '@/components/Carousel'
import SearchResultItem from '@/components/SearchResultItem'
export default {
  name: 'Home',
  components: {
    Carousel,
    SearchResultItem
  },
  props: {
    darkMode: Boolean
  },
  data () {
    return {
      searchResultArray: []
    }
  },
  created () {
    this.bringRecipe()
  },
  methods: {
    async bringRecipe () {
      const response = await fetch('/api/ws.php?method=rrecipe', {
        method: 'GET',
        cache: 'no-cache',
        credentials: 'include'
      })
      const data = await response.json()
      this.searchResultArray = [data.data[0], data.data[1], data.data[2]]
      console.log(this.searchResultArray)
    }
  }
}
</script>

<style>
.dark {
  background-color: #343a40;
}
</style>
