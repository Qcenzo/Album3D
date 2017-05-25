## Qcenzo *Album3d* Library ##
4/13/2017 5:40:25 PM 
### Runtime Version ###
- Flash player 16.0
- AIR 16.0
### Class Diagram ###
![](http://www.qcenzo.com/2017/apps/album3d/0.jpg)
### Usage ###

	 var atlas:BitmapData;
	 var numIcons;
	 
	 var album:Album = new Album(stage);	
	 album.playVideo("bgv.flv", onComplete); 
	 album.addTexture(atlas, numIcons);
	 album.addEffect(new Logo("Qcenzo"));
	 album.addEffect(new Sphere()); 
	 
	 function onComplete():void 
	 {	
	 	trace("complete");	
	 }
	 
### Test ###
[http://www.qcenzo.com/2017/apps/album3d/test.html](http://www.qcenzo.com/2017/apps/album3d/test.html)
