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
//= require_tree .

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

var months = [ "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December" ];


$.ajaxSetup({
    'beforeSend': function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $("meta[name='csrf-      token']").attr('content')); }
});

(function($) {
    $.fn.scrollToBottom = function() {
        return this.each(function (i, element) {
            $(element).scrollTop($(element)[0].scrollHeight);
        });
    };
}(jQuery));

$(document).ready(function() {
    getPreviouslySelectedPill();
});


$(document).keyup(function (e) {
    if ($(".write_msg").is(':focus') && (e.keyCode === 13)) {
        broadcastMessage()
    }
});

$(document).on('click','.chat_list', function(){
    $('.chat_list').removeClass('active_chat');
    $(this).addClass('active_chat');
    $('.type_msg').show();
    renderChatRoomMessage($(this).find('.chat_room_id')[0].innerHTML)
});

$(document).on('click','.msg_send_btn', function(){
    broadcastMessage()
});


function getPreviouslySelectedPill(){
    var activePillId = window.localStorage.getItem('activeTabId');
    if (activePillId) {
        $('#' + activePillId).tab('show');
        window.localStorage.removeItem("activeTab");
    }
    $(document).on('click','a[data-toggle="pill"]', function(e){
        window.localStorage.setItem('activeTabId', $(e.target).attr('id'));
    });
}

function broadcastMessage(){
    var roomId = $('.active_chat').find('.chat_room_id')[0].innerHTML;
    var messageInput = $('.write_msg');
    var message = messageInput.val().trim();
    var roomName = 'room' + roomId;
    if (!$.isEmptyObject(message)){
        App[roomName].speak(message);
        messageInput.val('')
    }
}





function renderChatRoomMessage(chatroomId){
    $('.msg_history').empty();
    $.ajax({
        type: "GET",
        dataType: "json",
        url: "/chatrooms/" + chatroomId + "/messages.json",
        success: function(data){
            data.forEach(function(item) {
                appendMessageHistroy(item['body'], new Date(item['created_at']), item['user_id']);
            });

        }
    });
}


function appendMessageHistroy(message, time ,message_user_id){
    var current_user_id = Cookies.get('current_user_id');
    if (message_user_id == current_user_id) {
        $('.msg_history').append(outgoingMessageHTML(message, time)).scrollToBottom();

    }else{
        $('.msg_history').append(incomingMessageHTML(message, time)).scrollToBottom();
    }
}

function incomingMessageHTML(message, time){
    return '<div class="incoming_msg mb-3">\
              <div class="received_msg">\
               <div class="received_withd_msg">\
                  <p>'+ message+'</p>\
                 <span class="time_date"> ' + timeString(time) + '</span></div>\
               </div>\
            </div>'
}

function outgoingMessageHTML(message, time){
   return '<div class="outgoing_msg mb-3">\
             <div class="sent_msg">\
               <p>'+message+'</p>\
               <span class="time_date">' + timeString(time) + '</span> \
             </div>\
           </div>'
}



function timeString(time) {
    return formatAMPM(time)  + '   |   ' + months[time.getMonth()] + ' ' + time.getDate()
}
