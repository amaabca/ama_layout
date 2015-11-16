describe AmaLayout::Moneris do

  describe "#textbox_style_file" do
    it "return file path" do
      expect(subject.textbox_style_file).to include "lib/ama_layout/moneris/textbox.txt"
    end
  end
end
