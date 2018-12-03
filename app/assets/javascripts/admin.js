//= require jquery
//= require admin/popper.min
//= require bootstrap.min
//= require admin/main


function onlyNum(that){
    that.value=that.value.replace(/[^\-?\d.]/g,'');
}

function return0(that){
    if(that.value==""){
        that.value=0;
    }
}
