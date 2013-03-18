identity = require('./identity')

module.exports = 
  update: ->
    if identity.is_authenticated()
      $('#user-info').empty().html(identity.get()._id)
      $('#menu-listlist').show()
      $('#menu-send').show()
    else
      $('#user-info').empty()
      $('#menu-listlist').hide()
      $('#menu-send').hide()