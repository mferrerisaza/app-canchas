import GMaps from 'gmaps/gmaps.js';

const addMarkersToMap =(mapElement, map) => {
  const markers = JSON.parse(mapElement.dataset.markers);
  map.addMarkers(markers);
  if (markers.length === 0) {
    map.setZoom(2);
  } else if (markers.length === 1) {
    map.setCenter(markers[0].lat, markers[0].lng);
    map.setZoom(16);
  } else {
    map.fitLatLngBounds(markers);
  }
}

const insertMapOnDOM = () => {
  const mapElement = document.getElementById('map');
  if (mapElement) { // don't try to build a map if there's no div#map to inject in
    const map = new GMaps({
      el: '#map',
      lat: 0,
      lng: 0,
      idle: function(e) {
        // console.log("boundries", e.getBounds());
        // console.log("lat", e.getCenter().lat());
        // console.log("lng", e.getCenter().lng());
      }
    })
    addMarkersToMap(mapElement, map);
  }
}

document.addEventListener("DOMContentLoaded", () => {
  insertMapOnDOM();
})

export default insertMapOnDOM;
// import { autocomplete } from '../components/autocomplete';
// autocomplete();

