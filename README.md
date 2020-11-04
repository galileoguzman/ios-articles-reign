# iOS Articles

iOS Application that fetch data from [Algolia API](https://hn.algolia.com/api/v1/search_by_date?query=ios&page=2) to retrieve the latest articles shared by users.

#### Requirements
- Xcode 12 or newest


#### Structure
- `ArticlesVC` is the controller in charge to show the articles downloaded by the `NetworkManager`
- `ArticlesVC` show the articles inside a `UITableView` with a custom cell named `ArticleCell`
- `ArticlesVC` has an `extension` for manage the `TableViewDelegates` methods

#### TODO
- Save in memory information
- Filter articles deleted by user
