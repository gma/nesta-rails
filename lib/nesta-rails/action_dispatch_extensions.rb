module ActionDispatch
  class Request
    # Decorate the Request object with secure? method, which Sinatra has
    # rather pointlessly aliased to ssl?. "LOL Ruby", as a well known
    # coder might say. "You twats", as I might say.
    #
    alias secure? ssl?

    def forwarded?
      @env.include? "HTTP_X_FORWARDED_HOST"
    end
  end
end
