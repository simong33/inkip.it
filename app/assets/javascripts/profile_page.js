// PROGRESS BAR

$(document).ready(function(){
  if ($('#progress-bar-profile').length) {
    var bar = new ProgressBar.Line('#progress-bar-profile', {
      strokeWidth: 2,
      color: "#FFF",
      trailColor: "#eee",
      trailWidth: 1,
      from: {color: '#6C5B7B'},
      to: {color: '#355C7D'},
      duration: 1400,
      easing: 'easeInOut',
      step: (state, bar) => {
        bar.path.setAttribute('stroke', state.color);
      }
    });
    bar.animate(gon.wordcount_ratio)
  }
});


// ADDRESS AUTOCOMPLETE

// function initializeAutocomplete(id) {
//   var element = document.getElementById(id);
//   if (element) {
//     var autocomplete = new google.maps.places.Autocomplete(element, { types: ['(cities)'] });
//     google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
//   }
// }

// function onPlaceChanged() {
//   var place = this.getPlace();

//   for (var i in place.address_components) {
//     var component = place.address_components[i];
//     for (var j in component.types) {  // Some types are ["country", "political"]
//       var type_element = document.getElementById(component.types[j]);
//       if (type_element) {
//         type_element.value = component.long_name;
//       }
//     }
//   }
// }

// google.maps.event.addDomListener(window, 'load', function() {
//   initializeAutocomplete('user-location-input');
// });

function initialize() {

 var options = {
  types: ['(cities)']
 };

 var input = document.getElementById('user-location-input');
 var autocomplete = new google.maps.places.Autocomplete(input, options);
}

google.maps.event.addDomListener(window, 'load', initialize);
