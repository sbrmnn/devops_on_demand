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


var bankName, errorMessage, iban, stripeSourceHandler;

stripeSourceHandler = function(source) {
    var externalAccountHiddenInput, form;
    form = document.getElementById('payout_identity_form');
    externalAccountHiddenInput = document.createElement('input');
    externalAccountHiddenInput.setAttribute('type', 'hidden');
    externalAccountHiddenInput.setAttribute('name', 'payout_identity[external_account]');
    externalAccountHiddenInput.setAttribute('value', source.id);
    form.appendChild(externalAccountHiddenInput);
    form.submit();
};

if ($('#iban-element').length > 0) {
    iban = elements.create('iban', {
        supportedCountries: ['SEPA']
    });
    iban.mount('#iban-element');
    errorMessage = document.getElementById('error-message');
    bankName = document.getElementById('bank-name');
    iban.on('change', function(event) {
        if (event.error) {
            errorMessage.textContent = event.error.message;
            errorMessage.classList.add('visible');
            errorMessage.classList.add('alert');
            return errorMessage.classList.add('alert-danger');
        }
        else {
            errorMessage.classList.remove('visible');
            errorMessage.classList.remove('alert');
            errorMessage.classList.remove('alert-danger');
            if (event.bankName) {
                bankName.textContent = event.bankName;
                bankName.classList.add('visible');
            } else {
                bankName.classList.remove('visible');
            }
        }
    });
}

function setOutcome(result) {
    $('.bank-account-error').remove();


    var token = result.token;

    if (result.token) {
        $('.save_bank_account_btn').text('Saved!');
        $('#payout_identity_external_account').val(token.id)
    }
    else {
        if (result.error.param === 'bank_account[routing_number]' && result.error.code === 'parameter_invalid_empty'){
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
        }
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


