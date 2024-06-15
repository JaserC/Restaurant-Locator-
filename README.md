# Food Finder

## Student Information
Name: Jaser Chowdhury   

CSE netid: jaserc

email: jaserc@uw.edu

## Design Vision
Tell us about what your design vision was.
 - Functionally
 - Aesthetically
 - How are you nudging people toward patios on sunny days?

At first, I had very lofty aims. I wanted to make it a multi-view application that would navigate from a welcome image to a home page and some other more detailed views. Alas, time was not permitting, so I settled on a single view with a list scroll. I ultimately wanted to give users a quick overview of each restaraunt and provide as much information as possible so I settled on creating quick tiles. Each tile displays the core information and I wanted to make it a bit more aesthetic so I included images to convery information. For example, I wanted the cuisine field to be portrayed by an image rather than text so I found a nice icon set and figured out the conversion. I also wanted to add a bit of color rather than the usual black and white. With this, I decided on making my app dark-mode. I haven't done it before but I thought I used the right blend of black and grey to achieve that look. It also led to me introducing a gradient, which was pretty cool to learn, for the title. 

To urge people towards patios on sunny days, I added a conditional sort. If the weather is sunny, I take my sorted venue list (already sorted by distance) and make an additional sort to put patios first. This throws in the patio suggestion while keeping the distance sorting, which I think is the right behavior. 

Where in your repo can we find the sketches that you made? 

The image is called sketch.jpg and is in my assets folder.

If your final design changed from your initial sketches please explain what changed and why.

I grew too busy and then midterms were upon me and I had to skim down the design so that I could complete the project at all. The multiple views were something we would implement with the Journals anyway, so I felt that it wasn't too important to squeeze that functionality into this one. 

## Resources Used
Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.

Remember to include all online resources (other than information learned in lecture or section and android documentation) such as Stack Overflow, other blogs, students in this class, or TAs and instructors who helped you during Office Hours. If you did not use any such resources, please state so explicitly.

Answer here: 

Professor Bricker
Crowd-sources restaraunt data (venues.json)
Code from weather project
https://stackoverflow.com/questions/51686868/gradient-text-in-flutter
https://pub.dev/packages/geolocator
https://flutter.github.io/samples/#
https://pub.dev/packages/simple_gradient_text
https://stackoverflow.com/questions/61052629/how-to-add-multiple-changenotifierprovider-in-same-type-in-flutter
https://anamiminoshvili.com/project/adobe-xd
https://api.flutter.dev/flutter/widgets/ClipRect-class.html
https://stackoverflow.com/questions/50198885/how-to-use-an-image-instead-of-an-icon-in-flutter


## Reflection Prompts

### New Learnings
What new tools, techniques, or other skills did you learn while doing this assignment?

How do you think you might use what you learned in the future?

Answer here: I learned a lot in a lot of different realms. First off, I went to Office Hours for the first time and learned some very important debugging tips when it comes to Flutter. Professor Bricker taught me how to set breakpoints and helped me set up the emulator. I used to just be shooting blind, but now I have a mobile view so that I can see how my app turns out. The use of teh ListView widget is also something I look forward to using in the future. i can think of a lot of use cases already. I also picked up some more things about styling. Using a gradient for text was a good learning experience and I hope to apply it to my designs going forward when its called for. 

## Challenges
What was hard about doing this assignment?
What did you learn from working through those challenges?
How could the assignment be improved for future years?

Answer here: My challenges with this assignment were largely self-inflicted. I didn't have the time and eventually it just slipped away. It has been a crazy few weeks and honestly I'm just happy to be done with it and finally caught up. Going forward, I thought the assignment was fine. We were given reasonable boiler plate code and had context for the stuff we hadn't epxlicitly done before. I don't think there was a point that I truly got stuck except for maybe with the providers. It's still a relatively new concpet to me, so figuring out some of the syntax and how these components integrate with each other was a tad difficult. Otherwise, I thought this assignment was just tedious with the way you had to completely craft the view from scratch. 

### Mistakes
What is one mistake that you made or misunderstanding that you had while you were completing this assignment?

What is something that you learned or will change in the future as a result of this mistake or misunderstanding?

Answer here: My biggest issue with this assignment was when I couldn't get my distances to be correct. They were super large, I',m talking millions of meters as opposed to something normal. I went to OH for this issue and after a long working process where I also learned some better ways of doing other things, we finally realized that I had duplicate fields in 2 different providers and that there was a mismatch happening which caused the data to be incorrectly assigned. I think going through that entire debugging process has taught me a lot about providers, especially about how to navigate having multiple together. Going forward, i don't think I'm making that mistake again. Also, I'm most definitely going to OH more often because that was pretty fun. 

### Optional Challenges
Tell us about what you did, learned, and struggled with while tackling some of the optional challenges.

Didn't attempt them