# frozen_string_literal: true

require_relative "lib/jekyll_pic_container/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll_pic_container"
  spec.version = JekyllPicContainer::VERSION
  spec.authors = ["Tejus Parikh"]
  spec.email = ["tejus@vijedi.net"]

  spec.summary = "Simple Liquid Tag to wrap a picture tag in a caption"
  spec.homepage = "https://github.com/vijedi/jekyll_pic_container"
  spec.license = "MIT"
  spec.required_ruby_version = [">= 2.6", "< 4.0"]

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/vijedi/jekyll_pic_container"
  spec.metadata["changelog_uri"] = "https://github.com/vijedi/jekyll_pic_container/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll_picture_tag", "~> 2.0"
end
