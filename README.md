# GraphQL dive in

## Resources

- Official docs: https://graphql.org/
- GraphQL Ruby docs: https://graphql-ruby.org/getting_started
- Course: https://learning.edx.org/course/course-v1:LinuxFoundationX+LFS141x+3T2019
- 36 Concepts GraphQL developers should know: https://36-concepts-graphql.netlify.app/


## Introduction

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

### Core Concepts

* Schema Definition Language (SDL)
  * Defines the capabilities of the API.
  * Represent the contract between client and server.
  * It's a collection of GraphQL types with special _root types_: query, mutation and subscription types.
  * Example:
    ```
    type Person {
      name: String!
      age: Int!
      posts: [Post!]
    }
    type Post {
     title: String!
     author: Person!
    }
    ```
  * The `!` after a type indicates the field is mandatory.

* Queries
  * Example:
    ```
    {
      allPersons {
        name
      }
    }
    ```
  * `allPersons` is the _root field_ of the query.
  * Everyting that follows is the  _payload_ of the query.
  * Indicating how to return the last 2.
    ```
    {
      allPersons(last: 2) {
        name
      }
    }
    ```
* Mutations
  * Altering the data in the server.
  * 3 types of mutation: _creating_ new data, _updating_ existing data, and _deleting_ existing data.
  * Same structure as queries, but must start with `mutation`:
    ```
    mutation {
      createPerson(name: "Bob", age: 36) {
        name
        age
      }
    }
    ```
* Subscriptions
  * Subscribing to events.
  * Holds a steady connection to the server (stream).
  * Example:
    ```
    subscription {
      newPerson {
        name
        age
      }
    }
    ```



