#ruby-nationalcrimesearch


A wrapper for the [National Crime Search](http://nationalcrimesearch.com) API. This code is licensed under the MIT license found [here](http://choosealicense.com/licenses/mit/).

##Usage
`ruby-nationalcrimesearch` provides a simple wrapper for the API. As such, it is designed purely with readability and simplicity in mind. There is no advanced error handling, nor fancy classes to wrap search definition types. This should be used for communication. Response handling is up to the user of this class.

To begin using it, simply create a new instance and pass in your username, token, and optionally you can indicate true or false for whether you intend to use the development environment:

```ruby
ncs = NationalCrimeSearch.new('youremail@email.com', 'your_user_token', true)
```

Using the class to make API calls is simple:

```ruby
response = ncs.send_request(:valid_token, email: ncs.username)
puts response
```
The result is a hash that has been converted from a JSON response via the API. 
```
=> {"valid"=>true}
```

##Supported Endpoints
Currently, the following endpoints are supported although not all are tested: 

```
/users/generate_token
/users/valid
/users/valid_token
/searches/search_results
/searches/show/:id
/searches
/searches/get_search_result
/searches/get_packages
/searches/get_package_search_inputs
```

Please refer to the NCS API documentation for what parameters are required to be provided for each endpoint. You must use their keys for the form data being sent, otherwise you will receive hash containing an `'error'` key with the reason the call failed. Unfortunately, these calls are not currently specific to what the issue is with the call that was made.

All calls to endpoints use `JSON`. Currently you cannot get the raw json back out from the call, although this will change. Ultimately I would like to store the raw results in either a hash or array that is updated with every call. This means support for `XML` will also be implemented in the future.

