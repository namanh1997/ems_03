$(document).on("turbolinks:load", function(){
  $(".select-dropdown").select2({
    theme: "bootstrap"
  });

  $("input:radio[name='question[question_type]']").on("change", function(){
    if ($(this).val() == "single_choice") {
      $(".answer-checkbox").on("change", function() {
        $(".answer-checkbox").not(this).prop("checked", false);
      });
    }
  });

  function load_new_exam(){
    easy = parseInt($("#easy-question").val());
    normal = parseInt($("#normal-question").val());
    normal_difficulty = normal * 2;
    hard = parseInt($("#hard-question").val());
    hard_difficulty = hard * 3;
    total_difficulty = easy + normal_difficulty + hard_difficulty
    total_questions = easy + normal + hard
    $("#total-questions").val(total_questions);
    $("#total-score").val(total_difficulty);
  }

  load_new_exam();

  $(".num-question").change(function(){
    load_new_exam();
  });

  $(".answer-content .answer-radiobutton").click(function(){
    $(this).parent().siblings().removeClass("checkedlabel");
    $(this).parent().addClass("checkedlabel");
  });

  $(".answer-content .answer-checkbox").click(function(){
    if($(this).parent().hasClass("checkedlabel")){
      $(this).parent().removeClass("checkedlabel");
    } else {
      $(this).parent().addClass("checkedlabel");
    }
  });

  $(".answer-radiobutton").click("change", function() {
    $(this).parent().siblings().children("input:radio").prop("checked", false);
  });
});

var countdown = function() {
  $('#clock').countdown({ //clock là thẻ chứa bộ đếm đồng hồ
    until: $('#remaining_time').val(), //thời gian đếm
    format: 'HMS', //định dạng thời gian
    onExpiry: function() {
      $('.submit-time-out').hidden(); //submit khi hết giờ
    }
  });
}

document.addEventListener('turbolinks:load', countdown);
$(document).on('page:update', countdown);
