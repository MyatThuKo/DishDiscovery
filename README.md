## Dish Discovery
The Dish Discovery is a simple tool designed to help the users discover, filter, and view recipes from a wide variety of cuisines. 
The app fetches data from an online recipe API, allowing users to browse through recipes, sort by name or cuisine, and search for specific dishes.

On main screen, you can see a search bar, filter button and sort button to make it easier for the user to look for a cuisine they desire. 
By default, a list of all the available cuisines will be shown and when tapping each cuisine, the detail screen will be presented. 

Each recipe row contains an image, and a vertical stack of title, and subtitle, stacked horizontally. 
The detail view shows a larger image of the cuisine with a large title underneath, followed by a subtitle. 
To view the full recipe, the user can click "Visit Recipe Website" button or watch a YouTube video at the bottom of the screen. 

The app is built using `SwiftUI` framework to ensure a smooth and responsive experience, and relies on asynchronous networking to fetch and display the data; with a focus on simplicity, and clean design, 

## Steps to Run the App
- Clone the repository
```
git clone https://github.com/MyatThuKo/DishDiscovery.git
```
- Open the project in Xcode
- Install Package Dependencies (if required)
- Build and run the app on simulator

## Focus Areas:
- View Model and Testablility
  - I focused on creating a view model where I can ensure a proper state management by adding a loading state (initial, loading, loaded and error)
  - I Also focused on dependency injection to make view model testing easier.
- UI Design
  - Chose `SwiftUI` instead of `UIKit` to have more responsive interface.
  - Chose simplicity and add buttons such as sorting, searching and filtering to ease in finding the recipe
  - Added a button on details view to let the users know that they can view full recipe details on a desinated web page.
  - Embeded a YouTube video player view so that the users don't need to leave the app to watch the recipe video.
  - Added colors for labels, buttons and background on both light mode and dark mode 

## Time Spent:
- Total time spend: Approximately 4:30 hours
  - Initial search & setup for package dependencies: 1 hour
  - Architecture and UI Implementation: 2 hours
  - Unit tests: 30 mins
  - Optimization and Refinement on colors and designs: 1 hour 

## Trade-offs and Decisions: 
- Defer Removal
  - Initially, I used a defer statement for setting the loading state, which caused incorrect behavior during error handling.
  - This was refactored to set the state explicitly after successful or failed fetches.
- Dependency Injection
  - I decided to use dependency injection to make the view model more testable, though this added some initial complexity to the project.
- Error Handling
  - I opted for simple error messages in the UI rather than more detailed error reporting (e.g., using a custom alert system).
  - This was a trade-off to keep the UI clean and simple, prioritizing core functionality over complexity.

## Weakest Part of the Project:
- Error Handling in UI
  - Although errors are logged and displayed via the loadingState, the app currently lacks a comprehensive user-facing error handling system (like showing alerts or retry options when network errors occur).
- Unit Tests Converage:
  - While view model and service are well-testeed with mocks, I didn't include testing for the UI or integrations tests for the view components.
  - I have used Snapshot testing previously at M1 Finance, but wasn't able to find the package we used. 

## External Code and Dependencies: 
Installed using Swift Package Manager
- SDWebImage
  - SDWebImageSwiftUI: To use `WebImage` for efficient image loading and caching in SwiftUI views 
- Alamofire
  - Used it in the past personal project, that's why used in this project to handle network requests and to decode JSON data
- YouTubeiOSPlayerHelper
  - To embed a YouTube video player on the SwiftUI to eliminate the need of leaving the app to watch it

## Additional Information: 
<details>
  <summary> Screenshots and Video Walkthrough </summary>

  App Icon Design is created on [Canva](https://www.canva.com/) and generated assets on [AppIcon.co](https://www.appicon.co/)
  | App Icon | 
  |:--:|
  | <img src="https://github.com/user-attachments/assets/e9288a87-4419-4ba2-9f20-290563900000" width="250" height="250" /> |

  Home Screen 
  | Light | Dark |
  |:--:|:--:|
  | <img src="https://github.com/user-attachments/assets/917f27d2-92d0-4cd5-b35e-9a666e1172ab" width="250" /> | <img src="https://github.com/user-attachments/assets/5477173a-e3cf-4e92-b750-bf1469f33c4d" width="250" /> |

  Details Screen 
  | Light | Dark | 
  |:--:|:--:|
  | <img src="https://github.com/user-attachments/assets/82a01696-7ffd-457d-9d97-28880483c7bf" width="250" /> | <img src="https://github.com/user-attachments/assets/74b69884-f0db-41a3-b90d-72846a680e9f" width="250" /> | 

  Video Walkthrough 
  | Search Bar | Filter | Sort |
  |:--:|:--:|:--:|
  | <video src="https://github.com/user-attachments/assets/d221f3f6-281a-4604-8888-4f50270b9524" />| <video src="https://github.com/user-attachments/assets/8301baeb-b5e9-43e6-b810-c3bee7c03d6f" /> | <video src="https://github.com/user-attachments/assets/1359f456-1e41-4082-9a4b-08648797088c" /> |

  | Details |
  |:--:|
  | <video src="https://github.com/user-attachments/assets/2e8e68d5-0507-4fb8-95d8-eff27dddfc8d" /> |

</details>
