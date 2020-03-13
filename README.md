# SalesLoft Challenge

Small application for SalesLoft Engineering interview process.

## Requirements

The SalesLoft challenge consists in creating an application that allows a user
to:

1. See a list of people records that are available via SalesLoft API.
2. Click a button that displays a frequency count of all unique characters of all people sorted by frequency count
3. Click a button that shows a list of suggested possible duplicate people
4. Build a scalable enterprise-ready underlying architecture

NOTE: this is a short version of the actual requirements. If you want to read the full version, ask the SalesLoft team for a copy of the **SalesLoft Engineering Offline Exercise v2** document.

## Solutions

### Requirement 1 (level 1)

The solution for this requirement was to create a middle-man back-end service that periodically import batches of 100 people records from the SalesLoft API. That solution is based in the concept of efficient cursor poller proposed in the SalesLoft documentation. The back-end service also implements a REST API interface for exposing people data to a UI component.

The main reasons for choosing this approach:

* Rate limit restrictions from SalesLoft API
* Unsupported CORS requests to SalesLoft API (at least with API key auth)
* Remaining requirements could benefit from asynchronous processing

### Requirement 2 (level 2)

In this case, the calculation of the frequency counts was implemented as an asynchronous operation that runs over the people data cached by level 1 solution. The calculation logic can be executed periodically or right after the people records are imported. The results of the pre-calculation are cached in a database table so they can be always returned in no time. This solution also provides a REST API interface to expose the pre-calculated data to the UI.

Reasons for that decision:

* Live calculation of the frequency count is an expensive operation that most of the time returns the same results

### Requirement 3 (level 3)

Similar to the previous requirement solution, the possible duplicated people are detected by an asynchronous operation. The logic consists in retrieving the email addresses from the cached people. Then, every email address is compared with the other ones using the Levenshtein Distance algorithm. The Levenshtein distance between two words is the minimum number of single-character edits required to change one word into the other. If the calculated distance is one or less, the people are considered duplicate from each other. The duplicated people detected are cached in a database table.

Resons for this decision:

* Duplicate detection is an expensive operation to be triggered synchronously
* Possible duplicated people won't change untile the next people batch is imported

### Requirement 4 (level 4)

Basically, this requirement was satified by the design of the previous requirement solutions and the underlying architecture selected.

## Architecture

This application follows the concepts and ideas proposed by the [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html). The Clean Architecture, as well as other similar architectures, pursues the objective of separation of concerns. They achieve this objective by dividing the software into layers and all of them produce system that are:

1. Independent of Frameworks
2. Testable
3. Independent of UI
4. Independent of Database
5. Independent of any external agency

![Clean Architecture Diagram](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg)

## Components

![Components Diagram](http://www.plantuml.com/plantuml/png/bP3FIiD048VlynH3xda5QHKLeM1jSYivJBDZ3TdkXDq9HQJlRf8ck4jE7eVlDt--sGGbh_t50jKg7ll07i29OSnUl3ZDsPaCVm3nUE0XWzkkgp3tpVbBymSyRlTl-6GRTbe1fkKDS9xqI7Kx3rf2hwHyfU-fwRrZJzg82rEv5slPL_ULdOH6nJTyPmTg6KiAxL3U4A2sqXlC2h8STlAfowdFHOd3cl48CAHqei2OxINesNFniPjp9Ps6nYarccDkvEf6hJzNY9mYyLGYLi1ym8bJVFMQ9fF-ZTURb_UjIVhD9JYo-6D9RARBdpRiJ7-nlm00)

### Backend

This major component acts as a middle-man service between the UI and the SalesLoft API. It's responsible for importing the people records, pre-calculate the frequency count of the email address characters, and the pre-detection of the possible people duplicated. 

It was implemented as a Ruby web application built on the top of the following stack:

* dry-system
* dry-monands
* rom-rb
* roda

You can find more details about the chosen stack at https://github.com/carvid/salesloft-exercise/commit/f6f7ad707e64d54aa038ea1eb2a37753597b2c46

The main parts of the backend component are the core, the gateways, and the apps

#### Core (lib)

Contains the core business logic. It is composed by entities and operations.

Entities they encapsulate the most general and high-level rules. At the moment there aren't any entity defined yet, but as soon as general business rules emerge they should be incarnated in an entity.

Operations they are also known as use-cases, interactors, or service objects. The software in this layer contains application specific business rules. Some example of them are `ImportPeople`, `CountEmailCharacters` and `DetectDuplicatedPeople` classes.

#### Gateways

The software in this layer is a set of adapters that convert data from the format most convenient for the operations and entities, to the format most convenient for some external agency. Some examples of them are the repositories to access the database and the poller that fetch data from SalesLoft API.

#### Apps

These are the delivery mechanisms. In the strict sense of the word, they are the same than the gateways but they are reponsible to adapt the input from the outside world into something the core business logic understand. The REST API endpoints are a good example of them.
