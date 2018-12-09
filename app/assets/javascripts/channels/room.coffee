App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#submit').removeAttr("disabled")
    $('#' + data.receiver_id).text data.count
    #$('#drop' + data.receiver_id).append '<p> ' + data.sender_name + ' has sent a reply!</p>'
    $('#drop' + data.receiver_id).append '<a href=https://got-crash.herokuapp.com/fixers/' + data.fixer_id + '/bids/' +
      data.bid_id + '/messages>' + data.sender_name + ' has sent a reply!</a>'
    unless data.body.blank? && data.picture.url == null
        $('.messages').append '<div class="message">' +
          '<div class=”header”><strong>' + data.sender_name + '</strong> ' + data.time + '</div>'
    unless data.body.blank?
      $('.form-body').val("")
      $('.messages').append data.body + '<br>'
    unless data.picture.url == null
      $('.messages').append '<a target="_blank" href="' + data.picture + '">View Atatchment:</a><br></div>'
    #$('.messages').scrollTop($('.messages')[0].scrollHeight)

    #<a href="https://www.w3schools.com">Visit W3Schools.com!</a>
