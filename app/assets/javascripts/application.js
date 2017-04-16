// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .


function goTop(min_height) {
    $(".goTop").click(
        function() {
            $('html,body').animate({
                scrollTop: 0
            }, 700);
        });
    min_height=min_height?min_height:3000;
    $(window).scroll(function() {
        var s = $(window).scrollTop();
        if (s > min_height) {
            $(".goTop").fadeIn(100);
        } else {
            $(".goTop").fadeOut(200);
        }
    });
}


$(function() {
    goTop();
});
