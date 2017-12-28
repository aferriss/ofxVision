## ofxVision 

This addon is a work in progress experiment to try and get openframeworks running with Apple's new Vision Framework for facial landmark detection.  

The vision framework can do many things in addition to facial landmarks including: facial recognition, image classification, bar code detection, object tracking and detection, horizon detection, text detection, image alignment, and some machine learning classification. Currently this addon is focused on landmark detection as an alternative to ofxFaceTracker2 for iOS.

An example is included that uses a custom AVFoundationVideoGrabber that exposes the raw pixel buffer to be passed to the vision framework. It also reads the video feed directly to an ofTexture, so should be much faster than the stock AVFoundationVideoGrabber.  

You need to add a Privacy Camera Usage Description to the plist to get this working, as well as add the vision framework to the linked libraries and frameworks.

## Todo: 

- Multiple faces 
- Indiviudal features (eyes, lips, etc.)
- Pose Estimation 
- Blink detection?
- Compatibility with ARKit
- Image Classification and other Vision Framework features





