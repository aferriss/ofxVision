## ofxVision 

This addon is a work in progress experiment to try and get openframeworks running with Apple's new Vision Framework for facial landmark detection.  



An example is included that uses a custom AVFoundationVideoGrabber that exposes the raw pixel buffer to be passed to the vision framework. It also reads the video feed directly to an ofTexture, so should be much faster than the stock AVFoundationVideoGrabber.  


You need to add a Privacy Camera Usage Description to the plist to get this working, as well as add the vision framework to the linked libraries and frameworks.

## Todo: 

- Multiple faces 
- Indiviudal features (eyes, lips, etc.)
- Pose Estimation 
- Blink detection?
- Compatibility with ARKit





