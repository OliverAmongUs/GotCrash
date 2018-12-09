//= require admin/main
//= require admin/popper.min
//= require bootstrap.min
//= require sweetalert2
//= require sweet-alert2-rails

function onlyNum(that){
    that.value=that.value.replace(/[^\-?\d.]/g,'');
}

function return0(that){
    if(that.value==""){
        that.value=0;
    }
}

//Override the default confirm dialog by rails
$.rails.allowAction = function(link){
  if (link.data("confirm") == undefined){
    return true;
  }
  $.rails.showConfirmationDialog(link);
  return false;
}

//User click confirm button
$.rails.confirmed = function(link){
  link.data("confirm", null);
  link.trigger("click.rails");
}

//Display the confirmation dialog
$.rails.showConfirmationDialog = function(link){
  var message = link.data("confirm");
  swal({
    title: message,
    type: 'warning',
    confirmButtonText: 'Sure',
    confirmButtonColor: '#2acbb3',
    showCancelButton: true
  }).then(function(e){
    $.rails.confirmed(link);
  });
};
