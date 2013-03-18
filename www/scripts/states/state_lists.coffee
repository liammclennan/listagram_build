[global,features,_,server] = [require('../global'),require('../features'),require('underscore'),require('../services/server')]

statechart.addState 'listlist', 
  parentState: 'running',
  enterState: ->
    lists = features.lists_list()
    lists.then (data)->
      $('#body-container').append(templates.listlist({lists:data}))
      $('.listlistitem').click ->
        id = $(@).attr 'data-id'
        statechart.getState('list').setData 'id', id
        statechart.sendEvent 'navigate', 'list'
    lists.fail (err)->
      console.dir err
      alert JSON.stringify err  
  exitState: ->
    $('#body-container').empty()

statechart.addState 'list',
  parentState: 'running',
  enterState: (id)->
    id = statechart.getState('list').getData 'id'
    $('.back-button').addClass('foundicon-left-arrow')
    list_deferred = features.list id
    render_bind = (list) ->
      $('#body-container').empty()
      $('#body-container').html(templates.list({items:list.items}))
      $('.listitem').click ->
        $button = $ @
        $checkbox = $('input[type=checkbox]', $button)
        clicked_item = _.find list.items, (i) ->
          $button.text() is " #{i.description}"
        clicked_item.completed = not clicked_item.completed
        $checkbox.prop('checked', clicked_item.completed)
        if clicked_item.completed
          $button.addClass 'disabled'
        else
          $button.removeClass 'disabled'
        update_item_d = server.update_listitem clicked_item
        update_item_d.fail (err) ->
          console.dir err

    list_deferred.done render_bind
    list_deferred.fail (err) ->
      console.dir err
      alert JSON.stringify err  
  exitState: ->
    $('#body-container').empty()
    $('.back-button').removeClass('foundicon-left-arrow')
