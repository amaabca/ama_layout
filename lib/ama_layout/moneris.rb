module AmaLayout
  class Moneris
    include ActiveModel::Model

    def decorate
      AmaLayout::MonerisDecorator.new(self)
    end

    attr_accessor :textbox_style_file

    def textbox_style_file
      @textbox_style_file ||= File.join Gem.loaded_specs["ama_layout"].full_gem_path, "lib", "ama_layout", "moneris", "textbox.txt"
    end
  end
end
