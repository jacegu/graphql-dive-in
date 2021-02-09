# Notes on GraphQL

## Resources

- Official docs: https://graphql.org/
- GraphQL Ruby docs: https://graphql-ruby.org/getting_started
- Course: https://learning.edx.org/course/course-v1:LinuxFoundationX+LFS141x+3T2019
- 36 Concepts GraphQL developers should know: https://36-concepts-graphql.netlify.app/


## Notes

### What is GraphQL

* It's a new API standard created as an alternative to REST.
* Introduced by Facebook in 2012. Announced to the public back in 2015. Open-sourced with many contributors.
* Other companies, like Netflix ([Falcor](https://netflix.github.io/falcor/)) and Coursera, where working on similar ideas back then to make API interactions more efficient.
* When REST was introduced:
  * Clients were simple.
  * Development speed was much slower than today.
* Facebook decided to create GraphQL because of:
  * Increased mobile usage.
  * Low power devices gaining importance.
  * Sloppy network connections.


### Advantages

* It exposes a single API endpoint that responds exactly with the data requested by the client.
* It enables declarative data fetching: clients can specify exactly the data they need.
  * Minimizing the amount of data that needs to be transferred over the network. (Solves over-fetching).
  * Limits the requests needed to fetch data for a specific client to 1 (Solves under-fetching).
  * Allowing different client types to use an API tailored to their needs.
  * It's easier to iterate on the fronted (no need to update the API).
* Introspection in to the data most used by clients.
* Supports explicit deprecation.
* Provides aids to instrumentation and performance monitoring.
* Strong type system (and validation through it).


