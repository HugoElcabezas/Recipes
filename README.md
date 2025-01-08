# Recipe App - iOS

## Summary
This project is an iOS app built with SwiftUI to display a list of recipes fetched from a remote API. The app features a dynamic list of recipes, each with details such as the recipe name, cuisine, and links to additional resources (e.g., source article and YouTube). Users can tap on a recipe's image to view a full-screen image along with the additional information.

## UML Class Diagram
Below is the UML class diagram that illustrates the architecture of the app:

![UML Diagram](UML%20classes.png)

## Application Video
Here is a video showing how the app works:

[Watch the demo video on YouTube](https://www.youtube.com/shorts/vRJs7Uj4grQ)

## Focus Areas
I prioritized the following areas:
- **Image Caching:** Ensured that images are fetched efficiently and cached on the device to reduce loading times.
- **Asynchronous Operations:** Utilized Swift’s async/await for handling network requests, making the app more responsive.
- **Testing:** Wrote unit tests to ensure that key parts of the app, such as image fetching and caching, work as expected.
- **User Experience:** Focused on providing a smooth experience, supporting both landscape and portrait orientations. Added simple functionality for image fetching and presentation, ensuring the app was intuitive.

## Time Spent
Approximately **7 hours** working on this project. The work was spread across multiple days, dedicating about **1 hour per day** to different aspects of the app, such as implementing core functionality, refining the UI, and writing tests. This distribution of time allowed me to incrementally improve the app while balancing other commitments.


## Trade-offs and Decisions
- **Trade-off 1:** I chose not to implement a complex UI in favor of focusing on the core functionality and backend integration. I also opted to simplify the image viewer functionality, focusing on presenting images without complex zoom or swipe features.
- **Trade-off 2:** I opted for simple disk caching instead of more advanced storage solutions to keep the app lightweight and straightforward.
- **Trade-off 3:** While I considered adding full-screen image interaction (such as opening images from where the user tapped, with background blur effects), I decided against it to avoid unnecessary complexity.

## Weakest Part of the Project
The weakest part of the project is the error handling for network requests, which could be more robust to handle various failure scenarios (e.g., network issues, server errors).

## Additional Information
- The app uses **URLSession** for network requests and stores images on disk using **FileManager**.
- **Testing:** I created simple mocks for testing and did not use external UI snapshot testing libraries.
- The app has been smoke tested for both **portrait** and **landscape** modes.
- The **full-screen image view** shows a preview when the user taps on an image. I initially considered implementing more sophisticated image navigation features, but chose simplicity for this version.
- **Good Practices:** The app follows good practices like separating views into subviews and organizing code into distinct folders.
- I considered implementing **TCA** (The Composable Architecture) but opted to stick with SwiftUI's built-in state management tools.
- For error handling, when an image fails to load, a system-provided fallback icon is displayed.

## Personal Note
I applied for this role after receiving my permanent resident visa. The job position initially seemed semi-senior, and given the company's higher expectations, I felt it could align well with my experience level. I have 4 years of experience as a Software Engineer, working on a variety of tasks, from UI adjustments to backend integration. At Insulet Corporation, I converted custom alerts into publishers, worked on migration projects using a tree-based navigation protocol, and contributed to making apps bilingual by localizing strings. I collaborated closely with UX teams and both manual and automated QA testers, ensuring seamless app functionality across different platforms. Now that I have my visa and I am awaiting my social security number, I am eager to move forward in the application process.
