# Moneta REST on Heroku

A simple `Rack::MonetaRest` app backed by an in-memory LRU hash.

PUT to a URL to save something at that location.
GET the URL to retrieve it.

Uses the [`mimemagic` gem](https://github.com/minad/mimemagic) to automatically detect the mimetype, first by looking at the extension, and if that doesn't work by inspecting the file contents.

## Examples

### PUT some text

    curl -d 'Some text' localhost:5000/x

### GET that same text

    curl localhost:5000/x

### PUT a file

    curl -T some_file.png localhost:5000/x
