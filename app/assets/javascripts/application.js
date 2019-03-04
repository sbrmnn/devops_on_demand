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

//= require jquery3
//= require jquery-ui

//= require rails-ujs
//= require turbolinks
//= require popper
//= require bootstrap-sprockets
//= require material
//= require bootstrap-datepicker
//= require cloudinary
//= require cocoon
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
        $('#pills-messages-tab').trigger('click');
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
    mountCreditCardElement();
});

function init() {
    bindCloudinaryElement();
    var public_id = $('#freelancer_profile_photo').data("public-id");
    renderProfileImagePreview(public_id);
    taggifyInput();
    getSelectedPill();
    bindChatroomToRecieveMessages();
    subscribeToRooms();
    bindScrollFunctionToFrom();
    getEntityTypeFields();
    subscribeToMissingFieldsChannel();
    displayMissingFields(gon.missing_payout_fields)

}

function displayMissingFields(data){
    $('.bank-account-error').remove();
    data.forEach(function(element) {
        $("." + element.split('.').join('_') + "> label").append("<span class='text-danger bank-account-error px-1'>required</span>");
    });
}


$(document).on('change paste keyup','.work-experience-title', function(e){
    if ($(this).val() === ""){
        $(this).closest('.form-row').removeClass("work-experience-title-selected");
    }else{
        $(this).closest('.form-row').addClass("work-experience-title-selected");
    }
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


$(document).keyup(function (e) {
    if ($(".write_msg").is(':focus') && (e.keyCode === 13)) {
        var chatroomId = $(document.activeElement).data("chatroom");
        broadcastMessage(chatroomId)
    }
});

$(document).on(click_event,'.preview-btn', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    var serializedValue = $('#freelancer-registration-form').serialize().trim();
    var modalIframe = $("#modal-iframe");
    var iframeUrl = "/profile_preview?" + serializedValue;
    var lightbox = lity(iframeUrl);
    return false;
});


$(document).on(click_event,'.freelancer-signup-btn', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    $('#pills-freelancer-registration-tab').click()
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


$(document).on(click_event,'.chatroom-list-elem', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    $('.chatroom-list-elem').removeClass('active_chat');
    $(this).removeClass('new_msg');
    $(this).addClass('active_chat');
    $('.type_msg').show();
    renderChatRoomMessages($(this).data('chatroom_id'));
    return false;
});


$(document).on(click_event,'.msg_send_btn', function(){
    broadcastMessage($(this).data('chatroom'))
});


function bindScrollFunctionToFrom(){
     $('form').submit(function() {
         $('.fa-spin').removeClass('d-none')
     });
}

var date = new RegExp('((02\\/[0-2]\\d)|((01|[0][3-9]|[1][0-2])\\/(31|30|[0-2]\\d)))\\/[12]\\d{3}');


function getSelectedPill(){
    var preSelectedChatroom = preSelectChatroom();
    if (!preSelectedChatroom) {
        var activePillId = window.localStorage.getItem('activeTabId');
        if (activePillId){
            $('#' + activePillId).tab('show');
            window.localStorage.removeItem("activeTab");
        }else{
            $('#pills-find-freelancers-tab').tab('show');
        }
    }
    $(document).on(click_event,'a[data-toggle="pill"]', function(e){
         window.localStorage.setItem('activeTabId', $(e.target).attr('id'));
    });
}







