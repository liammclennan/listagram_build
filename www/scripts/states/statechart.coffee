[identity,state_loginregister,state_send,state_lists,menu] = [require('../services/identity'), require('./state_loginregister'), require('./state_send'),require('./state_lists'),require('../services/menu')]

activate_menu = ->
  menu.update()
  $('ul.nav a').click ->
    $('ul.nav li').removeClass 'active'
    $(this).closest('li').addClass 'active'
    $('.btn-navbar').click();
    if /menu-.*/.test $(this).attr('id')
      target_state = $(this).attr('id').split('-')[1]
      statechart.sendEvent 'navigate', target_state

device_ready = ->
  back_event = ->
    statechart.sendEvent 'backbutton'
  document.addEventListener("backbutton", back_event, true)

statechart.addState "running", 
  enterState: ->
    activate_menu()
    document.addEventListener("deviceready", device_ready, false);      
    unless identity.is_authenticated()
      statechart.sendEvent 'navigate', 'loginregister'
    else 
      statechart.sendEvent 'navigate', 'listlist'

  navigate: ->  
    this.goToState.apply this, arguments
    menu.update()

  alert: (level, message) ->
    $('#body-container').prepend(templates.alert({level:level, message:message}))
    setTimeout ->
      $('.alert').remove()
    , 3000

statechart.initStates('running');