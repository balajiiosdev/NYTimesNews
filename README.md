# NYTimesNews

## Summary

Shows Top news from New York Times server

## Design

### Architecture

Clean Swift architecture is chosen for the view implementations. It enables the clean separation between view logic, business logic, presentation logic, and routing logic. All the classes in this deisgn are loosely coupled. It is easier to maintain.

### Apple Human Interface guidelines

- Accessbility support
- Support for DarkMode and Light Mode
- Dynamic Font size
- Portriate and Landscape modes are supported

### Detailed Class diagram

![Detailed Class diagram](./HLD.png)

## Screenshots

<img src="Screenshots/NewsList.png" width="200">
<img src="Screenshots/NewsDetails.png" width="200">
<img src="Screenshots/NewsList-DarkMode.png" width="200">
<img src="Screenshots/NewsDetails-DarkMode.png" width="200">
<img src="Screenshots/NewsList-LargerFontSize.png" width="200">
<img src="Screenshots/NewsDetails-LargerFontSize.png" width="200">


## Thirdparty Depndencies

| Name | Repository |
| --- | --- |
| SDWebImage | <https://github.com/SDWebImage/SDWebImage> |
| MBProgressHUD | <https://github.com/jdg/MBProgressHUD> |
| Reachability | <https://github.com/ashleymills/Reachability.swift> |

## Validation

Unit tests are covered the NewsList and NewsDetails classes and also NYTimesNewsApi framework classes.
