function subscribeToRoom(chatroomId){
    App['room' + chatroomId] = App.cable.subscriptions.create({channel: 'RoomChannel', chatroom_id: chatroomId}, {
        received: function(data) {
            return  appendMessageHistroy(data['body'], new Date(data['created_at']), data['user_id']);
        },
        speak: function(message) {
            return this.perform('speak', {
                body: message
            });
        }
    });
}


$(window).on('load', function() {
    $('.chat_room_id').each(function( ) {
        subscribeToRoom($( this ).text());
    });
});







