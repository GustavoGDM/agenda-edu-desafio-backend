$('#file-btn-upload').on('click',(e)=>{
  $('#file').trigger('click')
})

$('#file').on('change',(e)=>{
  if ( $('#file').val().includes('.csv') ){
    $('#form-file').trigger('submit')
  }else {
    $('#file-exception').modal('show')
    $('#file').val(null)
  }
})