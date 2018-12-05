var map, infoWindow;
var reportInfoWindow;
var shopInfoWindow;
var markers = {};
var fixerlocation = {};
var ownerlocation = {};
var shopmarkers = {};

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
    } else if (mapId==="shopmap"){
      geocoder2 = new google.maps.Geocoder();
      initOwnerAddress();
      shopInfoWindow = new google.maps.InfoWindow;
    } else {
      codeAddress();
    }
  }
}

function initFixerAddress(){
  var fixeraddress = gon.fixer_address;
  geocoder1.geocode( { 'address': fixeraddress}, function(results, status) {
    if (status == 'OK') {
      map.setCenter(results[0].geometry.location);
      fixerlocation['lat'] = results[0].geometry.location.lat();
      fixerlocation['lng'] = results[0].geometry.location.lng();
      var fixicon = {
        url: "/fixicon.png", // url
        scaledSize: new google.maps.Size(50, 50), // size
    };

        var fxiMarker = new google.maps.Marker({
          position: {lat: results[0].geometry.location.lat(), lng: results[0].geometry.location.lng()},
          map: map,
          icon: fixicon
        });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

function initOwnerAddress(){
  var owneraddress = gon.owner_address;
  geocoder2.geocode( { 'address': owneraddress}, function(results, status) {
    if (status == 'OK') {
      map.setCenter(results[0].geometry.location);
      ownerlocation['lat'] = results[0].geometry.location.lat();
      ownerlocation['lng'] = results[0].geometry.location.lng();
      var ownericon = {
        url: "/homeicon.png", // url
        scaledSize: new google.maps.Size(30, 45), // size
    };

        var ownerMarker = new google.maps.Marker({
          position: {lat: results[0].geometry.location.lat(), lng: results[0].geometry.location.lng()},
          map: map,
          icon: ownericon
        });
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
  infoWindow.setContent("Location confirmed!");
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infoWindow.setPosition(pos);
  infoWindow.setContent(browserHasGeolocation ?
                        'Error: The Geolocation service failed.' :
                        'Error: Your browser doesn\'t support geolocation.');
  infoWindow.open(map);
}

function codeAddress() {
    var address = document.getElementById('reportaddress');
    var autocomplete = new google.maps.places.Autocomplete(address);
    autocomplete.bindTo('bounds', map);
    autocomplete.setFields(
            ['address_components','geometry']);
    autocomplete.addListener('place_changed', function() {
      var place = autocomplete.getPlace();
      if (!place.geometry) {
            alert("No details available for input: '" + place.name + "'");
            return;
      }
      if (place.geometry.viewport) {
            map.setCenter(place.geometry.location);
            infoWindow.setPosition(place.geometry.location);
            infoWindow.setContent(document.getElementById("confirmLoc"));
            document.getElementById("confirmLoc").style = "display: block";
            infoWindow.open(map);
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

function loadReports() {
  clearreportmarkers();
  document.getElementById("filtertable").style = "display: none";
  document.getElementById("reporttable").style = "display: table";
  var reports = gon.reports;
  document.getElementById("numreportfound").innerHTML = reports.length+ " reports found!";
  var i;
  for (i = 0; i < reports.length; i++) {
    var report = reports[i];
    var lat = report.latitude;
    var lng = report.longitude ;
    var id = report.id;
    displayReport(lat,lng,id);
  }
  document.getElementById("filterdesp").value = "";
  document.getElementById("reportlabel").value = 0;
}

function loadsomeReports(){
  clearreportmarkers();
  document.getElementById("reporttable").style = "display: none";
  var filterdesp = document.getElementById("filterdesp").value;
  var label = document.getElementById("reportlabel").value;
  $.ajax({
    method: 'Post',
    url: 'filterreport',
    data: { filterdesp:filterdesp,reportlabel:label}
  });
  $(document).ajaxStop(function() {
    document.getElementById("filtertable").style = "display: table";
    var reports = gon.filteredreports;
    document.getElementById("numreportfound").innerHTML = reports.length+ " reports found!";
    var i;
    for (i = 0; i < reports.length; i++) {
      var report = reports[i];
      var lat = report.latitude;
      var lng = report.longitude ;
      var id = report.id;
      displayReport(lat,lng,id);
    }
    reports = null;
  });


}

function displayReport(latitude,longitude,id){
  if (markers[id]!=null){
    markers[id].setVisible(true);
  } else {
    var pos = {
      lat: latitude,
      lng: longitude
    };
    var reporticon = {
      url: "https://cdn4.iconfinder.com/data/icons/car-maintenance-and-service-3/48/garage-location-car-sale-gps-map-marker-2-512.png", // url
      scaledSize: new google.maps.Size(40, 40), // size
    };
    var marker = new google.maps.Marker({
      position: pos,
      map: map,
      icon: reporticon
    });
    markers[id] = marker;
     marker.addListener('click', function() {
       showreportinfo(id,pos);
     });
  }

}

function moveToReport(id){
  var thismarker = markers[id];
  map.setCenter(thismarker.position);
  var thisposition = {};
  thisposition['lat'] = thismarker.position.lat();
  thisposition['lng'] = thismarker.position.lng();
  showreportinfo(id,thisposition);

}

function showreportinfo(id,pos) {
  var distance = google.maps.geometry.spherical.computeDistanceBetween(new google.maps.LatLng(fixerlocation), new google.maps.LatLng(pos));
  var miles = (distance*0.000621371192).toFixed(2);
  $.ajax({
    method: 'Post',
    url: 'showreport',
    data: { report_id: id,distance:miles},
  });

  $(document).ajaxStop(function() {
    reportInfoWindow.setContent(document.getElementById("showreport").innerHTML);
    reportInfoWindow.setPosition(pos);
    reportInfoWindow.open(map);
  });
  //document.getElementById("distancemile").innerHTML = "Distance: " +miles + " miles";

}

function clearreportmarkers(){
  Object.keys(markers).forEach(function (key) {
    markers[key].setVisible(false);
  })
}

function clearshopmarkers(){
  Object.keys(shopmarkers).forEach(function (key) {
    shopmarkers[key].setVisible(false);
  })
}

function loadShops() {
  clearreportmarkers();
  document.getElementById("filtershop").style = "display: none";
  document.getElementById("shoptable").style = "display: table";
  var shops = gon.shops;
  document.getElementById("numshopfound").innerHTML = shops.length+ " shops found!";
  var i;
  for (i = 0; i < shops.length; i++) {
    var shop = shops[i];
    var id = shop.id;
    var address = shop.address;
    displayShop(id,address);
  }
  document.getElementById("filtername").value = "";
  document.getElementById("shoplabel").value = 0;
}

function loadsomeShops(){
  clearshopmarkers();
  document.getElementById("shoptable").style = "display: none";
  var filtername = document.getElementById("filtername").value;
  var label = document.getElementById("shoplabel").value;
  $.ajax({
    method: 'Post',
    url: 'filtershop',
    headers: {
  'X-Transaction': 'POST Example',
  'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  },
    data: { filtername:filtername,shoplabel:label}
  });
  $(document).ajaxStop(function() {
    document.getElementById("filtershop").style = "display: table";
    var shops = gon.filteredshops;
    document.getElementById("numshopfound").innerHTML = shops.length+ " shops found!";
    var i;
    for (i = 0; i < shops.length; i++) {
      var shop = shops[i];
      var id = shop.id;
      var address = shop.address;
      displayShop(id,address);
    }
    shops = null;
  });


}


function displayShop(id,address){
  if (shopmarkers[id]!=null){
    shopmarkers[id].setVisible(true);
  } else {
    geocoder2.geocode( { 'address': address}, function(results, status) {
      if (status == 'OK') {
        var lat = results[0].geometry.location.lat();
        var lng = results[0].geometry.location.lng();
        var pos = {
          lat: lat,
          lng: lng
        };
        var shopicon = {
          url: "/fixicon.png", // url
          scaledSize: new google.maps.Size(50, 50), // size
        };
        var marker = new google.maps.Marker({
          position: pos,
          map: map,
          icon: shopicon
        });
        shopmarkers[id] = marker;
         marker.addListener('click', function() {
           showshopinfo(id,pos);
         });
      } else {
        alert('Geocode was not successful for the following reason: ' + status);
      }
    });
  }



}

function showshopinfo(id,pos) {
  var distance = google.maps.geometry.spherical.computeDistanceBetween(new google.maps.LatLng(ownerlocation), new google.maps.LatLng(pos));
  var miles = (distance*0.000621371192).toFixed(2);
  $.ajax({
    method: 'Post',
    headers: {
  'X-Transaction': 'POST Example',
  'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  },
    url: 'showshop',
    data: { shop_id: id,distance:miles},
  });

  $(document).ajaxStop(function() {
    shopInfoWindow.setContent(document.getElementById("showshop").innerHTML);
    shopInfoWindow.setPosition(pos);
    shopInfoWindow.open(map);
  });
  //document.getElementById("distancemile").innerHTML = "Distance: " +miles + " miles";

}

function moveToShop(id){
  var thismarker = shopmarkers[id];
  map.setCenter(thismarker.position);
  var thisposition = {};
  thisposition['lat'] = thismarker.position.lat();
  thisposition['lng'] = thismarker.position.lng();
  showshopinfo(id,thisposition);

}
