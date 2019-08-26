$(document).ready(function(){
  $(".select-dropdown").select2({
    theme: "bootstrap"
  });

  $("input:radio[name='question[question_type]']").on("change", function(){
    if ($(this).val() == "single_choice") {
      $(".answer-checkbox").on("change", function() {
        alert("no");
        $(".answer-checkbox").not(this).prop("checked", false);  
      });
    }
    else if ($(this).val() == "multi_choice") {
      $(".answer-checkbox").change(function(){
        var size = $(".answer-checkbox").size();
        var checked = $(".answer-checkbox[value='1']").size();
        if (checked = size - 1){
          $(".answer-checkbox").this.prop("disabled", true);
        }
      });
    }
  });

  function load_new_exam(){
    easy = parseInt($("#easy-question").val());
    normal = parseInt($("#normal-question").val());
    normal_difficulty = normal * 2;
    hard = parseInt($("#hard-question").val());
    hard_difficulty = hard * 2;
    total_difficulty = easy + normal_difficulty + hard_difficulty
    total_questions = easy + normal + hard
    $("#total-questions").val(total_questions);
    $("#total-score").val(total_difficulty);
  }

  load_new_exam();

  $(".num-question").change(function(){
    load_new_exam();
  });
});
