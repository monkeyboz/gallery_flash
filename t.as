import caurina.transitions.*; myPhoto = new XML(); myPhoto.ignoreWhite = true; numimages = 0; selectedImage = 
1000000; myPhoto.onLoad = function(success) {
    //portfolioTag = this.firstChild;
    numimages = this.firstChild.childNodes.length;
    trace(numimages);
    spacing = 100;
    
    currentWidth = 0;
    
    for (i=0; i<numimages; i++) {
        this.picHolder = this.firstChild.childNodes[i];
        
        testing = thumbnails.attachMovie('thumbHolder', 'test'+i, thumbnails.getNextHighestDepth());
        testing.imageholder_mv.loadMovie(this.picHolder.attributes.thmb);
        testing._x = i*spacing;
        testing._width = 100;
        testing._height = 100;
        testing.title = this.picHolder.attributes.title;
        testing.main = this.picHolder.attributes.main;
        testing.mLoaded = false;
        
        thumbnails['test'+i];
        thumbnails._x = 90;
        
        testing.onEnterFrame = function(){
            if(this.imageholder_mv.getBytesTotal() > 100 && 
this.imageholder_mv.getBytesLoaded()/this.imageholder_mv.getBytesTotal() == 1){
                this._width = this._height = 100;
                this.loader_mv._visible = false;
                
                this.onRelease = function() {
                    currentWidth = 0;
                    
                    for(j=0; j<numimages;j++){
                        if(this == thumbnails['test'+j]){
                            selectedImage = j;
                            Tweener.addTween(thumbnails['test'+j], {_x:currentWidth, transition:'easeOut', 
time:1});
                            delete thumbnails['test'+j].onEnterFrame;
                            currentWidth += 300;
                            Tweener.addTween(thumbnails['test'+j], {_width:300, _height:300, 
transition:'easeOut', time:1});
                        } else {
                            Tweener.addTween(thumbnails['test'+j], {_x:currentWidth, transition:'easeOut', 
time:1});
                            currentWidth += 100;
                            Tweener.addTween(thumbnails['test'+j], {_width:100, _height:100, 
transition:'easeOut', time:1});
                        }
                    }
                };
                
                
                this.onRollOver = function (){
                    currentWidth = 0;
                    delete this.onEnterFrame;
                    for(k=0; k<numimages;k++){
                        if(this == thumbnails['test'+k] && k != selectedImage){
                            Tweener.addTween(thumbnails['test'+k], {_x:currentWidth, transition:'easeOut', 
time:1});
                            currentWidth += 150;
                            Tweener.addTween(thumbnails['test'+k], {_width:150, _height:150, 
transition:'easeOut', time:1});
                        } else if (k != selectedImage) {
                            Tweener.addTween(thumbnails['test'+k], {_x:currentWidth, transition:'easeOut', 
time:1});
                            currentWidth += 100;
                            Tweener.addTween(thumbnails['test'+k], {_width:100, _height:100, 
transition:'easeOut', time:1});
                        } else {
                            Tweener.addTween(thumbnails['test'+k], {_x:currentWidth, transition:'easeOut', 
time:1});
                            currentWidth += 300;
                        }
                    }
                }
            }
        }
        Tweener.addTween(thumbnails['test'+i], {_x:currentWidth, transition:'easeOut', time:1});
        currentWidth += 100;
        Tweener.addTween(thumbnails['test'+i], {_width:100, _height:100, transition:'easeOut', time:1});
        thumbnails._x = 90;
    }
    
    topwidth = 808;
    topline_mv._width = 0;
    Tweener.addTween(topline_mv, {_width:topwidth, transition:'easeOut', time:2, delay:.5});
};
this.onEnterFrame = function(){
    if(mousearea_mv._xmouse < 0){
        movement = -(mousearea_mv._xmouse);
    } else {
        movement = _xmouse;
    }
    
    if(mousearea_mv._xmouse > 0){
        if(mousearea_mv._xmouse > (mousearea_mv._width/2)+30){
            if(thumbnails._x > -Math.round(thumbnails._width-mousearea_mv._width)){
                Tweener.addTween(thumbnails, {_x: thumbnails._x - 40, transition:'easeOut', time:1});
            } else {
                thumbnails._x = -Math.round(thumbnails._width-mousearea_mv._width);
            }
        } else if (mousearea_mv._xmouse < (mousearea_mv._width/2)-30) {
            if(thumbnails._x < 90){
                Tweener.addTween(thumbnails, {_x: thumbnails._x + (40), transition:'easeOut', time:1});
            } else {
                thumbnails._x = 90;
            }
        }
    }
    
    if(thumbnails._x > 90){
        thumbnails._x = 90;
    }
}
function clearStage(){
    topline_mv._width = 0;
    clearGallery();
}
function clearGallery(){
    for(i=0;i<numimages;i++){
        thumbnails['test'+i].onRollOver;
        thumbnails['test'+i].onRelease;
        removeMovieClip(thumbnails['test'+i]);
    }
}
cover_btn.onRelease = function (){
    clearGallery();
    selectedImage = 1000000;
    myPhoto.load("photogallery.xml");
}
model_btn.onRelease = function (){
    clearGallery();
    selectedImage = 1000000;
    myPhoto.load('photogallery2.xml');
}
reel_btn.onRelease = function (){
    clearGallery();
    selectedImage = 1000000;
    myPhoto.load("photogallery.xml");
}
onset_btn.onRelease = function (){
    clearGallery();
    selectedImage = 1000000;
    myPhoto.load('photogallery2.xml');
}
