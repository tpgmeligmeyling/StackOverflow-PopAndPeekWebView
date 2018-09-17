//
//  ImageFullScreen.js
//  PopAndPeekWebView
//
//  Created by Thomas Gmelig Meyling on 13/09/2018.
//  Copyright © 2018 jackpotsvr. All rights reserved.
//

function addEvent(obj, evType, fn) {
    if (obj.addEventListener) {
        obj.addEventListener(evType, fn, false);
        return true;
    } else if (obj.attachEvent) {
        var r = obj.attachEvent('on' + evType, fn);
        return r;
    } else {
        alert('Handler could not be attached');
    }
}

function addImageFullScreenEvent() {
    var images = document.getElementsByTagName('img');
    for (var i = 0; i < images.length; i++) {
        var wrapperLink = document.createElement('a');
        images[i].parentNode.insertBefore(wrapperLink, images[i]);
        wrapperLink.href = images[i].src;
        wrapperLink.appendChild(images[i]);
        
        var imageBase64Source = images[i].src;
        addEvent(images[i], 'touchstart', function() {
//            window.webkit.messageHandlers.enlargeImageNotificationKey.postMessage(imageBase64Source);
        });
    }
}

addImageFullScreenEvent();
