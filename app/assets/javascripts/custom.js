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
});
