import mapboxgl from '!mapbox-gl';

// look up each motel on gmaps
// get latlng from url
// update seeds
// get data from motels model 
// 	embed the coordinates in the #map domNode with a data attr
// 	embed the API key in the same way
// pull both pieces of data from the domNode
// make sure you supply LNGlat not LATlng to mapbox
mapboxgl.accessToken = "pk.eyJ1IjoiYmpvaG5zb245IiwiYSI6ImNrbGlib3dxYTJnd3Qyb3F0MXhrZzdoZHIifQ.5Yn7lVUa3_gRq9PVJSQ8Ig";
const lnglat = new mapboxgl.LngLat(-104.8360657, 39.9590737);

const map = new mapboxgl.Map({
  container: "map", // container ID
  style: "mapbox://styles/mapbox/streets-v11", // style URL
  center: lnglat,
  zoom: 9, // starting zoom
});
