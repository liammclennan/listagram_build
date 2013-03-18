[identity,server] = [require('./services/identity'),require('./services/server')]

module.exports = 

  register: (i) ->
    dfd = server.register i
    dfd.done ->
      identity.persist i

  list: (list_id) ->
    me = identity.get()
    server.get_list me, list_id

  lists_list: ->
    me = identity.get()
    server.get_lists me

  