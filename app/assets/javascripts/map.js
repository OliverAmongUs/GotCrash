var map, infoWindow;
var reportInfoWindow;

function initMap(){
  var maps = document.getElementsByClassName("map");
  for(var i=0; i<maps.length; i++) {
    mapId = maps[i].id;
    map = new google.maps.Map(document.getElementById(mapId), {
      center: new google.maps.LatLng(0,0),
      zoom: 15
    });
    infoWindow = new google.maps.InfoWindow;
    geocoder = new google.maps.Geocoder();
    if (mapId==="fixermap"){
      geocoder1 = new google.maps.Geocoder();
      initFixerAddress();
      reportInfoWindow = new google.maps.InfoWindow;
    } else {
      geocoder2 = new google.maps.Geocoder();
    }
  }
}

function initFixerAddress(){
  var fixeraddress = gon.fixer_address;
  geocoder1.geocode( { 'address': fixeraddress}, function(results, status) {
    if (status == 'OK') {
      map.setCenter(results[0].geometry.location);
      infoWindow.setPosition(results[0].geometry.location);
      infoWindow.setContent('Your shop is here.');
      infoWindow.open(map);
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}
function geolocation(){
  // Try HTML5 geolocation.
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      infoWindow.setPosition(pos);
      infoWindow.setContent(document.getElementById("confirmLoc"));
      document.getElementById("confirmLoc").style = "display: block";
      infoWindow.open(map);
      map.setCenter(pos);
    }, function() {
      handleLocationError(true, infoWindow, map.getCenter());
    });
  } else {
    // Browser doesn't support Geolocation
    handleLocationError(false, infoWindow, map.getCenter());
  }
}

function confirmLocation(){
  document.getElementById("longitude").value = infoWindow.getPosition().lng();
  document.getElementById("latitude").value = infoWindow.getPosition().lat();
  if (document.getElementById("reportaddress").value === ""){
    geocoder.geocode( { 'location': infoWindow.getPosition()}, function(results, status) {
      if (status == 'OK') {
        document.getElementById("reportaddress").value = results[0].formatted_address;
      } else {
        alert('Geocode was not successful for the following reason: ' + status);
      }
    });
  }
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infoWindow.setPosition(pos);
  infoWindow.setContent(browserHasGeolocation ?
                        'Error: The Geolocation service failed.' :
                        'Error: Your browser doesn\'t support geolocation.');
  infoWindow.open(map);
}

function codeAddress() {
    var address = document.getElementById('reportaddress').value;
    geocoder2.geocode( { 'address': address}, function(results, status) {
      if (status == 'OK') {
        map.setCenter(results[0].geometry.location);
        infoWindow.setPosition(results[0].geometry.location);
        infoWindow.setContent(document.getElementById("confirmLoc"));
        document.getElementById("confirmLoc").style = "display: block";
        infoWindow.open(map);
      } else {
        alert('Geocode was not successful for the following reason: ' + status);
      }
    });
  }

function checkbox(){
  if (document.getElementById("useCurrLocation").checked == true){
    geolocation();
  } else {
    map.setCenter(new google.maps.LatLng(0,0));
  }
}

function displayReport(latitude,longitude,id){
  console.log(id);
  var pos = {
    lat: latitude,
    lng: longitude
  };
  var marker = new google.maps.Marker({position: pos, map: map});

   marker.addListener('click', function() {
     showreportinfo(id,pos);
   });

}

function showreportinfo(id,pos) {
  $.ajax({
    method: 'Post',
    url: 'showreport',
    data: { report_id: id},
  });
  reportInfoWindow.setContent(document.getElementById("showreport").innerHTML);
  reportInfoWindow.setPosition(pos);
  reportInfoWindow.open(map);
}

$(document).on('turbolinks:load', initMap);
$(document).ready(function () {
    $("#reportaddress").change(codeAddress);
});
