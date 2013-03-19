[entities,validation,identity,server] = [require('../../../server/entities'),require('../validation'),require('../services/identity'),require('../services/server')]

statechart.addState 'send',
  parentState: 'running',
  enterState: ->
    $('#body-container').html(templates.send())
    $('.back-button').addClass('foundicon-left-arrow')
    validation.validate_form $('#body-container'), validation.validate_send_form, (err, form_data) ->
      if err?
        console.dir err
        return
      list = new entities.List(form_data.receiver, identity.get().email(), form_data.title, form_data.items)
      send_promise = server.persist list
      send_promise.done (data, textStatus, jqXHR) ->
        statechart.sendEvent 'navigate', 'listlist'
        statechart.sendEvent 'alert', 'success', "#{form_data.title} sent to #{form_data.receiver}"
      send_promise.fail (jqXHR, textStatus, errorThrown) ->
        alert "send_promise failed #{JSON.stringify jqXHR}"
  exitState: ->
    $('#body-container').empty()
    $('.back-button').removeClass('foundicon-left-arrow')

