$(function(){
  $('.answer_progress').each((_index, elem) => {
    const progress = $(elem).text().trim();
    $(elem).width(progress)
  });
});