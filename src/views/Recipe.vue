<template>
  <div class="container" :class="darkMode ? 'dark' : ''">
    <b-modal
      id="commentModal"
      ref="commentModal"
      hide-footer centered
      title="Delete this comment?"
      size="sm"
      no-close-on-backdrop
      no-close-on-esc
      hide-header-close
      :headerBgVariant="darkMode ? 'dark' : 'light'"
      :headerTextVariant="!darkMode ? 'dark' : 'light'"
      :bodyBgVariant="darkMode ? 'dark' : 'light'"
      :bodyTextVariant="!darkMode ? 'dark' : 'light'"
    >
      <div class="d-block text-center">
        <p>"{{ deleteCommentContent }}"</p>
      </div>
      <b-button @click="deleteComment" class="mt-2" variant="danger" block>Delete</b-button>
      <b-button @click="$bvModal.hide('commentModal')" class="mt-3" :variant="darkMode ? 'dark' : 'light'" block>Nope</b-button>
    </b-modal>
    <!-- // modal for delete recipe  -->
    <b-modal
      id="recipeModal"
      ref="recipeModal"
      hide-footer centered
      title="Delete this recipe?"
      size="sm"
      no-close-on-backdrop
      no-close-on-esc
      hide-header-close
      :headerBgVariant="darkMode ? 'dark' : 'light'"
      :headerTextVariant="!darkMode ? 'dark' : 'light'"
      :bodyBgVariant="darkMode ? 'dark' : 'light'"
      :bodyTextVariant="!darkMode ? 'dark' : 'light'"
    >
      <div class="d-block text-center">
        <p>"{{ cocktailDetails.name }}"</p>
      </div>
      <b-button @click="deleteRecipe" class="mt-2" variant="danger" block>Delete</b-button>
      <b-button @click="$bvModal.hide('recipeModal')" class="mt-3" :variant="darkMode ? 'dark' : 'light'" block>Nope</b-button>
    </b-modal>
    <!-- // end modal  -->
    <b-img :src="cocktailDetails.imgUrl" fluid :alt="cocktailDetails.name" />
    <h3 class="mt-2 mb-0">{{ cocktailDetails.name }}</h3>
    <b-row>
      <b-col cols="9">
        <p class="mb-2">by <i>{{ cocktailDetails.username }}</i></p>
      </b-col>
      <b-col cols="3">
        <p class="mb-2"><b-icon-heart v-if="!liked" @click="likeThisRecipe" /> <b-icon-heart-fill v-if="liked" id="heart" /> {{ cocktailDetails.thumbsUp }}</p>
      </b-col>
    </b-row>
    <b-row
      v-if="rootPrivilege == 1 || rootUserId == cocktailDetails.user_id"
      class="mb-2"
    >
      <b-col>
        <b-button @click="bringUpdatePage(recipeId)" size="sm" class="mr-1">Update</b-button>
        <b-button v-b-modal.recipeModal variant="danger" size="sm">Delete</b-button>
      </b-col>
    </b-row>
    <p>{{ cocktailDetails.description }}</p>
    <b-row>
      <b-col>
        <b-button
          v-b-toggle.ingredients
          :variant="darkMode ? 'info' : 'primary'"
          id="showIngreButton"
          class="mb-1"
        >
          Ingredients
        </b-button>
        <b-collapse id="ingredients">
          <b-list-group class="mb-3">
            <b-list-group-item
              v-for="ingredient in cocktailIngre"
              :key="ingredient.i_id"
              :ingredient="ingredient"
            >
            {{ ingredient.quantity }} {{ ingredient.type }}  {{ ingredient.item }}
            </b-list-group-item>
          </b-list-group>
        </b-collapse>
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <b-button
          v-b-toggle.steps
          :variant="darkMode ? 'info' : 'primary'"
          id="showStepButton"
          class="mb-1"
        >
          Steps
        </b-button>
        <b-collapse id="steps" class="mb-3">
          <b-list-group>
            <b-list-group-item
              v-for="oneStep in cocktailStep"
              :key="oneStep.met_id"
              :oneStep="oneStep"
            >
             {{ oneStep.step }}
            </b-list-group-item>
          </b-list-group>
        </b-collapse>
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <b-button
          v-b-toggle.comments
          :variant="darkMode ? 'info' : 'primary'"
          id="showStepButton"
          class="mt-5"
        >
          <p class="mb-0">
            Comments <b-icon-plus-circle :class="visible ? null : 'collapsed'" v-if="rootIsLoggedIn" :aria-expanded="visible ? 'true' : 'false'" aria-controls="addCommentInput" @click.stop="visible = !visible" id="addCommentIcon" />
          </p>
        </b-button>
        <b-collapse id="addCommentInput" v-model="visible">
          <ValidationObserver ref="form" v-slot="{ handleSubmit }">
            <b-form @submit.prevent="handleSubmit(validateComment(recipeId))" novalidate>
              <ValidationProvider rules="required|min:5|max:30" name="Comment" v-slot="{ valid, errors }">
                <b-input-group>
                  <b-form-input
                    v-model="form.content"
                    :state="errors[0] ? false : (valid ? true : null)"
                  />
                  <b-input-group-append>
                    <b-button :variant="darkMode ? 'dark' : 'light'" size="sm"><b-icon-arrow-return-left @click="validateComment(recipeId)" /></b-button>
                  </b-input-group-append>
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </b-input-group>
              </ValidationProvider>
            </b-form>
          </ValidationObserver>
        </b-collapse>
        <b-collapse visible id="comments" class="mb-3">
          <b-list-group>
            <b-list-group-item
              v-for="(comment, index) in cocktailComment"
              :comment="comment"
              :key="comment.c_id"
            >
            <p class="mb-0">
                {{ comment.content }}
              <span id="trashCan">
                <b-icon-trash v-if="rootPrivilege == 1 || comment.username == rootUsername" @click="updateDeleteCommentTarget(comment.c_id, index, comment.content)" v-b-modal.commentModal />
                <span v-if="comment.username != rootUsername && rootPrivilege != 1" class="mb-0"><i>{{ comment.username }}</i></span>
              </span>
            </p>
            </b-list-group-item>
          </b-list-group>
        </b-collapse>
      </b-col>
    </b-row>
  </div>
</template>

<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
export default {
  name: 'Recipe',
  components: {
    ValidationObserver,
    ValidationProvider
  },
  data () {
    return {
      recipeId: '',
      cocktailDetails: '',
      cocktailIngre: '',
      cocktailStep: '',
      cocktailComment: '',
      form: {
        content: ''
      },
      deleteCommentIndex: '',
      deleteCommentTarget: '',
      deleteCommentContent: '',
      visible: false,
      liked: false
    }
  },
  props: {
    rootUsername: String,
    rootUserId: String,
    rootPrivilege: String,
    rootIsLoggedIn: Boolean,
    darkMode: Boolean
  },
  created () {
    this.recipeId = this.$route.params.id
    this.singlePage(this.recipeId)
  },
  methods: {
    async singlePage (value) {
      this.$emit('overlay-control', true)
      const response = await fetch('/api/ws.php?method=rrecipe&id=' + value, {
        method: 'GET',
        cache: 'no-cache',
        credentials: 'include'
      })
      const data = await response.json()
      this.cocktailDetails = data.data[0]
      this.cocktailIngre = data.data[0].ingre_arr
      this.cocktailStep = data.data[0].step_arr
      this.cocktailComment = data.data[0].comm_arr

      if (!response.ok) {
        const fetchResult = {
          response, data
        }
        this.$emit('display-alert', fetchResult)
      }
      this.$emit('overlay-control', false)
    },
    async submitComment (value) {
      this.$emit('overlay-control', true)
      const response = await fetch('/api/ws.php?method=ccomment&id=' + value, {
        method: 'POST',
        cache: 'no-cache',
        credentials: 'include',
        body: JSON.stringify(this.form)
      })
      const data = await response.json()
      const fetchResult = {
        response, data
      }
      this.$emit('display-alert', fetchResult)
      if (response.ok) {
        const addCommentItem = {
          c_id: data.c_id,
          content: this.form.content,
          username: this.rootUsername
        }
        this.cocktailComment.push(addCommentItem)
        this.form.content = ''
        // Wait until the models are updated in the UI
        this.$nextTick(() => {
          this.$refs.form.reset()
        })
      }
      this.visible = !this.visible
      this.$emit('overlay-control', false)
    },
    validateComment (value) {
      this.$refs.form.validate().then(success => {
        if (!success) {
          return
        }

        this.submitComment(value)
      })
    },
    updateDeleteCommentTarget (commentId, commentIndex, commentContent) {
      this.deleteCommentIndex = commentIndex
      this.deleteCommentTarget = commentId
      this.deleteCommentContent = commentContent
    },
    async deleteComment () {
      this.$emit('overlay-control', true)
      this.$bvModal.hide('commentModal')
      const response = await fetch('/api/ws.php?method=dcomment&id=' + this.recipeId, {
        method: 'POST',
        cache: 'no-cache',
        credentials: 'include',
        body: JSON.stringify({ c_id: this.deleteCommentTarget })
      })
      const data = await response.json()
      const fetchResult = {
        response, data
      }
      this.$emit('display-alert', fetchResult)
      if (response.ok) {
        this.cocktailComment.splice(this.deleteCommentIndex, 1)
      }
      this.$emit('overlay-control', false)
    },
    async deleteRecipe () {
      this.$emit('overlay-control', true)
      this.$bvModal.hide('recipeModal')
      const response = await fetch('/api/ws.php?method=drecipe&id=' + this.recipeId, {
        method: 'POST',
        cache: 'no-cache',
        credentials: 'include'
      })
      const data = await response.json()
      const fetchResult = {
        response, data
      }
      this.$emit('display-alert', fetchResult)

      if (response.ok) {
        setTimeout(() => this.$router.push('/'), 1000)
      }
      this.$emit('overlay-control', false)
    },
    bringUpdatePage (value) {
      this.$router.push({ path: `/update/${value}` })
    },
    async likeThisRecipe () {
      this.$emit('overlay-control', true)
      const response = await fetch('/api/ws.php?method=like&id=' + this.recipeId, {
        method: 'GET',
        cache: 'no-cache',
        credentials: 'include'
      })
      const data = await response.json()
      const fetchResult = {
        response, data
      }
      this.$emit('display-alert', fetchResult)
      if (response.ok) {
        this.liked = true
        this.cocktailDetails.thumbsUp++
      }
      this.$emit('overlay-control', false)
    }
  }
}
</script>

<style scoped>
#showIngreButton,
#showStepButton {
  width: 100%;
}
#addCommentIcon {
  float: right;
  margin-top: 2px;
}
#trashCan {
  float: right;
}
#trashCan span {
  font-size: 0.9em;
}
#heart {
  color: red;
}
.dark .list-group-item {
  background-color: #343a40;
}
</style>
