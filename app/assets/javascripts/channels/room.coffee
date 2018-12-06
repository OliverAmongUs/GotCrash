App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    #console.log data['content']
    unless data.body.blank?
      console.log "DID I GET HERE"
      $('.form-body').val("")
      console.log "MADE IT AFTER FORM BODY"
        #$('.messages').append '<div class="message">' +
        #  '<div class=”header”><strong>' + data.sender_name + '</strong> ' + data.time + '</div>' +
        #data.body + '</div>'
        #$('.messages').scrollTop($('.messages')[0].scrollHeight)

        #$('.messages').append '<div class="new-message">' +
      #  '<div class="message-user">' + data.sender + ":" + '</div>' +
      #  '<div class="message-content">' + data.content + '</div>' + '</div>'
    # Called when there's incoming data on the websocket for this channel
