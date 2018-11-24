function subscribeToRoom(chatroomId){
    var roomName = 'room' + chatroomId;
    App[roomName] = App.cable.subscriptions.create({channel: 'RoomChannel', chatroom_id: chatroomId}, {

        received: function(data) {
            var output = null;
            if ($("#chatroom_"+ chatroomId + "> .active_chat").length > 0) {
                output = appendMessageHistory(data['body'], new Date(data['created_at']), data['user_id']);
            }
            return output
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







