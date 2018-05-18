import clearTheDOM from '../components/datetabs.js'
import {fetchSchedule, retriveFieldCardInfo} from '../components/datetabs.js'
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

const updateMap = (e, map, mapElement) => {
  if (document.readyState === "complete") {
    document.querySelector(".loader-div").style.visibility = "visible";
    clearTheDOM();
    fetchSchedule(e.getBounds(), retriveFieldCardInfo, "map");
    const markers = JSON.parse(mapElement.dataset.markers);
    map.addMarkers(markers);
    setTimeout(() => { document.querySelector(".loader-div").style.visibility = "hidden" }, 1000);
  }
}

const insertMapOnDOM = () => {
  const mapElement = document.getElementById('map');
  if (mapElement) { // don't try to build a map if there's no div#map to inject in
    const map = new GMaps({
      el: '#map',
      lat: 0,
      lng: 0,
      idle: function (e) {
        updateMap(e, map, mapElement)
      },
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

