require 'rack/moneta_rest'
require 'mimemagic'

class MimeDetector < Struct.new(:app)
  def call(env)
    status, headers, body = app.call(env)

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

use MimeDetector

run Rack::MonetaRest.new(:LRUHash)
