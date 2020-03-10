$(function(){
  var buildHTML = function(message) {
    var html = 
              `<div class="message">
              <div class="chat-box-right">
                <div class="chat-hukidashi">
                  <div class="content-right">
                    ${message.content}
                  </div>
                  <div class="time">
                    ${message.created_at}
                  </div>
                </div>
                <div class="chat-face">
                  <img src=${message.user_avatar} class = "user-image">
                </div>
              </div>
              </div>`
    return html;
  };
  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.chat').append(html);      
      $('form')[0].reset();
      $('.chat').animate({ scrollTop: $('.chat')[0].scrollHeight});
      //$('.chat').animate({ scrollTop: $('.chat')[0].scrollHeight});
      $(".form-submit").prop('disabled', false);
    })
    .fail(function(){
      alert("メッセージ送信に失敗しました");
    });

    
  });
});
