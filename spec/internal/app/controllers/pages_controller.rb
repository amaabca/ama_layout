class PagesController < ApplicationController
  def index
    html = <<-HTML
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="utf-8">
        <title>Test</title>
      </head>
      <body>
        <p><%= flash[:alert] %></p>
      </body>
      </html>
    HTML

    render inline: html
  end
end
