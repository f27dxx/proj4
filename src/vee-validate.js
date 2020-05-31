import {
  required,
  confirmed,
  email,
  // eslint-disable-next-line
  alpha_num,
  min,
  max,
  between,
  numeric
} from 'vee-validate/dist/rules'
import { extend } from 'vee-validate'

extend('required', {
  ...required,
  message: '{_field_} is required'
})

extend('email', {
  ...email,
  message: 'This field must be a valid email'
})

extend('confirmed', {
  ...confirmed,
  message: 'This field confirmation does not match'
})

extend('alphaNum', {
  // eslint-disable-next-line
  ...alpha_num,
  message: '{_field_} can only contain numbers and letters'
})

extend('min', {
  ...min,
  message: 'Must not less than {length} characters',
  params: ['length']
})

extend('max', {
  ...max,
  message: 'Must not more than {length} characters',
  params: ['length']
})

extend('between', {
  ...between,
  message: '{_field_} must between {min} and {max}',
  params: ['min', 'max']
})

extend('imgReg', {
  validate (value, args) {
    const patt = new RegExp(args)
    return patt.test(value)
  },
  message: 'Not a valid {_field_}, must start with https://'
})

extend('numeric', {
  ...numeric,
  message: '{_field_} must be numeric'
})

extend('reg', {
  validate (value, args) {
    const patt = new RegExp(args)
    return patt.test(value)
  },
  message: 'Not a valid {_field_}'
})
