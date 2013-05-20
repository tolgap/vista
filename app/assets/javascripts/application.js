// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

(function($){
  $(document).ready(function () {

    var container = $('#accordion-server');

    container.isotope({
      itemSelector : '.website',
      resizable : false,
      masonry: { columnWidth: container.width() / 2 }
    });

    $('.website .accordion-toggle').click( function() {
      window.setTimeout(function () {
        console.log("delay");
        container.isotope('reLayout');
      }, 250);
    });

  });
})(jQuery)