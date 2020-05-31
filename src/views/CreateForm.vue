<template>
  <div class="container" id="createForm" :class="darkMode ? 'dark' : ''">
    <div v-if="rootIsLoggedIn" class="pb-3">
      <h5 class="pt-3">Create a recipe</h5>
      <hr>
      <ValidationObserver ref="form" v-slot="{ handleSubmit }">
        <b-form @submit.prevent="handleSubmit(onSubmit)" novalidate>
          <ValidationProvider rules="required|min:2|max:30" name="Cocktailer name" v-slot="{ valid, errors }">
            <b-form-group
              description=""
              label="Name of your cocktailer"
              label-for="cocktailerName"
            >
              <b-form-input
                id="cocktailerName"
                v-model="form.name"
                :state="errors[0] ? false : (valid ? true : null)"
                required
                trim
                placeholder="Cocktail name"
              />
            <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
            </b-form-group>
          </ValidationProvider>
          <ValidationProvider rules="required|min:15|max:600" name="Description" v-slot="{ valid, errors }">
            <label for="desc">
              <p class="mb-0">
                Description
                <span>
                  <b-icon-info-circle
                    v-b-popover.hover="'Tell us its flavour, history or something special.'"
                  />
                </span>
              </p>
            </label>
            <b-form-textarea
              id="desc"
              v-model="form.description"
              placeholder="Tell us about your cocktail"
              rows="3"
              max-rows="6"
              :state="errors[0] ? false : (valid ? true : null)"
              required
              class="mb-2"
            />
            <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
          </ValidationProvider>
          <ValidationProvider rules="required|imgReg:https://.+" name="image link" v-slot="{ valid, errors }">
            <b-form-group
              description=""
            >
            <label for="imgUrl">
              <p class="mb-0">
                Image
                <span>
                  <b-icon-info-circle
                    v-b-popover.hover="'Free upload image site: Flickr, SmugMug, Imgur'"
                  />
                </span>
              </p>
            </label>
              <b-form-input
                id="imgUrl"
                v-model="form.imgUrl"
                :state="errors[0] ? false : (valid ? true : null)"
                type="url"
                required
                trim
                placeholder="Paste an uploaded img link here"
              />
              <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
            </b-form-group>
          </ValidationProvider>
          <!-- Ingredients start here -->
          <h5 class="mt-5">
            Ingredients
            <span>
              <b-icon-info-circle
                v-b-popover.hover.top="'MAX. 15 ingredients. What ingredients include in the cocktail?'"
              />
            </span>
          </h5>
          <hr>
          <div id="ingreOne">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="required|numeric|between:1,500" name="Quantity1" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity1"
                  >
                    <b-form-input
                      id="quantity1"
                      v-model="form.quantity[0]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="required" name="Measurement1" v-slot="{ valid, errors }">
                  <label for="measurement1">Measurement</label>
                  <b-form-select
                    id="measurement1"
                    v-model="form.measurement[0]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="required|min:2|max:50" name="Item1" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item1"
                  >
                    <b-form-input
                      id="item1"
                      v-model="form.item[0]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- ingre2 -->
          <div id="ingre2">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="required|numeric|between:1,500" name="Quantity2" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity2"
                  >
                    <b-form-input
                      id="quantity2"
                      v-model="form.quantity[1]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="required" name="Measurement2" v-slot="{ valid, errors }">
                  <label for="measurement2">Measurement</label>
                  <b-form-select
                    id="measurement2"
                    v-model="form.measurement[1]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="required|min:2|max:50" name="Item2" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item2"
                  >
                    <b-form-input
                      id="item2"
                      v-model="form.item[1]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- end of ingre 2 -->
          <div id="ingre3" v-if="showIngreIndex >= 3">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="numeric|between:1,500" name="Quantity3" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity3"
                  >
                    <b-form-input
                      id="quantity3"
                      v-model="form.quantity[2]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="" name="Measurement3" v-slot="{ valid, errors }">
                  <label for="measurement3">Measurement</label>
                  <b-form-select
                    id="measurement3"
                    v-model="form.measurement[2]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="min:2|max:50" name="Item3" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item3"
                  >
                    <b-form-input
                      id="item3"
                      v-model="form.item[2]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- end ingre 3 -->
          <div id="ingre4" v-if="showIngreIndex >= 4">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="numeric|between:1,500" name="Quantity4" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity4"
                  >
                    <b-form-input
                      id="quantity4"
                      v-model="form.quantity[3]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="" name="Measurement4" v-slot="{ valid, errors }">
                  <label for="measurement4">Measurement</label>
                  <b-form-select
                    id="measurement4"
                    v-model="form.measurement[3]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="min:2|max:50" name="Item4" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item4"
                  >
                    <b-form-input
                      id="item4"
                      v-model="form.item[3]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- end ingre 4 -->
          <div id="ingre5" v-if="showIngreIndex >= 5">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="numeric|between:1,500" name="Quantity5" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity5"
                  >
                    <b-form-input
                      id="quantity5"
                      v-model="form.quantity[4]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="" name="Measurement5" v-slot="{ valid, errors }">
                  <label for="measurement5">Measurement</label>
                  <b-form-select
                    id="measurement5"
                    v-model="form.measurement[4]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="min:2|max:50" name="Item5" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item5"
                  >
                    <b-form-input
                      id="item5"
                      v-model="form.item[4]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- end ingre 5 -->
          <div id="ingre6" v-if="showIngreIndex >= 6">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="numeric|between:1,500" name="Quantity6" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity6"
                  >
                    <b-form-input
                      id="quantity6"
                      v-model="form.quantity[5]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="" name="Measurement6" v-slot="{ valid, errors }">
                  <label for="measurement6">Measurement</label>
                  <b-form-select
                    id="measurement6"
                    v-model="form.measurement[5]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="min:2|max:50" name="Item6" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item6"
                  >
                    <b-form-input
                      id="item6"
                      v-model="form.item[5]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- end ingre 6 -->
          <div id="ingre7" v-if="showIngreIndex >= 7">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="numeric|between:1,500" name="Quantity7" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity7"
                  >
                    <b-form-input
                      id="quantity7"
                      v-model="form.quantity[6]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="" name="Measurement7" v-slot="{ valid, errors }">
                  <label for="measurement7">Measurement</label>
                  <b-form-select
                    id="measurement7"
                    v-model="form.measurement[6]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="min:2|max:50" name="Item7" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item7"
                  >
                    <b-form-input
                      id="item7"
                      v-model="form.item[6]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- end ingre 7 -->
          <div id="ingre8" v-if="showIngreIndex >= 8">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="numeric|between:1,500" name="Quantity8" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity8"
                  >
                    <b-form-input
                      id="quantity8"
                      v-model="form.quantity[7]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="" name="Measurement8" v-slot="{ valid, errors }">
                  <label for="measurement8">Measurement</label>
                  <b-form-select
                    id="measurement8"
                    v-model="form.measurement[7]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="min:2|max:50" name="Item8" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item8"
                  >
                    <b-form-input
                      id="item8"
                      v-model="form.item[7]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- end ingre 8 -->
          <div id="ingre9" v-if="showIngreIndex >= 9">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="numeric|between:1,500" name="Quantity9" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity9"
                  >
                    <b-form-input
                      id="quantity9"
                      v-model="form.quantity[8]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="" name="Measurement9" v-slot="{ valid, errors }">
                  <label for="measurement9">Measurement</label>
                  <b-form-select
                    id="measurement9"
                    v-model="form.measurement[8]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="min:2|max:50" name="Item9" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item9"
                  >
                    <b-form-input
                      id="item9"
                      v-model="form.item[8]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- end ingre 9 -->
          <div id="ingre10" v-if="showIngreIndex >= 10">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="numeric|between:1,500" name="Quantity10" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity10"
                  >
                    <b-form-input
                      id="quantity10"
                      v-model="form.quantity[9]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="" name="Measurement10" v-slot="{ valid, errors }">
                  <label for="measurement10">Measurement</label>
                  <b-form-select
                    id="measurement10"
                    v-model="form.measurement[9]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="min:2|max:50" name="Item10" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item10"
                  >
                    <b-form-input
                      id="item10"
                      v-model="form.item[9]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- end ingre 10 -->
          <div id="ingre11" v-if="showIngreIndex >= 11">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="numeric|between:1,500" name="Quantity11" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity11"
                  >
                    <b-form-input
                      id="quantity11"
                      v-model="form.quantity[10]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="" name="Measurement11" v-slot="{ valid, errors }">
                  <label for="measurement11">Measurement</label>
                  <b-form-select
                    id="measurement11"
                    v-model="form.measurement[10]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="min:2|max:50" name="Item11" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item11"
                  >
                    <b-form-input
                      id="item11"
                      v-model="form.item[10]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- end ingre 11 -->
          <div id="ingre12" v-if="showIngreIndex >= 12">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="numeric|between:1,500" name="Quantity12" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity12"
                  >
                    <b-form-input
                      id="quantity12"
                      v-model="form.quantity[11]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="" name="Measurement12" v-slot="{ valid, errors }">
                  <label for="measurement12">Measurement</label>
                  <b-form-select
                    id="measurement12"
                    v-model="form.measurement[11]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="min:2|max:50" name="Item12" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item12"
                  >
                    <b-form-input
                      id="item12"
                      v-model="form.item[11]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- end ingre 12 -->
          <div id="ingre13" v-if="showIngreIndex >= 13">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="numeric|between:1,500" name="Quantity13" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity13"
                  >
                    <b-form-input
                      id="quantity13"
                      v-model="form.quantity[12]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="" name="Measurement13" v-slot="{ valid, errors }">
                  <label for="measurement13">Measurement</label>
                  <b-form-select
                    id="measurement13"
                    v-model="form.measurement[12]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="min:2|max:50" name="Item13" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item13"
                  >
                    <b-form-input
                      id="item13"
                      v-model="form.item[12]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- end ingre 13 -->
          <div id="ingre14" v-if="showIngreIndex >= 14">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="numeric|between:1,500" name="Quantity14" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity14"
                  >
                    <b-form-input
                      id="quantity14"
                      v-model="form.quantity[13]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="" name="Measurement14" v-slot="{ valid, errors }">
                  <label for="measurement14">Measurement</label>
                  <b-form-select
                    id="measurement14"
                    v-model="form.measurement[13]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="min:2|max:50" name="Item14" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item14"
                  >
                    <b-form-input
                      id="item14"
                      v-model="form.item[13]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- end ingre 14 -->
          <div id="ingre15" v-if="showIngreIndex >= 15">
            <b-row>
              <b-col cols="8">
                <ValidationProvider rules="numeric|between:1,500" name="Quantity15" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Quantity"
                    label-for="quantity15"
                  >
                    <b-form-input
                      id="quantity15"
                      v-model="form.quantity[14]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Quantity needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col cols="4">
                <ValidationProvider rules="" name="Measurement15" v-slot="{ valid, errors }">
                  <label for="measurement15">Measurement</label>
                  <b-form-select
                    id="measurement15"
                    v-model="form.measurement[14]"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :options="options"
                  />
                  <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row>
              <b-col>
                <ValidationProvider rules="min:2|max:50" name="Item15" v-slot="{ valid, errors }">
                  <b-form-group
                    description=""
                    label="Item"
                    label-for="item15"
                  >
                    <b-form-input
                      id="item15"
                      v-model="form.item[14]"
                      :state="errors[0] ? false : (valid ? true : null)"
                      type="text"
                      required
                      trim
                      placeholder="Item needed"
                    />
                    <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </div>
          <!-- End ingredients -->
          <!-- show ingredients button -->
          <div class="mb-5">
            <a @click="showIngre" v-if="showIngreIndex < 15"><strong>Add more ingredients</strong></a>
            <a v-if="showIngreIndex >= 15"><strong>Max. 15 ingredients</strong></a>
          </div>
          <!-- steps -->
          <h5>
            Steps
            <span>
              <b-icon-info-circle
                v-b-popover.hover.top="'Max. 5 steps. Please add one at a time.'"
              />
            </span>
          </h5>
          <hr>
          <div id="step1">
            <ValidationProvider rules="required|min:15|max:200" name="Step1" v-slot="{ valid, errors }">
              <label for="step1">
                Step1
              </label>
              <b-form-textarea
                id="step1"
                v-model="form.step[0]"
                placeholder="How do we handle the ingredients?"
                rows="3"
                max-rows="6"
                :state="errors[0] ? false : (valid ? true : null)"
                required
                class="mb-2"
              />
              <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
            </ValidationProvider>
          </div>
          <!-- end step 1 -->
          <div v-if="stepIndex >= 2" id="step2">
            <ValidationProvider rules="min:15|max:200" name="Step2" v-slot="{ valid, errors }">
              <label for="step2">
                Step2
              </label>
              <b-form-textarea
                id="step2"
                v-model="form.step[1]"
                placeholder="How do we handle the ingredients?"
                rows="3"
                max-rows="6"
                :state="errors[0] ? false : (valid ? true : null)"
                required
                class="mb-2"
              />
              <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
            </ValidationProvider>
          </div>
          <!-- end step 2 -->
          <div v-if="stepIndex >= 3" id="step3">
            <ValidationProvider rules="min:15|max:200" name="Step3" v-slot="{ valid, errors }">
              <label for="step3">
                Step3
              </label>
              <b-form-textarea
                id="step3"
                v-model="form.step[2]"
                placeholder="How do we handle the ingredients?"
                rows="3"
                max-rows="6"
                :state="errors[0] ? false : (valid ? true : null)"
                required
                class="mb-2"
              />
              <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
            </ValidationProvider>
          </div>
          <!-- end step 3 -->
          <div v-if="stepIndex >= 4" id="step4">
            <ValidationProvider rules="min:15|max:200" name="Step4" v-slot="{ valid, errors }">
              <label for="step4">
                Step4
              </label>
              <b-form-textarea
                id="step4"
                v-model="form.step[3]"
                placeholder="How do we handle the ingredients?"
                rows="3"
                max-rows="6"
                :state="errors[0] ? false : (valid ? true : null)"
                required
                class="mb-2"
              />
              <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
            </ValidationProvider>
          </div>
          <!-- end step 4 -->
          <div v-if="stepIndex >= 5" id="step5">
            <ValidationProvider rules="min:15|max:200" name="Step5" v-slot="{ valid, errors }">
              <label for="step5">
                Step5
              </label>
              <b-form-textarea
                id="step5"
                v-model="form.step[4]"
                placeholder="How do we handle the ingredients?"
                rows="3"
                max-rows="6"
                :state="errors[0] ? false : (valid ? true : null)"
                required
                class="mb-2"
              />
              <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
            </ValidationProvider>
          </div>
          <!-- end step 5 -->
          <div class="mb-5">
            <a v-if="stepIndex <5" @click="showStep"><strong>Add more steps</strong></a>
            <a v-if="stepIndex >= 5"><strong>Max. 5 steps</strong></a>
          </div>
          <!-- End Form -->
          <hr>
          <b-button type="submit" :variant="darkMode ? 'info' : 'primary'" block>Create!</b-button>
        </b-form>
      </ValidationObserver>
    </div>
    <div v-if="!rootIsLoggedIn">
      <p>Seems like you are not logged in.</p>
      <p>
        Would you like to
        <b-button @click="controlModal('login')" variant="link" id="loginLink" :class="darkMode ? 'light' : ''">
          <b><i>LOGIN?</i></b>
        </b-button>
      </p>
    </div>
  </div>
</template>

<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
export default {
  name: 'CreateForm',
  components: {
    ValidationObserver,
    ValidationProvider
  },
  props: {
    rootIsLoggedIn: Boolean,
    darkMode: Boolean
  },
  data () {
    return {
      form: {
        name: '',
        description: '',
        imgUrl: '',
        quantity: [],
        measurement: [],
        item: [],
        step: []
      },
      options: [
        { value: '1', text: 'ml' },
        { value: '2', text: 'dash(es)' },
        { value: '3', text: 'oz' },
        { value: '4', text: 'drop(s)' },
        { value: '5', text: 'cup(s)' },
        { value: '6', text: 'slice(s)' },
        { value: '7', text: 'fresh' },
        { value: '8', text: 'cube(s)' },
        { value: '9', text: 'tsp' },
        { value: '10', text: 'tbsp' },
        { value: '11', text: 'bottle(s)' },
        { value: '12', text: 'can(s)' },
        { value: '13', text: 'pinch' }
      ],
      showIngreIndex: 2,
      stepIndex: 1
    }
  },
  methods: {
    onSubmit () {
      this.$refs.form.validate().then(success => {
        if (!success) {
          return
        }
        alert('Form has been submitted!')
        this.createRecipe()
      })
    },
    async createRecipe () {
      console.log(this.form)
      const response = await fetch('/api/ws.php?method=crecipe', {
        method: 'POST',
        cache: 'no-cache',
        credentials: 'include',
        body: JSON.stringify(this.form)
      })
      const data = await response.json()
      console.log(response)
      console.log(data)

      const fetchResult = {
        response, data
      }
      console.log(fetchResult)
      this.$emit('display-alert', fetchResult)

      // reset value
      this.form = {
        name: '',
        description: '',
        imgUrl: '',
        quantity: [],
        measurement: [],
        item: [],
        step: []
      }

      this.showIngreIndex = 2
      this.stepIndex = 1
      this.$nextTick(() => {
        this.$refs.form.reset()
      })
    },
    showIngre () {
      if (this.showIngreIndex < 16) {
        this.showIngreIndex++
      }
    },
    showStep () {
      if (this.stepIndex < 5) {
        this.stepIndex++
      }
    },
    controlModal (modal) {
      this.$emit('control-modal', modal)
    }
  }
}
</script>

<style scoped>
input[type="text"],
textarea.form-control,
input[type="url"],
select.custom-select {
  background-color: rgb(233, 233, 233);
}
.form-control::placeholder {
  color: rgb(128, 128, 128);
}
#loginLink {
  color: black;
}
.dark #inputLiveFeedback {
  color: yellow;
}
.light#loginLink b {
  color: white;
}
</style>
