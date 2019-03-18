var stripe = Stripe('pk_test_W0NqkO9ids4x1iZNvTEMNQ8n');

$(document).on('keyup change input paste','#personal_id_number_text', function(e){
    var $this, lastCharacter, maxCount, val, valLength;
    $this = $(this);
    val = $this.val();
    lastCharacter = val[val.length - 1];
    if (isNaN(parseInt(lastCharacter))) {
        $this.val($this.val().slice(0, -1));
    }
    valLength = val.length;
    maxCount = parseInt($this.attr('maxlength'));
    if (valLength > maxCount) {
        $this.val($this.val().substring(0, maxCount));
    } else if (valLength === maxCount) {
        $('.submit').attr('disabled', true);
        stripe.createToken('pii', {
            personal_id_number: $this.val()
        }).then(function(result) {
            var errorMessage;
            errorMessage = document.getElementById('personal-number-error-message');
            if (result.error) {
                errorMessage.textContent = result.error.message;
                errorMessage.classList.add('alert');
                errorMessage.classList.add('alert-danger');
            } else {
                $('#payout_identity_legal_entity_attributes_personal_id_number').val(result.token.id);
                errorMessage.classList.remove('alert');
                errorMessage.classList.remove('alert-danger');
            }
            $('.submit').attr('disabled', false);
        });
    }
});

function setOutcome(result) {
    $('.bank-account-error').remove();


    var token = result.token;

    if (result.token) {
        $('.save_bank_account_btn').text('Saved!');
        $('#payout_identity_external_account').val(token.id)
    }else if(result.error.param === 'bank_account[routing_number]' && result.error.code === 'parameter_invalid_empty'){
        if ($('#bank_routing_number').length > 0){
            $('#bank_routing_number').siblings("label").append("<span class='text-danger bank-account-error px-1'>can\'t be blank</span>");
        }else if($('#transit_number').length > 0 && $('#institutional_number').length > 0){
            $('#transit_number').siblings("label").append("<span class='text-danger bank-account-error px-1'>can\'t be blank</span>");
            $('#institutional_number').siblings("label").append("<span class='text-danger bank-account-error px-1'>can\'t be blank</span>");
        }
    }else if (result.error.param === 'bank_account[account_number]' && result.error.code === 'parameter_invalid_empty'){
      $('#checking_account_number').siblings("label").append("<span class='text-danger bank-account-error px-1'>can\'t be blank</span>");
    }else if(result.error.param === "bank_account[account_holder_type]" && result.error.type === 'invalid_request_error'){
      $('#account_type').siblings("label").append("<span class='text-danger bank-account-error px-1'>can\'t be blank</span>");
    }else if (result.error.param === 'bank_account[account_number]' && result.error.code === 'account_number_invalid'){
      $('#checking_account_number').siblings("label").append("<span class='text-danger bank-account-error px-1'>invalid number</span>");
    }
}

function externalAccountToken(){
    var country = $('#payout_identity_legal_entity_attributes_address_country').val();
    var bankAccountParams = {
        country: country,
        currency: $('#bank_account_currency').val()   ,
        account_number: $('#checking_account_number').val().trim(),
        account_holder_name: $('#account_name').val().trim(),
        account_holder_type: $('#account_type').val().trim()
    };
    var routingNumber = $('#bank_routing_number');
    if (routingNumber.length > 0) {
        bankAccountParams['routing_number'] = routingNumber.val();
    }
    var transitNumber = $('#transit_number');
    var institutional_number = $('#institutional_number');
    if (transitNumber.length > 0 && institutional_number.length > 0){
        bankAccountParams['routing_number'] = transitNumber.val().trim() + institutional_number.val().trim()
    }
    stripe.createToken('bank_account', bankAccountParams).then(setOutcome);
}


$(document).on('change', '#payout_identity_legal_entity_attributes_type', function(e){
    var individualTags = $('.individual-id-tags');
    var businessTags = $('.business-id-tags');
    if (this.value === 'individual') {
        individualTags.removeClass('d-none');
        businessTags.addClass('d-none');
    }
    else if(this.value === 'company'){
        businessTags.removeClass('d-none');
        individualTags.addClass('d-none');
    }
    else{
        businessTags.addClass('d-none');
        individualTags.addClass('d-none');
    }
});



$(document).on('change', '#payout_identity_legal_entity_attributes_entity_type' ,function() {
    if (this.value === 'individual') {
        $('.individual-id-tags').removeClass('d-none');
        $('.business-id-tags').addClass('d-none');
    }
    if (this.value === 'company') {
        $('.business-id-tags').removeClass('d-none');
        $('.individual-id-tags').addClass('d-none');
        if (this.value === '') {
            $('.business-id-tags').addClass('d-none');
            $('.individual-id-tags').addClass('d-none');
        }
    }
});


function getEntityTypeFields(){
    var value = $('#payout_identity_legal_entity_attributes_entity_type').val();
    if (value === 'individual') {
        $('.individual-id-tags').removeClass('d-none');
        $('.business-id-tags').addClass('d-none');
    }
    if (value === 'company') {
        $('.business-id-tags').removeClass('d-none');
        $('.individual-id-tags').addClass('d-none');
        if (value === '') {
            $('.business-id-tags').addClass('d-none');
            $('.individual-id-tags').addClass('d-none');
        }
    }
}


var elements = stripe.elements();
var card = elements.create('card', {hidePostalCode: true});

// Custom styling can be passed to options when creating an Element.
// (Note that this demo uses a wider set of styles than the guide below.)
var style = {
    base: {
        color: '#32325d',
        fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
        fontSmoothing: 'antialiased',
        fontSize: '16px',
        '::placeholder': {
            color: '#aab7c4'
        }
    },
    invalid: {
        color: '#fa755a',
        iconColor: '#fa755a'
    }
};


function mountCreditCardElement(jobform) {
// Create an instance of the card Element.
 // Add an instance of the card Element into the `card-element` <div>.
    card.unmount();
    card.mount(jobform + ' > .card > .container > #payment-form > div.form-row.mt-1 > div:nth-child(2) > div.card-element.form-control');

// Handle real-time validation errors from the card Element.
    card.addEventListener('change', function (event) {
        var displayError = document.getElementById('card-errors');
        if (event.error) {
            displayError.textContent = event.error.message;
        } else {
            displayError.textContent = '';
        }
    });

// Handle form submission.
    var form = document.getElementById('payment-form');
    form.addEventListener('submit', function (event) {
        event.preventDefault();
        event.stopPropagation();

        var custData = {
            name: $('#credit-card-name').val(),
            address_line1: $('#credit-card-line1').val(),
            address_line2: $('#credit-card-line2').val(),
            address_city: $('#credit-card-city').val(),
            address_state: $('#credit-card-state').val(),
            address_zip: $('#credit-card-zip').val(),
            address_country: $('#credit-card-country').val()
        };

        stripe.createToken(card, custData).then(function (result) {
            if (result.error) {
                // Inform the user if there was an error.
                var errorElement = document.getElementById('card-errors');
                errorElement.textContent = result.error.message;
            } else {
                // Send the token to your server.
                stripeTokenHandler(result.token);
            }
        });
    });

}


function stripeTokenHandler(token) {
    // Insert the token ID into the form so it gets submitted to the server
    var hiddenInput = document.getElementById('credit-card-token');

    hiddenInput.setAttribute('value', token.id);

    $.ajax({
        type: 'POST',
        url: '/users/'+ gon.current_user_id +'/credit_cards',
        data: $('#payment-form').serialize(),
        dataType: 'script',
        async: false
    });

}


