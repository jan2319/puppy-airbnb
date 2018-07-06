// function initSliter() {
//   const sliter = document.querySelector('#term-slider');
//   noUiSlider.create( slider, {
//     start: [20, 80],
//     connect: true,
//     range: {
//       'min': 0,
//       'max': 100
//     }
//   });
// }
// export { initSliter };

import noUiSlider from 'nouislider/distribute/nouislider.min.js';

// Detect slither and button elements
let range = document.getElementById('term-slider');
let readButton = document.getElementById('read-sliders');
let hiddenField = document.getElementById('smname');


var url = new URL(window.location.href );
var price_from = url.searchParams.get("price_from") || 0;
var price_to = url.searchParams.get("price_to") || 100;

noUiSlider.create(range, {

  start: [price_from, price_to],
  connect: true,
  step: 1,
    range: {
     'min': 0,
      'max': 100
    },
  behaviour: 'tap-drag',
  tooltips: true,
});

// Give the slider dimensions
range.style.width = '400px';

// clicking on the button return values for the filter
readButton.addEventListener('click', function(){
  let values = range.noUiSlider.get();
  var first = values[0];
  var second = values[1];

  var base = "/puppies";

  var url = new URL(window.location.href );
  var city = url.searchParams.get("city");
  console.log(city);

  base = base + "?city=" + encodeURIComponent(city) + "&price_from=" + first + "&price_to=" + second;

  window.location = base;
});

export { range };
