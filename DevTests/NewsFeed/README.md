## News Feed

Managing lists of content in a social network is a required technical challenge and can be solved in a number of ways. Imagine a feature like the Facebook news feed. An infinitely scrolling list of items where each user has potentially millions of items.

Implement an active model or set of models and associated route/controller to match this feature. The model should scale to millions of records and still respond within an acceptable time frame. It should include the users name, their geo location and their profile picture.
The controller responds with JSON. The results should be paged from the client.

- Ensure a consistent memory footprint as the client pages through the result set.
- Pay attention to the response time using explain analyse (specifically postgresql).
- Add the relevant indexes to speed up the model query where necessary.

Write supporting tests using rspec.
Share your explain analyse output and your db schema.
Implement the rails MVC pattern for this feature.

- [x] Generate Rails Application
- [x] User (name, latitude, longitude, avatar)
- [x] Post (Title, Description) `/posts`
- [x] Pagination `posts?page=2&per_page=10`
- [ ] Benchmark
- [ ] Export final explain analysis

Developer Comments:

- [JSON API](http://jsonapi.org/) excluded for simplicity of response.
- Unused endpoints omitted for clarity.

### Installation

Ruby 2.x and PostgreSQL 9.x are required:

    $ bin/setup

Start Server:

    $ bin/rails server

Run RSpec, Brakeman and Rubocop:

    $ bin/test

Run Performance Specs:

    # Checks performance over 1 million posts
    $ bin/rspec spec/performance --tag performance

### Example Response

	# GET /posts
    {
      "posts":[
        {
          "id":10,
          "title":"Dicta sunt in excepturi sint odio ipsum et.",
          "body":"Minima ex consequatur repellendus. Molestiae tenetur consequatur qui possimus voluptates non ducimus. Ea occaecati qui assumenda quis velit. In suscipit qui minima qui et dolor at.",
          "user":{
            "id":1,
            "name":"Chuck J Hardy",
            "latitude":"51.5034",
            "longitude":"-0.1276"
          }
        }
      ]
    }

### Todo

- [ ] Versioning
- [ ] Pagination metadata
- [ ] Users CRUD
- [ ] Complete Posts CRUD
