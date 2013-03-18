[global,entities,_] = [require('../global'),require('../../../server/entities'),require('underscore')]

global.state ?= {}
identity = global.state.identity ?= null

exports.is_authenticated = ->
  localStorage.getItem('identity')?

exports.get = ->
  data = JSON.parse localStorage.getItem 'identity'
  new entities.Identity.build data

exports.persist = (i) ->
  localStorage.setItem 'identity', JSON.stringify i
