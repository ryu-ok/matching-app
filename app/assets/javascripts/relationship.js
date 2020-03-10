$(function(){
  $("#new_relationship").on("submit",function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');

    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      if (data.matching == true) {
        $('.hidden-box').fadeIn(3000);
        
      } else {
        location.reload();
      }
    })
    .fail(function(){
      alert("マッチングに失敗しました");
    });
  });
});
