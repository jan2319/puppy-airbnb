function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var puppyStreet = document.getElementById('puppy_street');
    var puppyZipcode = document.getElementById('puppy_zipcode');
    var puppyCity = document.getElementById('puppy_city');
    var puppyCountry = document.getElementById('puppy_country');

    var fillForm = function(place) {
     for (var i = 0; i < place.address_components.length; i++) {
        var addressType = place.address_components[i].types[0];
        var value = place.address_components[i].long_name;

        console.log(addressType);

      }
    };

    if (puppyStreet) {
      var autocomplete = new google.maps.places.Autocomplete(puppyStreet, { types: [ 'geocode' ] });

      autocomplete.addListener('place_changed', function () {
          var place = autocomplete.getPlace();
          fillForm(place);
      });

      google.maps.event.addDomListener(puppyStreet, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocomplete };
