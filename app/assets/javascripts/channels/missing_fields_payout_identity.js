function subscribeToMissingFieldsChannel(){
    App['missing_fields'] = App.cable.subscriptions.create({channel: 'MissingFieldsPayoutIdentityChannel', freelancer_id:  gon.freelancer_id}, {

        received: function(data) {
            displayMissingFields(data)
        },

        disconnected: function() {


        },

        connected: function(){
            console.log('Subscribed to ' + 'missing fields')
        }
    });
}

