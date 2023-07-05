# frozen_string_literal: true

require_relative "jekyll_pic_container/version"
require "liquid"

# Namespace for this class
module JekyllPicContainer
  # Provices some markup around a picture tag. This tag will process the following arguments:
  #   --alt Alt text will be placed on the image tag as well as being provided as a caption to the image
  #   --attr_source A link to an original image that has been copied here. 
  #   --attr_text The text to correctly credit the original source
  class PicContainer < Liquid::Tag
    attr_reader :markup, :tag_arguments

    def initialize(_tag_name, markup, _tokens)
      @markup = markup
      @tag_arguments = markup.split(/--/)[1..].freeze
      super
    end

    def render(context)
      tags = ['<div class="picture_container">']
      tags.push(<<~HTML.strip)
        {% picture #{markup} %}
      HTML

      alt = get_argument("alt")
      tags.push(build_caption(alt)) unless alt.nil?
      tags.push("</div>")

      content = tags.join(" ")
      Liquid::Template.parse(content).render(context)
    end

    # For a tag, the content is the markup of the tag, which means it
    # has to be manually parsed. Picture tag 2 uses `--` to designate
    # options after the first required ones
    def get_argument(arg_name)
      prefix = "#{arg_name} "
      raw_value = tag_arguments.filter { |text| text.start_with?(prefix) }.first
      return unless raw_value

      arg_value = raw_value.dup
      # Remove the arg prefix from the string
      arg_value.slice!(prefix)

      arg_value.strip
    end

    def build_caption(alt)
      tags = ["<p>"]
      tags.push(alt)

      attr_source = get_argument("attr_source")
      unless attr_source.nil?
        tags.push(" ") # Add a space between the text and the tag
        tags.push("<a target='_blank' rel='noreferrer' href='#{attr_source}'>")
        attr_text = get_argument("attr_text")
        if attr_text.nil?
          tags.push("original source")
        else
          tags.push(attr_text)
        end
        tags.push("</a>")
      end

      tags.push("</p>")
      tags.join("")
    end
  end
end

Liquid::Template.register_tag("pic_container", JekyllPicContainer::PicContainer)
