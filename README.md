# AmaLayout

The AmaLayout gem is used to add a standard layout to .ama.ab.ca sites.

## Testing

The template

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

Rails.configuration.membership_site

Rails.configuration.driveredonline_site

Rails.configuration.amaabca_site

Rails.configuration.forms_amaabca_site


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
        return nil unless current_user
        return navigation_items["member-in-renewal"] if current_user.profile.in_billing?
        return navigation_items["member"] if current_user.member?
        navigation_items["non-member"]
      end

    private
        def navigation_items
          YAML.load(ERB.new(File.read("#{Rails.root}/config/locales/navigation.yml")).result)
        end
    end

Custom Navigation yaml file used to set all navigation:

    member:
      "Your Account Dashboard":
        subtitle: "Member Exclusive Services"
        alt: "Back to my dashboard"
        link: "<%= Rails.configuration.youraccount_site %>/dashboard"
      "Online Profile":
        subtitle: "Email / Password Change"
        link: "<%= Rails.configuration.gatekeeper_site %>/user/edit"
      "Billing":
        subtitle: "Statements / Reward Options"
        link: "<%= Rails.configuration.youraccount_site %>/billing"
      .
      .
      .
    non-member:
      "Joins":
        alt: "Back to my dashboard"
        link: <%= Rails.configuration.membership_site %>
      "New Driver Online Program":
        link: "<%= Rails.configuration.driveredonline_site %>/login"
        target: "_blank"
    member-in-renewal:
      "Your Account Dashboard":
        subtitle: "Member Exclusive Services"
        alt: "Back to my dashboard"
        link: "<%= Rails.configuration.youraccount_site %>/dashboard"
      "Renew":
        link: "<%= Rails.configuration.youraccount_site %>/renew"
      "Help":
        link: "<%= Rails.configuration.youraccount_site %>/help"
      "Contact Us":
        link: "<%= Rails.configuration.amaabca_site %>/membership/contact-us--centre-locations-hours-and-contact-information"
        target: "_blank"


### Custom Navigation

If you want to use custom navigation in an app using this gem, you can specify the location of the navigation.yml file when exposing navigation in your controller.

Example:

Instead of:

```
expose(:navigation) do
  AmaLayout::Navigation.new(
    user: current_user, current_url: request.url
  ).decorate
end
```

```
expose(:navigation) do
  AmaLayout::Navigation.new(
    user: current_user, current_url: request.url,
    nav_file_path: Rails.root.join("config", "ama_layout", "navigation.yml")
  ).decorate
end
```

This is useful for soft-launching applications.


### Layout

The following layout example will give you:
       a header with appropriate navigation if applicable,
       side navigation if applicable and footer

    <body class="<%= controller_name %>" id="top">
      <%= render partial: "ama_layout/siteheader", locals: { navigation: Navigation.new(current_user: current_user).navigation } %>
      <%= render "ama_layout/notices" %>
      <div class="row wrapper">
        <%= render partial: "ama_layout/custom_sidebar", locals: { navigation: Navigation.new(current_user: current_user).navigation } %>
        <%= yield %>
      </div>
      <%= render "ama_layout/footer" %>
    </body>

### Javascript

Add the following to your application.js

    //= require ama_layout/desktop

## Contributing

1. Fork it ( https://github.com/amaabca/ama_layout/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Create rspec tests to cover your feature (100% coverage required)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
