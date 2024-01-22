# LucraTakeHomeProject

This is the repo for the Lucra Take Home assignment.
This app is primarily built in SwiftUI, using MVVM as the architecture of choice.

To run this app, simply clone and run, no additional setup should be required. However, if any issues come up, please open an issue on the repo.

This app makes use of the data received from querying the Imgur API for album and gallery data.
Images are rendered using AsyncImage in a card style view for both Album and Gallery Views.

A third view was created to render the image in a "full screen" style display, though due to time constraints, it was a simple AsyncImage embedded in a NavigationLink using GeometryReader to render the image as close to full screen as possible.

One library considered was CachedAsyncImage, in an attempt to cache images so as to not put stress on the network as you scroll and images dequeue, however the library in question was causing project compilation issues.

The content type returned from the Imgur API varied between various image types as well video, some filtering logic was needed to prevent AsyncImage from trying to load unsupported types.

Overall this was a very fun project to work on, and implementing this project helped solidify SwiftUI concepts.
