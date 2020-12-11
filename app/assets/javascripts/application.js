// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//

pusher = new Pusher('c1c5cb076e25349e91f6', {
    cluster: 'mt1',
    encrypted: true
});
var channel = pusher.subscribe('new');
channel.bind('new-action', function(data){
    out_string = data.username + " " + data.action + ":\n";
    for(i = 0; i < data.info.length; i++)
    {
        out_string = out_string + data.info[i][0] + " of " + data.info[i][1] + "\n";
    }
    alert(out_string);

});

