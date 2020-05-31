<template>
  <div>
    <b-row>
      <b-col cols="4">
        <b-img @click="bringSingleRecipe(cocktail.recipe_id)" v-bind="imgProperties" :src="cocktail.imgUrl" />
      </b-col>
      <b-col cols="8">
        <b-row>
          <b-col @click="bringSingleRecipe(cocktail.recipe_id)"><strong> {{ cocktail.name }} </strong></b-col>
        </b-row>
        <b-row>
          <b-col class="item"><p class="little mb-0"> {{ cocktail.ingre_arr[0].item }}, {{ cocktail.ingre_arr[1].item }}, {{ cocktail.ingre_arr[2].item }} </p></b-col>
        </b-row>
        <b-row>
          <b-col>
            <p class="little mb-0 mt-2">
                <b-icon-heart @click="likeThis" v-if="!liked"/>
              <span class="heart-fill">
                <b-icon-heart-fill v-if="liked"/>
              </span>
              {{ cocktail.thumbsUp }}
            </p>
          </b-col>
        </b-row>
      </b-col>
    </b-row>
    <hr>
  </div>
</template>

<script>
export default {
  name: 'SearchResultItem',
  data () {
    return {
      imgProperties: {
        blank: false,
        left: true,
        rounded: true,
        fluid: true
      },
      liked: false
    }
  },
  props: {
    cocktail: Object
  },
  methods: {
    showMe () {
      console.log('show')
    },
    likeThis () {
      this.liked = !this.liked
    },
    bringSingleRecipe (recipeId) {
      this.$router.push({ path: `/recipe/${recipeId}` })
    }
  }
}
</script>

<style scoped>
.row .col p.little {
  font-size: 0.8em;
}
.col.item {
  min-height: 25px;
}
.heart-fill {
  color: red;
}
</style>
