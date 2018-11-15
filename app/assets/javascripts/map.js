var map, infoWindow;

function initMap(){
  var maps = document.getElementsByClassName("map");
  for(var i=0; i<maps.length; i++) {
    mapId = maps[i].id;
    map = new google.maps.Map(document.getElementById(mapId), {
      center: new google.maps.LatLng(0,0),
      zoom: 15
    });
    infoWindow = new google.maps.InfoWindow;
    if (mapId==="fixermap"){
      geolocation(0);
    } else {
      geocoder = new google.maps.Geocoder();
    }
  }
}

function geolocation(label){
  // Try HTML5 geolocation.
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      infoWindow.setPosition(pos);
      if (label===0){
        infoWindow.setContent('You are here.');
      } else {
        infoWindow.setContent(document.getElementById("confirmLoc"));

      }

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
  if (document.getElementById("address").value === ""){
    geocoder.geocode( { 'location': infoWindow.getPosition()}, function(results, status) {
      if (status == 'OK') {
        document.getElementById("address").value = results[0].formatted_address;
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
    var address = document.getElementById('address').value;
    geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == 'OK') {
        map.setCenter(results[0].geometry.location);
        infoWindow.setPosition(results[0].geometry.location);
        infoWindow.setContent(document.getElementById("confirmLoc"));
        infoWindow.open(map);
      } else {
        alert('Geocode was not successful for the following reason: ' + status);
      }
    });
  }

function checkbox(){
  if (document.getElementById("useCurrLocation").checked == true){
    geolocation(1);
  } else {
    map.setCenter(new google.maps.LatLng(0,0));
  }
}
$(document).on('turbolinks:load', initMap);
$(document).ready(function () {
    $("#address").change(codeAddress);
});
