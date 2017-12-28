//
//  ofxVision.h
//  face
//
//  Created by Adam Ferriss on 12/13/17.
//

//#ifndef ofxVision_h
//#define ofxVision_h
//
//#include <Vision/Vision.h>
//#import <AVFoundation/AVFoundation.h>
//
//#endif /* ofxVision_h */
#pragma once

#import <Foundation/Foundation.h>
#include <Vision/Vision.h>
#import <AVFoundation/AVFoundation.h>
#include <vector>
#include "ofBaseTypes.h"

class ofxVision;

@interface VisionRequest : NSObject {
    @public
    NSUInteger pointCount;
//    const CGPoint * points;
    CGRect boundingBox;
    vector<CGPoint> points;
}

@end

class ofxVision {
    public:
        ofxVision();
        ~ofxVision();
        VisionRequest * vision;
        void setup(int width, int height);
        int width;
        int height;
//        void update(CGImageRef pixelBuffer);
        void update(CVPixelBufferRef pixelBuffer);
//        VNFaceObservation * observation;
        VNFaceObservation * getObservation();
//        float getConfidence();
        vector<ofPoint> getPoints();
        ofRectangle getBoundingBox();
    
};
