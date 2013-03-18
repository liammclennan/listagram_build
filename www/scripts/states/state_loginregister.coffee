[global,features,entities,validation,server,identity] = [require('../global'),require('../features'),require('../../../server/entities'),require('../validation'),require('../services/server'),require('../services/identity')]

statechart = global.statechart

statechart.addState 'loginregister',
  parentState: 'running',
  enterState: ->
    $('#body-container').html(templates.loginregister())
    $('.loginregisteritem').click ->
      statechart.sendEvent 'navigate', $(@).attr('data-state')
  exitState: ->
    $('#body-container').empty()

statechart.addState 'login', 
  parentState: 'running',
  enterState: ->
    $('#body-container').html(templates.login())
    $('form:not(.filter) :input:visible:first').focus()
    $('form#login > button').click ->
      form_data = validation.read_form $('form#login')
      auth_promise = server.authenticate(form_data.email.toLowerCase(), form_data.password)
      auth_promise.fail (err) ->
        console.log "err"
        console.dir err
        statechart.sendEvent 'alert', 'error', 'Login failed'
      auth_promise.done (data) ->
        identity.persist _.extend({password: form_data.password}, data)
        statechart.sendEvent 'navigate', 'listlist'
      false
  exitState: ->
    $('#body-container').empty()

statechart.addState 'register', 
  parentState: 'running',
  enterState: ->
    $('#body-container').html(templates.register())
    $('form:not(.filter) :input:visible:first').focus()
    validation.validate_form $('#body-container'), validation.validate_register_form, (err, form_data) ->
      if err? 
        console.dir err
        return
      register_promise = features.register(new entities.Identity form_data.email.toLowerCase(), form_data.password)
      register_promise.then ->
        statechart.sendEvent 'navigate', 'listlist'
      register_promise.fail (err) ->
        alert JSON.stringify err
      
  exitState: ->
    $('#body-container').empty()

statechart.addState 'register_with_errors',
  parentState: 'register',
  enterState: ->
    