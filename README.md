# Articles Headlines App

- Take Home Test for Medibank done by Harikrishna Pai as per the functional requirements
- Click `ArticlesHeadlines.xcworkspace` in the root folder to open the project
- Xcode 15.0.1 & Swift language is used for development
- The architecture used in the project is MVVM-C (Model-View-ViewModel-Coordinator)
- Images are used as available from Google
- Networking layer is developed as a separate module
- RxSwift is used for the data binding of the table view
- Programmatic UI with UIKit
- Swift Concurrency with async/await used for webservice calls
- Supports Light and Dark modes
- Upon the first install, no news source will be selected by default. The news will be fetched with the query `country=us`. Users can then select the news sources of their choice from the `Sources` tab in the application. Once the user selects one or more sources, then the news will be fetched from the selected sources only.
