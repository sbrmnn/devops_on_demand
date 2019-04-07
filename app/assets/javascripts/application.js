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

//= require rails-ujs
//= require turbolinks
//= require material
//= require cloudinary
//= require cocoon
//= require payment_processor
//= require readmore
//= require_tree .

$.ajaxSetup({
    beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $("meta[name='csrf-token']").attr('content'));
    }
});




$(document).keyup(function (e) {
    if ($(".write_msg").is(':focus') && (e.keyCode === 13)) {
        var chatroomId = $(document.activeElement).data("chatroom");
        broadcastMessage(chatroomId, $(document.activeElement).closest('.msg-input-grp').find('.msg_send_btn'))
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


});

function init() {
    _freelancerRegistrationInit();
    getSelectedPill();
    bindChatroomToRecieveMessages();
    subscribeToRooms();
    getEntityTypeFields();
    subscribeToMissingFieldsChannel();
    displayMissingFields(gon.missing_payout_fields);
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


$(document).on(click_event,'.preview-btn', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    var serializedValue = $('#freelancer-registration-form').serialize().trim();
    var modalIframe = $("#modal-iframe");
    var iframeUrl = "/profile_preview?" + serializedValue;
    var lightbox = lity(iframeUrl);
    return false;
});

$(document).on(click_event,'.billing-btn', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    $('.jobs-info-form').addClass('d-none');
    $('.billing-info-form').removeClass('d-none');
    return false;
});


$(document).on(click_event,'.name-link', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    var modalIframe = $("#modal-iframe");
    var iframeUrl = $(this).attr('href');
    lity(iframeUrl);
    return false;
});


$(document).on(click_event,'.hire-me-btn', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    var jobForm = $($(this).attr("href"))
    if (jobForm.hasClass("d-none")){
        $($(this).attr("href")).removeClass("d-none");
    }else{
        $($(this).attr("href")).addClass("d-none");
    }

    return false;
});


$(document).on(click_event,'.freelancer-signup-btn', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    $('#pills-freelancer-registration-tab').click();
    return false;
});


$(document).on(click_event,'.save_card_btn', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    $(".card-errors").empty()
    getCreditCardToken("#job-form" + $(this).data("freelancer"));

    return false;
});




$(document).on(click_event,'.card-element', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    if ($(this).children().length === 0) {
        $(this).closest("form").find(".save_card_btn").removeClass("d-none")
        mountCreditCardElement("#" + $(this).attr("id"));

    }

    return false;
});




$(document).on("change",'.different-card-checkbox', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    if ($(this).is(":checked") === true){
        $(this).closest(".form-row").siblings(".new-card-section").removeClass('d-none');
        //mountCreditCardElement("#card-element-for-freelancer-" + $(this).data('freelancer'))
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


$(document).on(click_event,'button.toggle_message_box', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    var self = $(this);
    var chatbox = $('.'+self.data('messagebox'));
    if (chatbox.hasClass('d-none')){
        $.ajax({
            type: 'POST',
            url: '/chatrooms',
            data: {chatrooms: {freelancer_user: $(this).data('freelancer-user')}},
            dataType: 'script',
            async: false
        });
        chatbox.removeClass('d-none');
        chatbox[0].scrollIntoView(false);
    }else{
        chatbox.addClass('d-none');
    }

    return false;
});

$(document).on(click_event,'.msg_send_btn', function(){
    broadcastMessage($(this).data('chatroom'), $(this))
});

function bindScrollFunctionToForm(){
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
}


$(document).on(click_event,'a[data-toggle="pill"]', function(e){
    window.localStorage.setItem('activeTabId', $(e.target).attr('id'));
});

$(document).on('shown.bs.tab','a[data-toggle="pill"]', function(e){
    if($(e.target).is("#pills-messages-tab")) {
            $('.profile-chat').readmore({
                speed: 75,
                collapsedHeight: 0,
                lessLink: '<a href="#">Read less</a>',
                moreLink: '<a href="#">Read Profile</a>'
            });

    }
});











