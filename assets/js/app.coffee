socket = io.connect 'http://localhost:3700'
socket.on 'message', () ->
     console.log "socket.io received a message"

jQuery ->
  console.log "jQuery loaded"