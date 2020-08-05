# stanwoodtask

Stanwood iOS assignment implementation: https://gist.github.com/talezion/d5e94fb838a8f62ec8898a06d551ea69.
This implementation is based off my previous implementation that can be found here: https://github.com/ianlaylandhoughton/stanwoodtask. I used the old code as a reference and borrowed some of the networking requests and associated models but wanted to try a different implementation to show both a different set of skills and that I was taking this task seriously by not simply reusing my previous assignment. 

## Architecture

The app is written in Swift 5 using the MVVM architecture. I have still used protocol oriented programming as this allows for easier testing but I chose not to go as granular with my objects. Instead of sharing a datasource and delegate, I have kept that code in the view controller and have subclassed the view controller as the UI and logic is nearly identical between both main screens. I used localisable strings for easy localisation of the project, as well as colours in the asset catalogue. 

## Things I didn't implement

I haven't implemented the Search repos feature in major bonus points section but I have implemented everything else asked of me on the assignment. I used a collection view for the main UI as this made designing a different UI for the iPad easier. The iPad UI is a horizontal grid layout to make better use of the space and to see more repos on one screen. Both layouts use the same collection view cell and are controlled by having different constraints setup per size classes. I have also added 1 unit test class simply as a demonstration. 

## Thing's I'd do differently

I had issues changing the font and using the navigation controller large titles. Even without using a custom font, I am still getting an auto layout constraint warning when using large titles and the default values so it seems like an Xcode bug. I spent some time trying to resolve this but couldn't get a solution. I probably wouldn't have look at my old project next time round either as I felt obliged to do things differently which may have made the code a bit messier in places. I would also not use storyboards and simply use xib files instead (I find storyboards cumbersome when you have many views and they are a pain when you have merge conflicts). However I figured for the size of this project and the fact I would be the only developer, it would be fine to use storyboards. I would also used a better font and colour extension and set them programmatically rather than setting things in IB but again, I felt it fine for this project and I have added demonstrations of how to use font and colour extensions. I would've also like to have spent some more time with the Stanwood core library and use some more of the helper functions available. 

## Thing's I've learnt

I don't usually use stack views that often but I chose to use one for the repo detail page as it fit perfectly for the needs of the UI. I also rediscovered the built in system icons which I found after searching for similar icons on the web! I learned a bit about property wrappers when writing the user defaults wrapper but I didn't use the code in the end. I felt my knowledge of Swift had improved from the last time I did the task and I'm happy with my solution (and I hope you are too!)