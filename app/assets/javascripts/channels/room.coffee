App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#submit').removeAttr("disabled")
    $('#receiver_' + data.receiver_id).text data.count
    $('#drop' + data.receiver_id).append '<p><a href=https://got-crash.herokuapp.com/fixers/' + data.fixer_id + '/bids/' +
      data.bid_id + '/messages>' + data.sender_name + ' has sent a reply!</a></p>'
    unless data.body.blank?
      $('.simplebar-content').append '<div class="message-header">' + '<img class="img-circle small-image" src="'+ data.user_picture + '"><div class="message-name"><strong>' + data.sender_name + '</strong><div class="message-time">' + data.time + '</div></div></div>'
      $('.form-body').val("")
      $('.simplebar-content').append '<div class="message-body">' + data.body + '</div>'
    unless data.picture == null
      $('.simplebar-content').append '<div class="message-attachment"><a target="_blank" href="' + data.picture + '">View Atatchment</a></div>'
    #$('.messages').scrollTop($('.messages')[0].scrollHeight)
    #<a href="https://www.w3schools.com">Visit W3Schools.com!</a>
