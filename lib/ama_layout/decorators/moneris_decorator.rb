module AmaLayout
  class MonerisDecorator
    include AmaLayout::DraperReplacement

    def textbox
      h.raw File.read textbox_style_file
    end
  end
end
