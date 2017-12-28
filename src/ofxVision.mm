//
//  ofxVision.m
//  face
//
//  Created by Adam Ferriss on 12/13/17.
//

#import "ofxVision.h"

#import <Foundation/Foundation.h>
#include <Vision/Vision.h>
#import <AVFoundation/AVFoundation.h>

#define let auto const;

@interface VisionRequest () <AVCaptureVideoDataOutputSampleBufferDelegate>

//@property (nonatomic, strong) AVCaptureSession * session;
//@property (nonatomic, strong) AVCaptureVideoPreviewLayer * previewLayer;
//@property (nonatomic, strong) dispatch_queue_t captureQueue;

@property (nonatomic, strong) VNFaceObservation * faceObservation;
@property (nonatomic, strong) VNRequest * visionFaceLandmarkRequest;
@property (nonatomic, strong) VNSequenceRequestHandler * sequenceRequestHandler;

@end

@implementation VisionRequest

- (void) viewDidLoad
{
    [super viewDidLoad];
    pointCount = 0;
}

-(void) setupFaceLandmarkRequest {
    auto const faceRequest = [[VNDetectFaceLandmarksRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        
        
        void (^finish)(VNFaceObservation *, NSString *) = ^(VNFaceObservation * ob, NSString * text) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _faceObservation = ob;
                pointCount = ob.landmarks.allPoints.pointCount;
                boundingBox = ob.boundingBox;
                
                points.clear();
                for(int i = 0; i<pointCount; i++){
                    points.push_back(ob.landmarks.allPoints.normalizedPoints[i]);
                }
            
            });
        };
        
        if (error) {
            return finish(nil, error.description);
        }
        
        auto const observations = request.results;
        
        if (!observations.count) {
            return finish(nil, @"no observations");
        }
        
        VNFaceObservation * observation = nil;
        for (VNFaceObservation * ob in observations) {
            if (![ob isKindOfClass:[VNFaceObservation class]]) {
                continue;
            }
            if (!observation) {
                observation = ob;
                continue;
            }
            if (observation.confidence < ob.confidence) {
                observation = ob;
            }
        }
        
        finish(observation, [NSString stringWithFormat:@"(%.0f%%)", observation.confidence * 100]);
    }];
    
    _visionFaceLandmarkRequest = faceRequest;
}

- (void) requestObservation:(CVPixelBufferRef) pixelBuffer {
    if (!_sequenceRequestHandler) {
        _sequenceRequestHandler = [[VNSequenceRequestHandler alloc] init];
    }
    
    if(pixelBuffer){
        
        // right now only supported vertical orientation
        [_sequenceRequestHandler performRequests:@[_visionFaceLandmarkRequest] onCVPixelBuffer:pixelBuffer orientation:kCGImagePropertyOrientationRight error:NULL];
    }
}

- (VNFaceObservation*) getObservation {
    return _faceObservation;
}

- (NSUInteger ) getPointCount {
    
        return pointCount;
}

@end

ofxVision::ofxVision(){
    vision = [VisionRequest alloc];
}

ofxVision::~ofxVision(){
    if(vision){
        [vision release];
        vision = nil;
    }
}

void ofxVision::setup(int _width, int _height){
    width = _width;
    height = _height;
    
    [vision setupFaceLandmarkRequest];
}

void ofxVision::update(CVPixelBufferRef pixelBuffer){
    [vision requestObservation:pixelBuffer];
}

VNFaceObservation * ofxVision::getObservation(){
    
    return [vision getObservation];
}

vector<ofPoint> ofxVision::getPoints(){
    vector<ofPoint> pts;
    pts.clear();
    
    if(vision){
        
        CGRect bb = vision->boundingBox;

        for(int i = 0; i< vision->pointCount; i++){
            ofPoint pt;
            
            pt.x = ((float)vision->points[i].x * bb.size.width + bb.origin.x) * width;
            pt.y = height - ((float)vision->points[i].y * bb.size.height + bb.origin.y) * height;
            
            pts.push_back(pt);
        }
        
    }
    
    return pts;
}

ofRectangle ofxVision::getBoundingBox(){
    CGRect bb = vision->boundingBox;
//    ofDrawRectangle(r.x * w, (h - r.y * h) - (r.height*h), r.width * w, r.height * h);
    // scale normalized coords back to ofApp coords
    return ofRectangle(bb.origin.x * width, (height - bb.origin.y * height) - (bb.size.height*height), bb.size.width * width, bb.size.height * height);
}
