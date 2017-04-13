require 'rack/cors'
require 'mimemagic'
require 'rack/moneta_rest'

class MimeDetector < Struct.new(:app)
  def call(env)
    response = app.call(env)
    return response if env.fetch('REQUEST_METHOD') == 'OPTIONS'

    status, headers, body = response

    path = env.fetch('PATH_INFO')
    binary_content = body[0]

    mime_type = MimeMagic.by_path(path) || MimeMagic.by_magic(binary_content)

    [
      status,
      headers.merge(
        'Content-Type' => mime_type.to_s
      ),
      body
    ]
  end
end


use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :put, :post, :options]
  end
end

use MimeDetector

run Rack::MonetaRest.new(:LRUHash)
