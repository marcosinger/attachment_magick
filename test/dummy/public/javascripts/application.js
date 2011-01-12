$(window).load(function(){
	attach.startup();
});

$(document).ready(function(){
	link.startup();
});

var link = {
	startup: function(){
		this.canEffect 	= true;
		
		$('.header h4 a').hover(function(){ link.pulse($(this)); });
	}, 
	pulse: function(el){
		if ( this.canEffect ) {
			el.fadeToggle(100, function(){ 
				link.locked();
				el.fadeToggle(100, function(){ link.unlocked(); }); 
			});			
		}
	},
	locked: 	function(){ this.canEffect = false; },
	unlocked: 	function(){ this.canEffect = true; }
}

var attach = {
	startup: function(){
		$('.open_attachment').click(function(){ attach.showMe($(this)); });
		var that 			= this;
		var $container_19 	= $('.grid_19:not(".menu"):first');
		this.max_height 	= 0;
		
		$.each( $container_19.find("img"), function(index, el) {  
			var $container 		= $(el).parent();
			var image_height 	= $(el).height();

			if ( that.max_height < image_height ) { that.max_height = image_height; }
		});
		
		$('.grid_19:not(".menu")').animate({height : this.max_height}, 'slow', 'linear');
	},
	showMe: function($el){
		var style 				= $el.text().replace("|", "");
		var $container_images 	= $el.parents(".menu").next();
		var image 				= $container_images.find(".attachment-"+style);
		var image_to_show 		= image.clone();
		
		$('li.grid_2.rpush_2').removeClass('active');
		$el.parent().toggleClass('active');
		image.remove();
		$container_images.append(image_to_show);
		
		image_to_show.fadeIn(250, function(){
			$.each( $container_images.find("img:not(.attachment-"+style+")" ), function(index, el) {
				$(el).fadeOut();
			});
		});
	}
}