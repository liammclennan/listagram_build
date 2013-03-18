[identity,dbc,config] = [require('./identity'),require('dbc'),require('../../../server/config')]

base_url = config.server_url

basic_auth_before_send = (user) ->
  (xhr) ->
    xhr.setRequestHeader 'Authorization', "Basic " + btoa "#{user._id}:#{user.password}"

exports.authenticate = (username, password) ->
  $.ajax
    type: 'POST'
    dataType: 'json'
    contentType: 'application/json'
    url: "#{base_url}authenticate"
    data: JSON.stringify({username:username, password:password})

exports.get_lists = (user) ->
  $.ajax
    dataType: "json",
    beforeSend: basic_auth_before_send(user),
    url: "#{base_url}lists"

exports.get_list = (user, list_id) ->
  $.ajax
    dataType: 'json',
    beforeSend: basic_auth_before_send(user),
    url: "#{base_url}list/#{list_id}"
  
exports.register = (credentials) ->
  console.log "Registering #{JSON.stringify credentials}"
  $.ajax 
    type: "POST",
    url: "#{base_url}identity",
    contentType: 'application/json',
    data: JSON.stringify(credentials.toWire())

exports.log = (data) ->
  $.ajax
    type: "POST",
    beforeSend: basic_auth_before_send(identity.get()),
    data: JSON.stringify(data),
    contentType: 'application/json',
    url: "#{base_url}log"

exports.persist = (entity) ->
  $.ajax
    type: "POST",
    beforeSend: basic_auth_before_send(identity.get()),
    data: JSON.stringify(entity.toWire()),
    contentType: 'application/json',
    url: "#{base_url}persist/#{entity.constructor.name}"

exports.update_listitem = (listitem) ->
  $.ajax
    type: "PUT"
    beforeSend: basic_auth_before_send(identity.get())
    data: JSON.stringify(listitem)
    contentType: 'application/json'
    url: "#{base_url}listitem"