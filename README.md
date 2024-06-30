# WeatherApp

## Overview

This Flutter application displays weather information for a given city using the OpenWeatherMap REST API. This project was implemented as part of a code challenge.

## Implementation Details

### Features

- **Loading Indicator**: A loading indicator is displayed when fetching data from the API.
- **Weather List Items**: Each item displays the day of the week abbreviation and a weather condition image.
- **Weather Details**: Detailed information includes the day of the week, weather condition name and image, current temperature, humidity, pressure, and wind.
- **Selectable Weather Items**: Selecting a weather list item updates the detailed weather information.
- **Pull to Refresh**: Weather information can be refreshed using a pull-to-refresh gesture.
- **Error Handling**: An error screen with a retry button is shown if fetching data fails.

### Extra Features

- Support for both horizontal and vertical layouts.
- Option to change the temperature unit between Celsius and Fahrenheit.

### Design Considerations

Due to the absence of specific Figma design guidelines, the application does not include custom font themes and styles. The focus was primarily on the code structure, functionality, and testing.

## Code Structure

The project is structured to separate concerns and enhance maintainability. Key components include:

- **Models**: Data models for weather information.
- **Services**: API service for fetching weather data.
- **Providers**: State management using Provider.
- **Widgets**: Custom widgets for the weather list and detail views.
- **Screens**: Main screens for displaying weather information and handling errors.

## Testing

Emphasis was placed on unit and widget testing to ensure reliability and correctness. Tests cover:

- **API Service**: Mocking API responses to test data fetching logic.
- **State Management**: Ensuring state updates correctly in response to user interactions.
- **UI Components**: Verifying the correct display of weather information and error handling.

## Installation

To run this project locally, follow these steps:

1. Clone the repository:
   ```bash
   [git clone https://github.com/yourusername/weatherapp.git](https://github.com/MohsenNamazi/weather.git)
