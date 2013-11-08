// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

$(document).ready(function(){
	// cache your tabs selector
  var $tabs = $('.nav li');
  // see what page you are currently on to compare to tabs
  var pageLocation = window.location.pathname;
  // remove the Active class from the tabs
  $tabs.removeClass('active');

  // loop through your tabs
  $tabs.each(function () {
    var $tab = $(this);
    var tabHref = $tab.find("a[href]").attr('href');
   
    if (tabHref == pageLocation){
      $tab.addClass('active');
    }
  });
}); 

