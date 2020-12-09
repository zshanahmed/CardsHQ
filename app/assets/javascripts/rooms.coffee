# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


updateTable = (data) ->
  $('#played_cards tbody').append """
    <tr>
      <td>#{data[0]}</td>
      <td>#{data[1]}</td>
    </tr>


  """
  return

  $ ->
    $('#btn-play').on 'ajax:success', (data) ->
      pusher = new Pusher('<%= ENV["PUSHER_KEY"] %>')
      cluster: '<%= ENV["PUSHER_CLUSTER"] %>'
      encrypted: true
      channel = pusher.subscribe('room')
      channel.bind 'new', (data) ->
        updateTable data
      return
    return