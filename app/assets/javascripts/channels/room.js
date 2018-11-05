function subscribeToRoom(chatroomId){
    var roomName = 'room' + chatroomId;
    App[roomName] = App.cable.subscriptions.create({channel: 'RoomChannel', chatroom_id: chatroomId}, {
        received: function(data) {
            return  appendMessageHistroy(data['body'], new Date(data['created_at']), data['user_id']);
        },

        speak: function(message) {
            return this.perform('speak', {
                body: message
            });
        },
        disconnected: function() {
            setTimeout(function(){
                $("#connection-error-alert").show();
            }, 2000);
            
        },
        connected: function(){
            $("#connection-error-alert").hide();
           console.log('Subscribed to ' + roomName)
        }
    });
}



$(document).on('turbolinks:load', function() {

    if ( $("#chatbox").length ) {
     $('.chat_room_id').each(function( ) {
         subscribeToRoom($( this ).text());
      });
    }
});









