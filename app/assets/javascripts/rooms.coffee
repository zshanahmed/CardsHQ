# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


#updateTable = (data) ->
#  $('#played_cards tbody').prepend """
#    <tr>
#      <td>#{data[0]}</td>
#      <td>#{data[1]}</td>
#    </tr>


#  """
#  return

#  $ ->
#    $('#rooms_play_card_path').on 'ajax:success', (data) ->
#      console.log("HOLA")
#      pusher = new Pusher('<%= ENV["PUSHER_KEY"] %>')
#      cluster: '<%#= ENV["PUSHER_CLUSTER"] %>'
#      encrypted: true
#      channel = pusher.subscribe('room')
#      channel.bind 'new', (data) ->
#        updateTable data
#        console.log("yes you're in")
#      return
#      console.log("yes you're in")
#    return