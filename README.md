## Qcenzo **album3d** Library ##
4/13/2017 5:40:25 PM 
### Runtime Version ###
- Flash player 16.0
- AIR 16.0
### Class Diagram ###
![](http://www.qcenzo.com/2017/apps/album3d/0.jpg)
### Usage ###

	 var a:Album = new Album(stage);	
	 a.playVideo("bg.flv", onComplete);	
	 a.addTexture(0, photos, 1024);
	 
	 function onComplete():void 
	 {	
	 	trace("complete");	
	 }
