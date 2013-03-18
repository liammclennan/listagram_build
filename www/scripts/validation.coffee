[entities,_,dbc,revalidator] = [require('../../server/entities'),require('underscore'),require('dbc'),require('revalidator')]

validate_form_assertions = ($form_container, validator, callback) ->
  dbc.assert $form_container? and $form_container.length is 1, '$form_container is invalid'
  dbc.assert_is_function validator, 'validator must be a function'
  dbc.assert_is_function callback, 'callback must be a function'

read_form = ($form) ->
  target = {}
  for obj in $form.serializeArray()
    target[obj.name] = obj.value
  dbc.assert target?, 'data is invalid'
  target

validators = 
  List: (data) ->
    revalidator.validate data,
      properties:
        receiver:
          required: true
          minLength: 1
          message: 'is required'
        title:
          required: true
          minLength: 1
          message: 'is required'
        items:
          required: true
          minLength: 1
          message: 'is required'
  listitem: 
    properties:
      id:
        required: true
        minLength: 1
      description: 
        required: true
        minLength: 1
      completed:
        required: true
        type: 'boolean'


module.exports = 

  read_form: read_form

  resource: (entity) ->
    dbc.assert entity.type?, 'unable to validate a resource without a type'
    if entity.type is 'List'
      return validators.List entity

  validate_register_form: (data) ->
    revalidator.validate data,
      properties:
        email: 
          format: 'email'
          required: true

  validate_send_form: (data) ->
    validators.List data
    
  register_identity: (data) ->
    revalidator.validate data,
      properties:
        _id:
          required: true
          minLength: 1
          format: 'email'
        hash:
          required: true
          minLength: 1

  update_listitem: (listitem) ->
    revalidator.validate listitem, validators['listitem']      

  # $form_container is a dom element containing the form
  # validator is a function that validates the form data
  # callback is a node.js style callback
  validate_form: ($form_container, validator, callback) -> 
    validate_form_assertions(arguments...)
    $('form', $form_container).submit (e)->
      e.preventDefault()
      data = read_form $(@)      
      result = validator data
      unless result.valid
        $('.validation_errors_container').remove()
        $form_container.prepend(templates.errors({errors: result.errors}))
        callback 'validation error'
      else
        callback null,data
      false

