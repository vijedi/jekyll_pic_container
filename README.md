# JekyllPicContainer

A simple wrapper around [Jekyll Picture Tag](https://github.com/rbuchberger/jekyll_picture_tag) to standardize my usage across
the different blogs that I manage. This gem is unlikely to be useful to anyone else.

The key benefits is that it adds some markup for easier formatting, will translate an `alt` argument into
a caption, and provides a standardized way of sharing attribution to 3rd party CC images.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add jekyll_pic_container

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install jekyll_pic_container

## Usage

This tag supports three arguments, `alt`, `attr_source`, and `attr_text`.

Example:

```
{% pic_container thumb  --alt Alt Text --attr_source http://picture_site/picture_image.jpg --attr_text Original Author %}
```

This will render a caption with 'Alt Text' and a link to the picture image.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vi_jedi/jekyll_pic_container.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
