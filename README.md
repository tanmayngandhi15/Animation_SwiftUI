Description -> 

This SwiftUI project demonstrates various animation techniques using a combination of timers, rotation effects, scaling, and offset adjustments. The application animates images from an array, transitioning them through different sizes, rotations, and positions on the screen. It also includes a button to cycle through the images, providing an interactive element to the animations.

Features ->  

Rotational Animation: Continuously rotates the image by 360 degrees with a smooth easing effect.

Scaling Animation: Alternates the image size between 100x100 and 200x200 pixels.

Position Animation: Moves the image across different positions on the screen based on defined steps.

Interactive Image Cycling: A button to switch between different images in the array.


Implementation Details -> 

ObservableObject: AnimationManager class to manage animation states and logic.

Timers: Two scheduled timers to control rotation and position animations at different intervals.

GeometryReader: Used to get screen dimensions for calculating maximum offsets.

SwiftUI Animations: Leveraged SwiftUI's .animation and .withAnimation modifiers for smooth transitions.
