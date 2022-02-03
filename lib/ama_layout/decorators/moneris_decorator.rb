module AmaLayout
  class MonerisDecorator < Draper::Decorator
    include AmaLayoutPartialHelper

    delegate_all

    def textbox
      h.raw File.read textbox_style_file
    end
  end
end
