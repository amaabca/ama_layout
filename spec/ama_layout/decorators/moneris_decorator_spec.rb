describe AmaLayout::MonerisDecorator, type: :decorator do
  let(:moneris) { AmaLayout::Moneris.new }
  let(:moneris_presenter) { moneris.decorate }

  describe "#textbox" do
    it "return textbox style file" do
      expect(moneris_presenter.textbox).to include "-webkit-appearance: none;"
      expect(moneris_presenter.textbox).to include "-webkit-box-shadow: none;"
      expect(moneris_presenter.textbox).to include "-webkit-rtl-ordering: logical;"
      expect(moneris_presenter.textbox).to include "-webkit-transition-delay: 0s, 0s;"
      expect(moneris_presenter.textbox).to include "-webkit-transition-duration: 0.45s, 0.45s;"
      expect(moneris_presenter.textbox).to include "-webkit-transition-property: box-shadow, border-color;"
      expect(moneris_presenter.textbox).to include "-webkit-transition-timing-function: ease, ease-in-out;"
      expect(moneris_presenter.textbox).to include "-webkit-user-select: text;"
      expect(moneris_presenter.textbox).to include "-webkit-writing-mode: horizontal-tb;"
      expect(moneris_presenter.textbox).to include "background-color: rgb(255, 255, 255);"
      expect(moneris_presenter.textbox).to include "border-bottom-color: rgb(160, 160, 161);"
      expect(moneris_presenter.textbox).to include "border-bottom-style: solid;"
      expect(moneris_presenter.textbox).to include "border-bottom-width: 2px;"
      expect(moneris_presenter.textbox).to include "border-image-outset: 0px;"
      expect(moneris_presenter.textbox).to include "border-image-repeat: stretch;"
      expect(moneris_presenter.textbox).to include "border-image-slice: 100%;"
      expect(moneris_presenter.textbox).to include "border-image-source: none;"
      expect(moneris_presenter.textbox).to include "border-image-width: 1;"
      expect(moneris_presenter.textbox).to include "border-left-color: rgb(160, 160, 161)"
      expect(moneris_presenter.textbox).to include "border-left-style: solid;"
      expect(moneris_presenter.textbox).to include "border-left-width: 2px;"
      expect(moneris_presenter.textbox).to include "border-right-color: rgb(160, 160, 161)"
      expect(moneris_presenter.textbox).to include "border-right-style: solid;"
      expect(moneris_presenter.textbox).to include "border-right-width: 2px;"
      expect(moneris_presenter.textbox).to include "border-top-color: rgb(160, 160, 161)"
      expect(moneris_presenter.textbox).to include "border-top-style: solid;"
      expect(moneris_presenter.textbox).to include "border-top-width: 2px;"
      expect(moneris_presenter.textbox).to include "box-shadow: none;"
      expect(moneris_presenter.textbox).to include "box-sizing: border-box;"
      expect(moneris_presenter.textbox).to include "color: rgba(0, 0, 0, 0.74902);"
      expect(moneris_presenter.textbox).to include "cursor: auto;"
      expect(moneris_presenter.textbox).to include "display: block;"
      expect(moneris_presenter.textbox).to include "font-family: 'Helvetica Neue', Helvetica, Roboto, Arial, sans-serif;font-size: 14px;"
      expect(moneris_presenter.textbox).to include "font-style: normal;font-variant: normal;"
      expect(moneris_presenter.textbox).to include "font-weight: normal;"
      expect(moneris_presenter.textbox).to include "height: 44px;"
      expect(moneris_presenter.textbox).to include "letter-spacing: normal;"
      expect(moneris_presenter.textbox).to include "line-height: normal;"
      expect(moneris_presenter.textbox).to include "margin-bottom: 0px;"
      expect(moneris_presenter.textbox).to include "margin-left: 0px;"
      expect(moneris_presenter.textbox).to include "margin-right: 0px;"
      expect(moneris_presenter.textbox).to include "margin-top: 0px;"
      expect(moneris_presenter.textbox).to include "padding-bottom: 8px;"
      expect(moneris_presenter.textbox).to include "padding-left: 8px;"
      expect(moneris_presenter.textbox).to include "padding-right: 8px;"
      expect(moneris_presenter.textbox).to include "padding-top: 8px;"
      expect(moneris_presenter.textbox).to include "text-align: start;"
      expect(moneris_presenter.textbox).to include "text-indent: 0px;"
      expect(moneris_presenter.textbox).to include "text-shadow: none;"
      expect(moneris_presenter.textbox).to include "text-transform: none;"
      expect(moneris_presenter.textbox).to include "transition-delay: 0s, 0s;"
      expect(moneris_presenter.textbox).to include "transition-duration: 0.45s, 0.45s;"
      expect(moneris_presenter.textbox).to include "transition-property: box-shadow, border-color;"
      expect(moneris_presenter.textbox).to include "transition-timing-function: ease, ease-in-out;"
      expect(moneris_presenter.textbox).to include "width: 100%;"
      expect(moneris_presenter.textbox).to include "word-spacing: 0px;"
      expect(moneris_presenter.textbox).to include "writing-mode: lr-tb;"
    end
  end
end
