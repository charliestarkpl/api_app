# README

Api Rails app for counting letters in start-up.house website, with subpages.

Send a string parameter in an GET request to an api/letters_count controller:
GET http://api-app.address/api/letters_count?query=a

In response you'll' get JSON, with current date and letters count, as below:

```
{
  response: {
     current_date: 2007-11-19,
     letters_count: 9348,
     query: 'a'
  }
}
```
