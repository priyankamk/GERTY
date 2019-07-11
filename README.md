# [GERTY](https://gerty-app-5.herokuapp.com/)

[![CircleCI](https://circleci.com/gh/priyankamk/GERTY.svg?style=svg)](https://circleci.com/gh/priyankamk/GERTY)

## Build with
- HTML5 & CSS3
- Ruby on rails 5.2.2.1
- 5 APIs
- [LUIS(Language Understanding)](https://docs.microsoft.com/en-gb/azure/cognitive-services/luis/what-is-luis)
- Bootstrap
- HTTParty gem
- PostgreSQL
- [SENTRY](https://docs.sentry.io/) - For error tracking

## Description
 - GERTY is a Virtual Personal Assistant that helps you find information quickly. Be it current weather,breaking news or check movie reviews and look at funny giphy to start your day! Ask away and get answer to your question and get on without scrolling through endless pages of google search results.

 -  GERTY is powered by:
    1. [News API](https://newsapi.org/)
    2. [Weather API](https://darksky.net/dev)
    3. [OMDB API](http://www.omdbapi.com/)
    4. [Giphy API](https://giphy.com/)

## Objective
- My aim for this project to learn How to use API's and build something useful that I can use in future.
- Understand how to use rails app.
- Building API's that consumes other API's.
- Learn to use LUIS(Language Understanding)
- Learn about environment variable to store API keys in private.

## Approach
1. Designed the website from wireframe.
2. Created trello app with designed card task. eg: Todo list, doing, done, Feature and Aim.
3. Made a list of API's that I want to work with.
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

### [Environment variable - My Blog](https://medium.com/@priyankamukund/how-to-store-and-use-secrets-in-a-rails-6bafeffd645f?source=friends_link&sk=5d302e285cfdcfd7f7bd521181291b9e)

### Deployment 
- Heroku
