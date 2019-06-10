// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//



//= require cloudinary
//= require payment_processor

//= require_tree .

$.ajaxSetup({
    beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $("meta[name='csrf-token']").attr('content'));
    }
});



$.fn.scrollToBottom = function() {
    return this.each(function (i, element) {
        $(element).scrollTop($(element)[0].scrollHeight);
    });
};

var ua = navigator.userAgent;

// iPhone has different click event than browsers

var click_event = (ua.match(/iPad/i) || ua.match(/iPhone/i)) ? "touchstart" : "click";

var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
        }
    }
};

function formatAMPM(date) {
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var ampm = hours >= 12 ? 'pm' : 'am';
    hours = hours % 12;
    hours = hours ? hours : 12; // the hour '0' should be '12'
    minutes = minutes < 10 ? '0'+minutes : minutes;
    var strTime = hours + ':' + minutes + ' ' + ampm;
    return strTime;
}

function preSelectChatroom(){
    if (getUrlParameter('respond_to_room') !== undefined){
        $('#messages-tab').trigger('click');
        var roomName = '#' + getUrlParameter('respond_to_room') + '_name';
        $(roomName).trigger(click_event);
        return true
    }
    return false;
}

var months = [ "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December" ];


$( document ).ready(function() {
    init();
});


function init() {
    getSelectedPill();
    if (gon.current_user_id){
        getEntityTypeFields();
    }

    getFeaturedEngineers();
}

function getFeaturedEngineers(){

        $.ajax({
            type: 'GET',
            url: '/freelancer_searches',
            data: {freelancer_searches:{value: ''}} ,
            dataType: 'script',
            async: true
        });


}


function displayMissingFields(data){
    $('.bank-account-error').remove();
    data.forEach(function(element) {
        $("." + element.split('.').join('_') + "> label").append("<span class='text-danger bank-account-error px-1'>required</span>");
    });
}


function creditCardValueOrError(className){
    var val = $(className).val().trim();
    if (val || className === '.credit-card-line2'){
      return val
    }else {
        $(className).siblings('label').append("<span class='text-danger label-error-msgs ml-1'>can\'t be blank</span>")
        return ""
    }
}

function createJob(e){
    e.preventDefault();
    $(".card-errors").empty();
    $(".credit-card-error").addClass('d-none');
    $(".label-error-msgs").remove();
    if ($(e.target).find(".different-card-checkbox").is(":checked") || $(e.target).find('.first-card').length > 0 ){

        var creditCardName = creditCardValueOrError('.credit-card-name');
        var addressLine1 =  creditCardValueOrError('.credit-card-line1');
        var addressLine2 = creditCardValueOrError('.credit-card-line2');
        var city = creditCardValueOrError('.credit-card-city');
        var state = creditCardValueOrError('.credit-card-state');
        var zip = creditCardValueOrError('.credit-card-zip');
        var country = creditCardValueOrError('.credit-card-country');


        if (card._isMounted()){


            if ($('.label-error-msgs').length > 0){
                $('.fa-spin').addClass('d-none');
                return;
            }

            var custData = {
                name: creditCardName,
                address_line1: addressLine1,
                address_line2: addressLine2,
                address_city: city,
                address_state: state,
                address_zip: zip,
                address_country: country
            };

            stripe.createToken(card, custData).then(function(result) {
                if (result.error) {
                    var errorElement = $(e.target).find(".card-errors");
                    errorElement.text(result.error.message);
                    $('.fa-spin').addClass('d-none')
                }else{
                    $(e.target).find(".credit-card-token").val(result.token.id);
                    $.ajax({
                        type: 'POST',
                        url: $(e.target).attr('action'),
                        data: $(e.target).serialize(),
                        dataType: 'script',
                        async: true
                    });

                }
            });
        }else{
            $(e.target).find(".card-number-label").append("<span class='text-danger label-error-msgs ml-1'>can\'t be blank</span>")
            $('.fa-spin').addClass('d-none')
        }

    }else{
        $.ajax({
            type: 'POST',
            url: $(e.target).attr('action'),
            data: $(e.target).serialize(),
            dataType: 'script',
            async: true
        });
    }
}

$(document).on('change paste keyup','.work-experience-title', function(e){
    if ($(this).val() === ""){
        $(this).closest('.form-row').removeClass("work-experience-title-selected");
    }else{
        $(this).closest('.form-row').addClass("work-experience-title-selected");
    }
});

$(document).on('keyup input','.job-total', function(e){
    console.log('h5.' + $(this).attr('total_field'));
    var total = $(this).val() * $(this).attr('rate');
    $('h5.' + $(this).attr('total_field')).text('$'+ total);
    $("." + $(this).attr('total_field') + "[type='hidden']").val(total * 100)
});

$(document).on('change paste keyup','.work-experience-employer', function(e){
    if ($(this).val() === ""){
        $(this).closest('.form-row').removeClass("work-experience-employer-selected");
    }else{
        $(this).closest('.form-row').addClass("work-experience-employer-selected");
    }
});

$(document).on('change','.select-certificate', function(e){
    if ($(this).val() === ""){
        $(this).closest('.form-row').removeClass("select-certificate-selected");
    }else{
        $(this).closest('.form-row').addClass("select-certificate-selected");
    }
    return false;
});

$(document).on('change paste keyup','.certificate-number', function(e){
    if ($(this).val() === ""){
        $(this).closest('.form-row').removeClass("certificate-number-selected");
    }else{
        $(this).closest('.form-row').addClass("certificate-number-selected");
    }
});


$(document).on(click_event,':submit', function(e){
    $(this).find('.fa-spin').removeClass('d-none')

});

$(document).on(click_event,'.billing-btn', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    $('.jobs-info-form').addClass('d-none');
    $('.billing-info-form').removeClass('d-none');
    return false;
});


$(document).on(click_event,'.register-btn', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    window.localStorage.setItem('activeTabId', 'pills-freelancer-profile-tab');
    window.location.href = "/users/sign_up";
    return false;
});





$(document).on(click_event,'.card-element', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    if ($(this).children().length === 0) {
        mountCreditCardElement("#" + $(this).attr("id"));
    }

    return false;
});

$(document).on("change",'.different-card-checkbox', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    if ($(this).is(":checked") === true){
        $(this).closest(".form-row").siblings(".new-card-section").removeClass('d-none');
    }else{
        $(this).closest(".form-row").siblings(".new-card-section").addClass('d-none')
    }

    return false;
});

$(document).on('change paste keyup','.work-experience-from', function(e){
    if (date.test($(this).val())){
        $(this).closest('.form-row').addClass("work-experience-from-selected");
    }else{
        $(this).closest('.form-row').removeClass("work-experience-from-selected");
    }
});

$(document).on('change paste keyup','.work-experience-to', function(e){
    if (date.test($(this).val())) {
        $(this).closest('.form-row').addClass("work-experience-to-selected");
    }else{
        $(this).closest('.form-row').removeClass("work-experience-to-selected");
    }
});

$(document).on('change paste keyup','.work-experience-achievements', function(e){
    if ($(this).val() === ""){
        $(this).closest('.form-row').removeClass("work-experience-achievements-selected");
    }else{
        $(this).closest('.form-row').addClass("work-experience-achievements-selected");
    }
});



$(document).on(click_event,'.reject-btn', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    $.ajax({
        type: 'PUT',
        url: $(this).attr('href'),
        data: {job_approvals: {acceptance: false}},
        dataType: 'script',
        async: false
    });
    return false;
});


$(document).on(click_event,'.job-cancel-btn', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    $.ajax({
        type: 'PUT',
        url: $(this).attr('href'),
        data: {job_approvals: {canceled: true}},
        dataType: 'script',
        async: false
    });
    return false;
});

$(document).on(click_event,'.accept-btn', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    $.ajax({
        type: 'PUT',
        url: $(this).attr('href'),
        data: {job_approvals: {acceptance: true}},
        dataType: 'script',
        async: false
    });
    return false;
});






$(document).on(click_event,'.find-freelancer-btn', function(){
    $("html, body").animate({ scrollTop: $(".search-for-engineers").position().top }, 1000);

});



var date = new RegExp('((02\\/[0-2]\\d)|((01|[0][3-9]|[1][0-2])\\/(31|30|[0-2]\\d)))\\/[12]\\d{3}');


function getSelectedPill(){


    var activePillId = window.localStorage.getItem('activeTabId');
    if (activePillId && gon.current_user_id){
        $('#' + activePillId).tab('show');
        window.localStorage.removeItem("activeTab");
    }else{

        $('#pills-find-freelancers-tab').tab('show');
    }

}

$(document).on(click_event,'a[data-toggle="pill"]', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    window.localStorage.setItem('activeTabId', $(e.target).attr('id'));
});




$(document).on('shown.bs.tab','a[data-toggle="pill"]', function(e){

    $.ajax({
        type: 'GET',
        url: '/tabs',
        data: {target_div: $(e.target).attr('href')},
        dataType: 'script',
        async: false
    });


});

$(document).on('change','#payout_identity_legal_entity_attributes_dob', function(e){
    if ($(this).val()){
        var dateArray = $(this).val().split("-");
        $("#payout_identity_legal_entity_attributes_dob_year").val(dateArray[0]);
        $("#payout_identity_legal_entity_attributes_dob_month").val(dateArray[1]);
        $("#payout_identity_legal_entity_attributes_dob_day").val(dateArray[2]);
    }else{
        $("#payout_identity_legal_entity_attributes_dob_year").val(null);
        $("#payout_identity_legal_entity_attributes_dob_month").val(null);
        $("#payout_identity_legal_entity_attributes_dob_day").val(null);
    }
});


 