# [GERTY](https://gerty-app-5.herokuapp.com/)

## Build with
- HTML & CSS
- Ruby on rails 5.2.2.1
- 5 APIs
- [LUIS(Language Understanding)](https://docs.microsoft.com/en-gb/azure/cognitive-services/luis/what-is-luis)
- Bootstrap
- HTTParty gem
- PostgreSQL
- [SENTRY](https://docs.sentry.io/)

## Description
 - GERTY is a Virtual Assistant that helps you find information quickly. Be it current weather,
    breaking news or getting inspired with an inspirational quote to start your day!
    Ask away and get answer to your question and get on without scrolling through endless pages
    of google search results.
 -  GERTY is powered by:
    1. [OMDB API](http://www.omdbapi.com/)
    2. [News API](https://newsapi.org/)
    3. [Weather API](https://darksky.net/dev)
    4. [Quotes API](http://quotes.rest/)
    5. [Giphy API](https://giphy.com/)

## Approach

- My aim for this project to learn How to use API's and build something useful that I can use in future.
- Understand how to use rails app.
- Building API's that consumes other API's.
- Learn to use LUIS(Language Understanding)

1. Designed the website from wireframe.
2. Created trello app with designed card task. eg: Todo list, doing, done, Feature and Aim.
3. Made a list of API's that i want to work with.
4. Created ruby on rails app.
5. Created database to store history search.
6. Generated models, controller and action.
7. Got JSON data from the API's.
8. Used HTTParty gem and fetch function to talk with API's
9. Using the API's JSON data, created web pages using ruby.
10. Made frequent commits.
11. Error handling and avoiding empty input not to save in db.

## Difficult Obstacles

1. Talking with API's and working with different API's
2. Learning new concept - About Modules.
3. learning to use link_to tag functionality
4. to make the all the query of API's to be used in a single home page.
5. finding out - query's that match with "giphy" as action "rainbow cat" as query_req.

## Stretch Goals

1. Have a login/SignUp System, so that individual user can use.
2. Create a Bookmark, which show's the list of saved bookmark and use it in future.
3. Test my app using Rspec.

## Learn about API's:

### What is an API? (Application Programming Interface)
- API is the acronym for Application Programming Interface, which is a software intermediary that allows two applications to talk to each other. Each time you use an app like Facebook, send an instant message, or check the weather on your phone, you’re using an API.

### What Is an Example of an API?
- When you use an application on your mobile phone, the application connects to the Internet and sends data to a server. The server then retrieves that data, interprets it, performs the necessary actions and sends it back to your phone. The application then interprets that data and presents you with the information you wanted in a readable way. This is what an API is - all of this happens via API.

More about [API-Blog](https://medium.com/@perrysetgo/what-exactly-is-an-api-69f36968a41f)

### Deployment 
- Heroku
