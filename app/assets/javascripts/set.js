$(function() {
  // 1. 「全選択」する
  $('#all').on('click', function() {
    $("input[name='chk[]']").prop('checked', this.checked);
  });

  // 2. 「全選択」以外のチェックボックスがクリックされたら、
  $("input[name='chk[]']").on('click', function() {
    if ($('#boxes :checked').length == $('#boxes :input').length) {
      // 全てのチェックボックスにチェックが入っていたら、「全選択」 = checked
      $('#all').prop('checked', true);
    } else {
      // 1つでもチェックが入っていたら、「全選択」 = checked
      $('#all').prop('checked', false);
    }
  });
});