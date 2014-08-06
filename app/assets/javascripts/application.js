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
//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require turbolinks.redirect
//= require jquery.remotipart
//= require vendor/bootstrap
//= require vendor/markdown
//= require vendor/jquery/jquery.resize
//= require vendor/jquery/jquery.scrollTo.min
//= require vendor/jquery/jquery.iframe-transport
//= require dashboard
//= require vendor/timeago
//= require vendor/locales/timeago.en
//= require vendor/soundmanager2-nodebug-jsmin
//= require chatting
//= require jquery.atwho/index

soundManager.setup({
  onready: function() {
    // $(document).bind('ready page:load', function(){
      window.alertSound = soundManager.createSound({
        id: 'alert',
        url: '/assets/ding.mp3',
        autoLoad: true,
        autoPlay: false,
        volume: 50
      });
    // })
  }
});
