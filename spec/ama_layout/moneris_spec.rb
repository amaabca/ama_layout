# frozen_string_literal: true

describe AmaLayout::Moneris do
  describe '#textbox_style_file' do
    around(:each) do |example|
      current_version = Rails.configuration.stylesheet_resolver.version
      Rails.configuration.stylesheet_resolver.version = version
      example.run
      Rails.configuration.stylesheet_resolver.version = current_version
    end
    context 'v2' do
      let(:version) { 'v2' }

      it 'returns the correct file path' do
        expect(subject.textbox_style_file).to include("lib/ama_layout/moneris/#{version}/textbox.txt")
      end
    end

    context 'v3' do
      let(:version) { 'v3' }

      it 'returns the correct file path' do
        expect(subject.textbox_style_file).to include("lib/ama_layout/moneris/#{version}/textbox.txt")
      end
    end
  end
end
