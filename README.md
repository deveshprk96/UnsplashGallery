# UnsplashGallery

# Overview
The Unsplash Gallery App is an iOS application that loads and displays images from the Unsplash API in a scrollable grid format. It supports asynchronous image loading, caching for efficiency, and handles errors gracefully.

# Features
Display images in a scrollable grid.
Asynchronous image loading with caching mechanism.
Handling network errors and image loading failures.
Pagination to load more images as the user scrolls.

# Prerequisites
Xcode 14 or later
Swift 5.7 or later
iOS 15.0 or later
A valid Unsplash API Key (existing key in UnsplashService.swift)

# Setup Instructions

# Step 1: Clone the Repository
First, clone the repo to your local machine using Git:

git clone [URL_TO_REPOSITORY]
cd [REPOSITORY_NAME]
Replace [URL_TO_REPOSITORY] and [REPOSITORY_NAME] with the actual URL and name of your GitHub repository.

# Step 2: Install Dependencies
This project uses no external dependencies. Ensure you have the latest version of Xcode installed.

# Step 3: API Key Configuration
Before running the application, you need to insert your Unsplash API key (if have any):

Open UnsplashService.swift.
Replace Client-ID YOUR_UNSPLASH_ACCESS_KEY in the request.addValue("Client-ID 9836d9c4041f5323b2e2921cbe653a3bbce58bdaa1346f68c27a0540c114b807", forHTTPHeaderField: "Authorization") line with your actual Unsplash API key.

# Step 4: Build and Run
Open Unsplash Gallery.xcodeproj in Xcode.
Select your target device from the top device toolbar.
Press Cmd + R or click the Play button in Xcode to build and run the project.

# Usage
Upon launching, the app will display a collection of images in two sections:

Trending Images: Showcased at the top in smaller preview cells.
Popular Images: Displayed below in larger grid cells.
Scroll to view more images. The app will automatically fetch more images as you reach the bottom of the list.
