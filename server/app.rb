# frozen_string_literal: true

require "rubygems"
require "bundler/setup"
require "sinatra"
require "securerandom"

get "/" do
  @url = "raybancards://auth?token=#{SecureRandom.base64(64)}"
  erb :index
end

__END__
@@ layout
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>RaybanCards!</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  </head>
  <body>
    <%= yield %>
  </body>
</html>

@@ index
<section class="hero is-warning is-fullheight">
  <div class="hero-body">
    <div class="container has-text-centered">
      <p class="title">
        RaybanCards
      </p>
      <p class="subtitle">
        <a href="<%= @url %>" class="button">
          <span class="icon"><i class="fa-solid fa-rocket"></i></span>
          <span>Open App</span>
        </a>
      </p>
    </div>
  </div>
</section>
