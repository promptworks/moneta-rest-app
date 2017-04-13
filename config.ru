require 'rack/moneta_rest'

run Rack::MonetaRest.new(:LRUHash)
