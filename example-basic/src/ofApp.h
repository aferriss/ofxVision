#pragma once

#include "ofxiOS.h"
#include "ofxVision.h"
#include "AVFoundationVideoGrabberFast.h"

class ofApp : public ofxiOSApp {
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);

        AVFoundationVideoGrabberFast grabber;
        ofImage videoImg;
        int w, h;
        ofFbo fbo;
    
        ofxVision vision;
        vector<ofPoint> pts;
};

