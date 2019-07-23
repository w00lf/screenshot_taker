$(function() {
  $('#scrapping_task_submit').click(function(e){
    $(this).hide().parents('form').find('#scrapping_task_name').attr('readonly', 'readonly');
    $('#status').text('Started parsing...');
  })
});