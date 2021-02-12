$('#file-btn-upload').on('click',(e)=>{
  $('#file').trigger('click')
})

$('#file').on('change',(e)=>{
  if ( $('#file').val().includes('.csv') ){
    $('#file-btn-upload').off()
    $('#file-btn-upload').addClass('disabled')
    $('#file-btn-upload').empty()
    $('#file-btn-upload').append('<span>Carregando arquivo</span>')
    $('#file-btn-upload').append('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>')
    $('#form-file').trigger('submit')
  }else {
    $('#file-exception').modal('show')
    $('#file').val(null)
  }
})