#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    w = ofGetWidth();
    h = ofGetHeight();
    
    fbo.allocate(w, h, GL_RGB);
    
    grabber.setDevice(1);
    grabber.setContinuousAutoFocus();
    grabber.initGrabber(1280, 720);
    
    vision.setup(w, h);
}

//--------------------------------------------------------------
void ofApp::update(){
    grabber.update();
    
    
    // send the grabber pixel buffer to the vision framework
    vision.update(grabber.getRawVideoRef());
    
    // get face points, if detected
    pts = vision.getPoints();
    
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    fbo.begin();
    ofPushMatrix();
    // not sure why but avfoundation returns texture rotated
    ofRotate(90, 0, 0, 1);
    grabber.getTexture()->draw(0,-w,h, w);
    ofPopMatrix();
    fbo.end();
    
    
    
    fbo.draw(0,0);
    ofPushStyle();
    ofSetColor(255, 0, 0);
    
    // draw points
    for(int i =0; i<pts.size(); i++){
        ofDrawCircle(pts[i].x, pts[i].y, 3);
    }
    
    // draw bounding rect
    ofNoFill();
    ofRectangle r = vision.getBoundingBox();
    ofDrawRectangle(r);
    ofFill();
    
    ofSetColor(255);
    ofPopStyle();
    
}

//--------------------------------------------------------------
void ofApp::exit(){
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    grabber.focusOnce();
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
    
}
