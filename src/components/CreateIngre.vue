<template>
  <div>
    <div>
      <b-row>
        <b-col cols="8">
          <ValidationProvider rules="numeric|between:1,500" :name="quantityIndex" v-slot="{ valid, errors }">
            <b-form-group
              description=""
              label="Quantity"
              :label-for="quantityIndex"
            >
              <b-form-input
                :id="quantityIndex"
                :v-model="quantityIndex"
                :state="errors[0] ? false : (valid ? true : null)"
                type="text"
                trim
                placeholder="Quantity needed"
              />
              <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col cols="4">
          <ValidationProvider rules="" :name="measurementIndex" v-slot="{ valid, errors }">
            <label :for="measurementIndex">Measurement</label>
            <b-form-select
              v-model="itemIndex"
              :id="measurementIndex"
              :state="errors[0] ? false : (valid ? true : null)"
              :options="options"
            />
            <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
          </ValidationProvider>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <ValidationProvider rules="min:2|max:50" name="itemIndex" v-slot="{ valid, errors }">
            <b-form-group
              description=""
              label="Item"
              :label-for="itemIndex"
            >
              <b-form-input
                :id="itemIndex"
                :state="errors[0] ? false : (valid ? true : null)"
                type="text"
                v-model="itemIndex"
                trim
                placeholder="Item needed"
              />
              <b-form-invalid-feedback id="inputLiveFeedback">{{ errors[0] }}</b-form-invalid-feedback>
            </b-form-group>
          </ValidationProvider>
        </b-col>
      </b-row>
    </div>
  </div>
</template>

<script>
import { ValidationProvider } from 'vee-validate'

export default {
  name: 'CreateIngre',
  components: {
    ValidationProvider
  },
  data () {
    return {
      myIndex: '',
      quantityIndex: '',
      measurementIndex: '',
      itemIndex: '',
      options: [
        { value: '', text: 'select' },
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
      ingreObj: ''
    }
  },
  props: {
    showIngreIndex: Number,
    showIngreArrayItem: Object,
    form: Object,
    ingreArray: Array,
    itemArray: Array,
    measurementArray: Array
  },
  created () {
    this.myIndex = this.showIngreArrayItem.id
    this.itemIndex = 'item' + this.showIngreArrayItem.id
    this.measurementIndex = 'measurement' + this.showIngreArrayItem.id
    this.quantityIndex = 'quantity' + this.showIngreArrayItem.id
  }
}
</script>
