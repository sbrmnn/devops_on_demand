function subscribeToMissingFieldsChannel(){
    App['missing_fields'] = App.cable.subscriptions.create({channel: 'MissingFieldsPayoutIdentityChannel', freelancer_id:  gon.freelancer_id}, {

        received: function(data) {
            data.forEach(function(element) {
                $("." + element.split('.').join('_') + "> label").append("<span class='text-danger bank-account-error px-1'>required</span>");
            });

        },

        disconnected: function() {


        },

        connected: function(){
            console.log('Subscribed to ' + 'missing fields')
        }
    });
}

