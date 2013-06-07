(function($) {

  $(document).ready(function() {

    $('.search .sorting :input[name="sort"]').click( function() {
      $.get(
        $('.search-form').attr('action'),
        $('.search-form').serialize(),
        null,
        "script"
      );
    });
    
  })

})(jQuery);