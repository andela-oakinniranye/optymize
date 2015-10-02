(function ($) {
	"use strict";


    jQuery(document).ready(function($){

        // jQuery sticky menu
        $(".header-bottom").sticky({topSpacing:0});


        // jQuery OwlCarousel
        var owl = $('.slide-list');

        owl.owlCarousel({
            loop:true,
            margin:30,
            autoplay: 5000,
            nav:true,
            navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
            items:1
        });


        owl.on('translated.owl.carousel',function(e){
            $(".active .slide-text").addClass("fadeInUp").show();
        });

        owl.on('translate.owl.carousel',function(e){
            $(".active .slide-text").removeClass("fadeInUp").hide();
        });
        
    });


    jQuery(window).load(function(){
        $('.grid-blog').masonry({ singleMode: true });

        // Preloader
        $("#preloader").fadeOut(500);

        $(".active .slide-text").addClass("fadeInUp").show();
    });


}(jQuery));
