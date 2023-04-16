# Development Record
## Introduction
This document outlines the development process and progress.
The purpose of this development is to serve as the server-side logic for the RMS.
The backend system is responsible for handling requests from the frontend, processing data, and communicating with the database.

## Project Setup
- Create a new SpringBoot project trough Spring Initializer
- Configured the [pom.xml](../pom.xml)
- Configured the [application.yml](../src/main/resources/application.yml)
- Load frontend static resources templates
- Configured the [WebMvcConfig.java](../src/main/java/com/tenphun/rmsys/config/WebMvcConfig.java) to map static resources

## DataBase Setup
- Created a MySQL database schema with necessary tables and columns
- Created domain models to map to the database tables

## Module Developing
### Login Module

## Security

## Testing

## Conclusion
- used lombok to print log in case of better maintenance
- Wrote detailed development documentation