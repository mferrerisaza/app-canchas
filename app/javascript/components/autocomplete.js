function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var businessAddress = document.getElementById('business_address');

    if (businessAddress) {
      var autocomplete = new google.maps.places.Autocomplete(businessAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(businessAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocomplete };
