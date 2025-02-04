# Assignment 4 - Tic Tac Toe  
Date: 1/30/2025  
Author: Jerry Shi  
Username: jerryshi  

Description:  
"Tic Tac Toe" displays a grid and two gesture controllable views for users to be able to play tic tac toe locally with their friends.  

Learning Topics:  
Gesture Recognizers, UIBezierPath to draw custom images  

Features Checklist (In Progress):  
📝 Required Features:  
✅ Create a subclass of UIView called GridView. Override the draw(_ rect: CGRect) function and use UIBezierPath to draw a grid (ie. 2 horizontal and 2 vertical lines).  
✅ Add the GridView to your storyboard by dragging out a view and setting the custom class to GridView.  
✅ Add nine square subviews to the ViewController to represent each square in the grid.  
✅ Add an outlet collection linking to each square subview in viewController.
✅ Add UILabel or UIImageViews for the X and O pieces (make sure to enable user interaction after adding)  
✅ Add a UIGestureRecognizer to each piece so the user can drag them around the screen  
✅ Create a UIView subclass called InfoView and add a label and button  
✅ Add rounded corners, a border color, and aborder width to the InfoView view by overriding awakeFromNib() and CALayer.  
✅ Add info button. When user taps, update infoView text to instructions and animate infoView to move from offscreen to center of screen.  
✅ When user taps "OK" button in infoVoew, animate infoView to from center of screen to offscreen. Reset the infoView to above screen to reset for future animations.  
✅ "X" piece starts the game.  
✅ Set piece whose turn it is to alpha of 1.  
✅ Use an animation to show to user(s) whose turn it is. User interaction is disabled until animation is completed.  
✅ When user drops piece on unoccupied tile, animate the piece "snapping" in place on the grid.  
✅ When user drops piece on a location outside the grid, animate the piece "snapping" back to starting position on the grid.  
✅ When a piece occupies a spot on the grid, make sure it is no longer user interactable (NOTE: In my implementation, I don't leave the game piece on the grid. Instead, I unhide the square view and set their text & appearance to match the piece that was placed there. Then, I hide the original game piece and move it back to its original spot. See my viewController for more details.)  





  


🌟 Bonus Features:  
❌ .  

Sources / Attributions:  
Asynchronous Class Lecture Videos  
IBOutlet Collection Tutorial (https://www.youtube.com/watch?v=mr7pJB2eyK4)  
UIView.Animate Tutortial (https://www.hackingwithswift.com/example-code/uikit/how-to-animate-views-using-animatewithduration)  
UIViewProperty Animator Tutorial (https://www.hackingwithswift.com/example-code/uikit/how-to-animate-views-using-uiviewpropertyanimator)  
Transform: CGAffine Transform Tutorial (https://www.hackingwithswift.com/read/15/4/transform-cgaffinetransform)  
Bring Subview to Front Tutorial (https://www.hackingwithswift.com/example-code/uikit/how-to-bring-a-subview-to-the-front-of-a-uiview)  
UIPanGestureRecognizer Tutorial w/ States (https://cocoacasts.com/swift-fundamentals-working-with-pan-gesture-recognizers-in-swift)  
