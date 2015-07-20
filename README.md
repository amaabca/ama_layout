# AmaLayout

The AmaLayout gem is used to add a standard layout and style to .ama.ab.ca sites.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ama_layout'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ama_layout

## Usage

### Configuration

Ensure that the app responds to:

Rails.configuration.gatekeeper_site

Rails.configuration.youraccount_site

Rails.configuration.insurance_site


### Navigation

Navigation for each application has been built in custom made Navigation class and set as a hash to ama_layout gem:

Example:

    class Navigation
      include ActiveModel::Model

      attr_accessor :current_user

      def initialize args={}
        self.current_user = args.fetch(:current_user)
      end

      def navigation
        if current_user.member?
          member_navigation
        else
          non_member_navigation
        end
      end

      def member_navigation
        {
          "Your Account Dashboard" => { subtitle: "Member Exclusive Services", alt: "Back to my dashboard", link: "#{Rails.configuration.youraccount_site}/dashboard" },
          "Online Profile" => { subtitle: "Email / Password Change", link: "#{Rails.configuration.gatekeeper_site}/user/edit" }
      end

      def non_member_navigation
        {
          "Join" => { alt: "Back to my dashboard", link: "#{Rails.configuration.membership_site}" },
          "New Driver Online Program" => { link: "#{Rails.configuration.driveredonline_site}/login", target: "_blank" }
        }
      end
    end


### Layout

The following layout example will give you:
       a header with appropriate navigation if applicable,
       side navigation if applicable and footer

    <body class="<%= controller_name %>" id="top">
      <%= render partial: "ama_layout/siteheader", locals: { navigation: Navigation.new(current_user: current_user).navigation } if current_user %>
      <%= render "ama_layout/notices" %>
      <div class="row wrapper">
        <%= render partial: "ama_layout/custom_sidebar", locals: { navigation: Navigation.new(current_user: current_user).navigation } if current_user %>
        <%= yield %>
      </div>
      <%= render "ama_layout/footer" %>
    </body>

### Stylesheets

Add the following to your application.scss

    @import "ama_layout/application";

### Javascript

Add the following to your application.js

    //= require ama_layout/desktop

### Mobile Layouts

There is no need for you to set any specific code, values,... for mobile views.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ama_layout/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Create rspec tests to cover your feature (100% coverage required)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
