//= require jquery
//= require jquery_ujs
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

$(function() {
  $('#toggle-two').bootstrapToggle({
    on: 1,
    off: 0
  });
})
