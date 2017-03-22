$(document).on('change', '#city_booking', function(){
  $.ajax({ url: '/bookings/edit',
    data: 'selectedCity=' + this.value,
    success: function(data) {
      $('#cleaners').html(data);
    }
  })
});
