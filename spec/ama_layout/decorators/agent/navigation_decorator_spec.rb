# frozen_string_literal: true

describe AmaLayout::Agent::NavigationDecorator do
  let(:name) { 'John D' }
  let(:cash_drawer) { OpenStruct.new(name: 'Edmonton Main') }
  let(:user) { OpenStruct.new(email: 'john.doe@test.com', cash_drawers: [cash_drawer]) }
  let(:navigation) { FactoryBot.build(:agent_navigation, user: user, display_name: name) }
  subject { navigation.decorate }

  describe "#display_name_text" do
    context "user does have a cash drawer" do
      it "is part of the welcome message" do
        expect(subject.display_name_text).to eq "Welcome, John D - Edmonton Main"
      end

      context "the user does not have a cash drawer" do
        let(:cash_drawer) { nil }
        it "is not part of the welcome message" do
          expect(subject.display_name_text).to eq "Welcome, John D"
        end
      end
    end
  end

  describe "#items" do
    it "returns an array of navigation items" do
      expect(subject.items).to be_an Array
    end

    it "array contains decorated navigation items" do
      items = subject.items
      items.each do |i|
        expect(i).to be_a AmaLayout::NavigationItemDecorator
      end
    end
  end

  describe "#sign_out_link" do
    context "with user" do
      it "returns link" do
        expect(subject.sign_out_link).to include "Sign Out"
      end
    end

    context "without user" do
      let(:user) { nil }

      it "does not return the link" do
        expect(subject.sign_out_link).to eq ""
      end
    end
  end

  describe "#top_nav" do
    context "with user" do
      it "renders the partial" do
        expect(subject.top_nav).to include('has-submenu')
      end
    end

    context "without user" do
      let(:user) { nil }

      it "does not renders the partial" do
        expect(subject.top_nav).to eq ''
      end
    end
  end

  describe "#sidebar" do
    context "with user" do
      it "renders the partial" do
        expect(subject.sidebar).to include('aside')
      end
    end

    context "without user" do
      let(:user) { nil }

      it "does not renders the partial" do
        expect(subject.sidebar).to eq ''
      end
    end
  end
end
