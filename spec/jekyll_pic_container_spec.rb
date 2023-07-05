# frozen_string_literal: true

RSpec.describe JekyllPicContainer do
  it "has a version number" do
    expect(JekyllPicContainer::VERSION).not_to be nil
  end

  it "should be registered" do
    expect(Liquid::Template.tags['pic_container']).to eq(JekyllPicContainer::PicContainer)
  end

  describe JekyllPicContainer::PicContainer do
    subject { JekyllPicContainer::PicContainer.send(:new, "pic_container", markup, mock_token) }

    let(:mock_token) { double("token") }
    let(:mock_parse) { double(:parse) }
    let(:render_context) { {} }

    before do
      allow(mock_token).to receive(:line_number).and_return(1)
      allow(mock_token).to receive(:locale).and_return("en-US")

      expect(Liquid::Template).to receive(:parse).with(content).and_return(mock_parse)
      expect(mock_parse).to receive(:render).with(render_context)
    end

    context "no arguments" do
      let(:markup) { "thumb" }
      let(:content) do
        <<~OUTPUT.strip
          <div class="picture_container"> {% picture thumb %} </div>
        OUTPUT
      end

      it "should render the tag" do
        subject.render(render_context)
      end
    end

    context "alt argument provided" do
      let(:markup) { "thumb --alt this is my alt text" }
      let(:content) do
        normalize_space(<<~OUTPUT.strip)
          <div class="picture_container">#{" "}
            {% picture thumb --alt this is my alt text %}#{" "}
            <p>this is my alt text</p>
          </div>
        OUTPUT
      end

      it "should render the tag with a caption" do
        subject.render(render_context)
      end
    end

    context "alt and attr_source arguments provided" do
      let(:markup) { "thumb --alt alt text --attr_source attr source" }
      let(:content) do
        normalize_space(<<~OUTPUT.strip)
          <div class="picture_container">#{" "}
            {% picture thumb --alt alt text --attr_source attr source %}#{" "}
            <p>alt text <a target='_blank' rel='noreferrer' href='attr source'>original source</a></p>
          </div>
        OUTPUT
      end

      it "should render the tag with a caption" do
        subject.render(render_context)
      end
    end

    context "alt, attr_source, and attr_text arguments provided" do
      let(:markup) { "thumb --alt alt text --attr_source attr source --attr_text attr text" }
      let(:content) do
        normalize_space(<<~OUTPUT.strip)
          <div class="picture_container">#{" "}
            {% picture thumb --alt alt text --attr_source attr source --attr_text attr text %}#{" "}
            <p>alt text <a target='_blank' rel='noreferrer' href='attr source'>attr text</a></p>
          </div>
        OUTPUT
      end

      it "should render the tag with a caption" do
        subject.render(render_context)
      end
    end

    def normalize_space(input)
      input.gsub(/\s+/m, " ")
    end
  end
end
