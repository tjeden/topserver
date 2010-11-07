class Listener < EM::Connection
  include EM::HttpServer

  def post_init
    super
    no_environment_strings
  end

  def process_http_request
        #puts   @http_protocol
        #puts   @http_request_method
        #puts   @http_cookie
        #puts   @http_if_none_match
        #puts   @http_content_type
        #puts   @http_path_info
        #puts   @http_request_uri
        #puts @http_query_string
        #puts   @http_headers
    puts   @http_post_content
    response = EM::DelegatedHttpResponse.new(self)
    response.status = 200
    response.content_type 'text/html'
    response.content = "Hello from server"
      response.send_response

    @output ||= File.new('data/output.jpg', 'w+')
    @output.puts(@http_post_content)
    @output.close
  end
end
