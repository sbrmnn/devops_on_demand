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
    getSelectedPill();
    subscribeToRooms();
    bindChangeEventToCertificateSelectProvider();
    bindClickEventToAddCertificationBtn();
});



$(document).keyup(function (e) {
    if ($(".write_msg").is(':focus') && (e.keyCode === 13)) {
        broadcastMessage()
    }
});

$(document).on(click_event,'.chatroom-list-elem', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    $('.chatroom-list-elem').removeClass('active_chat');
    $(this).removeClass('new_msg');
    $(this).addClass('active_chat');
    $('.type_msg').show();
    renderChatRoomMessage($(this).data('chatroom_id'));
    return false;
});


$(document).on(click_event,'.msg_send_btn', function(){
    broadcastMessage()
});

function bindClickEventToAddCertificationBtn(){
    var certificationNestedField = $('.certification-nested-fields');
    $('#add-more-cert-btn').on('click', function(e){
        if ($(this).data('insertion') === undefined || $(this).data('insertion') === null){
            $(this).data('insertion', certificationNestedField.html())
        }
        certificationNestedField.append($(this).data('insertion'));

    });
}


function bindChangeEventToCertificateSelectProvider(){
    $('.certification-nested-fields').on('change', '.select-provider', function(e){
        var data = {certification_name: {provider: $(this).val()}};
        var certNameSelector = $(this).closest('.form-row').find('.select-certificate-name');
        certNameSelector.find('option').not(':first').remove();
        $.ajax({
            type: "GET",
            dataType: "json",
            data: data,
            url: "/certification_names.json",
            success: function(data){
                $.each(data, function(key, value) {
                    certNameSelector
                        .append($("<option></option>")
                            .attr("value",value["id"])
                            .text(value["name"]));
                });
            }
        });
    });
}

function subscribeToRooms(){
    var chatroomNames = $(".chatroom-list-elem");
    if ( chatroomNames.length ) {
        chatroomNames.each(function() {
            subscribeToRoom($( this ).data('chatroom_id'));
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
    $(document).on(click_event,'a[data-toggle="pill"]', function(e){
        window.localStorage.setItem('activeTabId', $(e.target).attr('id'));
    });
}

function broadcastMessage(){
    var roomId = $('.active_chat').data('chatroom_id');
    var messageInput = $('.write_msg');
    var message = messageInput.val().trim();
    var roomName = 'room' + roomId;
    if (!$.isEmptyObject(message)){
        App[roomName].speak(message);
        messageInput.val('')
    }
}

function renderChatRoomMessage(chatroomId){
    $('.chat-box').empty();
    $.ajax({
        type: "GET",
        dataType: "json",
        url: "/chatrooms/" + chatroomId + "/messages.json",
        success: function(data){
            data.forEach(function(item) {
                appendMessageHistory(item['body'], new Date(item['created_at']), item['user_id']);
            });
            $('.chat-box').scrollToBottom();
            $('.msg-input-grp').show()

        }
    });
}


function appendMessageHistory(message, time , message_user_id){
    var current_user_id = Cookies.get('current_user_id');
    if (message_user_id == current_user_id) {
        $('.chat-box').append(outgoingMessageHTML(message, time))
    }else{
        $('.chat-box').append(incomingMessageHTML(message, time))
    }
}

function incomingMessageHTML(message, time){
    return '<div class="row">\
               <div class="col-12">\
                <div class="chat bg-orange d-inline-block text-dark mb-2">\
                 <div class="chat-bubble">\
                   <p class="m-0 chat-text-size">'+ messageWithLineBreak(message) +'</p>\
                   <span class="time_date chat-date-size"> ' + timeString(time) + '</span></div>\
                 </div>\
                </div>\
               </div>\
           </div>';
}

function outgoingMessageHTML(message, time){
    return '<div class="row">\
             <div class="col-12">\
                 <div class="chat bg-white-smoke d-inline-block text-dark mb-2 pull-right">\
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

