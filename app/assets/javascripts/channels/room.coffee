App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#submit').removeAttr("disabled")
    console.log (data.sender_name)
    console.log (data.receiver_name)
    console.log ('#' + data.sender_name)
    $('#' + data.sender_name).append '<div> <p>' + data.count + '</p></div>'
    unless data.body.blank? && data.picture.url == null
        $('.messages').append '<div class="message">' +
          '<div class=”header”><strong>' + data.sender_name + '</strong> ' + data.time + '</div>'
    unless data.body.blank?
      $('.form-body').val("")
      $('.messages').append data.body + '<br>'
    unless data.picture.url == null
      $('.messages').append '<a target="_blank" href="' + data.picture + '">View Atatchment:</a></div>'
    #$('.messages').scrollTop($('.messages')[0].scrollHeight)




        #<a target="_blank" href="/uploads/message/37/turbolinks_garbage.png">View Atatchment:</a>
