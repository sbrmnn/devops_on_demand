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
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require js.cookie
//= require material
//= require bootstrap-datepicker
//= require jquery-ui
//= require cloudinary
//= require cocoon
//= require_tree .

$.ajaxSetup({
    'beforeSend': function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $("meta[name='csrf-      token']").attr('content')); }
});


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

 $( document ).on('turbolinks:load', function() {

     $.fn.scrollToBottom = function() {
        return this.each(function (i, element) {
            $(element).scrollTop($(element)[0].scrollHeight);
        });
     };

     taggifyInput();
     bindCloudinaryElement();
     getSelectedPill();
     bindChatroomToRecieveMessages();
     subscribeToRooms();
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
    var serializedValue = $('.edit_freelancer').serialize().trim() || $('.new_freelancer').serialize();
    var modalIframe = $("#modal-iframe");
    var iframeUrl = "/profile_preview?" + serializedValue;
    var lightbox = lity(iframeUrl);
    return false;
});

$(document).on(click_event,'#freelancer-search-btn', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    $.ajax({
        type: "GET",
        dataType: "json",
        url: "/freelancer_searches.json",
        success: function(data){
            data.forEach(function(item, key, data) {
                if (Object.is(data.length - 1, key)) {
                    // execute last item logic
                    appendMessageHistory(item['body'], new Date(item['created_at']), item['user_id'], chatroomId, true);
                }else{
                    appendMessageHistory(item['body'], new Date(item['created_at']), item['user_id'], chatroomId);

                }
            });
        }
    });
    return false;
});

function bindChatroomToRecieveMessages(){
    var viewMsgBtns = $(".view-messages-btn");
    if ( viewMsgBtns.length ) {
        viewMsgBtns.each(function() {
            var target = $(this).data('target');
            var chatroomId = $(this).data('chatroom');
            $(document).on('show.bs.collapse', target, function () {
                renderChatRoomMessages(chatroomId);
            });
        });
    }
}




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


///

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

var date = new RegExp('((02\\/[0-2]\\d)|((01|[0][3-9]|[1][0-2])\\/(31|30|[0-2]\\d)))\\/[12]\\d{3}');


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


///

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


function taggifyInput(){
    $('#tags').tagsInput();
}

function bindCloudinaryElement(){
    $.cloudinary.config({ cloud_name: 'yumfog-com',  api_key: '165496118466817'});

    $('.cloudinary-fileupload').bind('cloudinarydone', function(e, data) {
        $('.preview').html(
            $.cloudinary.image(data.result.public_id,
                { format: data.result.format, version: data.result.version,
                    crop: 'fill', gravity: 'face' ,width: 250, height: 250 })
        );

        $('#freelancer_profile_photo').val($('.preview img').attr('src'));

        return true;
    });

    if($.fn.cloudinary_fileupload !== undefined) {
        $("input.cloudinary-fileupload[type=file]").cloudinary_fileupload();
    }
}

function subscribeToRooms(){
    var chatroomNames = $(".chat-box");
    if ( chatroomNames.length ) {
        chatroomNames.each(function() {
            subscribeToRoom($( this ).data('chatroom'));
        });
    }
}

function getSelectedPill(){
    var preSelectedChatroom = preSelectChatroom();
    if (!preSelectedChatroom) {
        var activePillId = window.localStorage.getItem('activeTabId');
        if (activePillId){
            $('#' + activePillId).tab('show');
            window.localStorage.removeItem("activeTab");
        }else{
            $('#pills-home-tab').tab('show');
        }
    }
    $(document).on(click_event,'a[data-toggle="tab"]', function(e){
        window.localStorage.setItem('activeTabId', $(e.target).attr('id'));
    });
}

function broadcastMessage(chatroomId){
    var roomId = chatroomId;
    var messageInput = $('.write_msg[data-chatroom="'+ chatroomId +'"]');
    var message = messageInput.val().trim();
    var roomName = 'room' + roomId;
    if (!$.isEmptyObject(message)){
        App[roomName].speak(message);
        messageInput.val('')
    }
}

function renderChatRoomMessages(chatroomId){
    var chatbox = $('.chat-box[data-chatroom="'+ chatroomId +'"]');
    chatbox.empty();
    $.ajax({
        type: "GET",
        dataType: "json",
        url: "/chatrooms/" + chatroomId + "/messages.json",
        success: function(data){
            data.forEach(function(item, key, data) {
                if (Object.is(data.length - 1, key)) {
                    // execute last item logic
                    appendMessageHistory(item['body'], new Date(item['created_at']), item['user_id'], chatroomId, true);
                }else{
                    appendMessageHistory(item['body'], new Date(item['created_at']), item['user_id'], chatroomId);

                }
             });
        }
    });
}

function appendMessageHistory(message, time , message_user_id, chatroomId, toBottom=false){
    var current_user_id = Cookies.get('current_user_id');
    var elem = document.getElementById("chatboxID-" + chatroomId);
    if (message_user_id == current_user_id) {
        elem.insertAdjacentHTML( 'beforeend', outgoingMessageHTML(message, time) );
    }else{
        elem.insertAdjacentHTML( 'beforeend', incomingMessageHTML(message, time) );
    }
    if (toBottom === true){
        $(elem).scrollToBottom()
    }
}

function incomingMessageHTML(message, time){
    return '<div class="row py-2">\
               <div class="col-12">\
                <div class="chat bg-yumfog-orange d-inline-block text-dark">\
                 <div class="chat-bubble">\
                   <p class="m-0 chat-text-size">'+ messageWithLineBreak(message) +'</p>\
                   <span class="time_date chat-date-size"> ' + timeString(time) + '</span></div>\
                 </div>\
                </div>\
               </div>\
           </div>';
}

function outgoingMessageHTML(message, time){
    return '<div class="row py-2">\
             <div class="col-12">\
                 <div class="chat bg-white-smoke d-inline-block text-dark pull-right">\
                   <div class="chat-bubble">\
                     <p class="m-0 chat-text-size">'+ messageWithLineBreak(message) +'</p>\
                     <span class="time_date chat-date-size"> ' + timeString(time) + '</span></div>\
                   </div>\
                 </div>\
              </div>\
            </div>';
}

function messageWithLineBreak(message){
    return message.replace(/(.{55})/g, "$1<br>");
}

function timeString(time) {
    return formatAMPM(time)  + '   |   ' + months[time.getMonth()] + ' ' + time.getDate()
}

