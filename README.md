this is my internship task -- animated circular progress indicator 

the task has a simple CI/CD pipeline that automates the release and build on pull and push requests

Explaination :-

So, for starters the project uses riverpod for effective state management :-

In the custom_progress_indicator.dart file 

CustomProgressIndicator Widget:

This widget watches the progressProvider to get the current progress value.
When the progress reaches 1.0 (100%), it calls the onComplete callback to show a completion dialog.
The circular progress indicator is drawn using a CustomPaint widget, with the progress value and colors passed as parameters.

_CircularProgressPainter:

This is a custom painter that draws the circular progress indicator.
The filled portion of the circle is drawn dynamically based on the progress value.
The unfilled portion is drawn with a dashed line using a custom method to create the dashed effect.

_createDashedPath:

This helper method creates a dashed path for the unfilled portion of the circle.
It calculates where the dashes and gaps should appear and draws them accordingly.

So,


In the paint method of the _CircularProgressPainter class, all the drawing logic is executed using the provided Canvas and Size objects. The rect is defined as a rectangle covering the entire widget area, while the radius is half the width, assuming the widget is square. For the unfilled portion of the circle, a dashed line is created. The unfilledPaint is configured with unfilledColor, a stroke style, and a width of 8, and a full circle path is drawn using addArc. The _createDashedPath method transforms this path into a dashed pattern by iterating over the path length and alternating between drawing and skipping segments based on the dashArray, which specifies the dash and gap lengths. For the filled portion, filledPaint is set with fillColor, and the arc is drawn based on the progress value. The sweep angle of the arc is calculated as progress * 2 * π, allowing the circle to fill dynamically from 0 to 100%. The shouldRepaint method always returns true, ensuring the widget updates whenever the progress changes, which effectively updates both the dashed and filled portions of the circular progress indicator.

Challenges :-

The main goal for me in this task was to just focus on state management and seperate the code accordingly 
the correct measures for the dashed lines were not accurate at first so had to experiment with different values until desired result was achieved.
also the logic used was derived completely on the basis of trial and error.


P.S
You can even check the releases to get an apk version for android use ;3 