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

🌟 Bonus Features:  
❌ .  

Sources / Attributions:  
Asynchronous Class Lecture Videos  
IBOutlet Collection Tutorial (https://www.youtube.com/watch?v=mr7pJB2eyK4)  
UIView.Animate Tutortial (https://www.hackingwithswift.com/example-code/uikit/how-to-animate-views-using-animatewithduration)  
UIViewProperty Animator Tutorial (https://www.hackingwithswift.com/example-code/uikit/how-to-animate-views-using-uiviewpropertyanimator)  
