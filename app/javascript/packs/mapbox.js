import mapboxgl from "mapbox-gl";

mapboxgl.accessToken =
  "pk.eyJ1IjoiYmpvaG5zb245IiwiYSI6ImNrbGlib3dxYTJnd3Qyb3F0MXhrZzdoZHIifQ.5Yn7lVUa3_gRq9PVJSQ8Ig";
const map = new mapboxgl.Map({
  container: "map", // container ID
  style: "mapbox://styles/mapbox/streets-v11", // style URL
  center: [-74.5, 40], // starting position [lng, lat]
  zoom: 9, // starting zoom
});
