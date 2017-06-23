describe AmaLayoutNavigationHelper do
  subject { FactoryGirl.create(:user) }

  describe '#navigation' do
    before(:each) do
      subject.class.include(AmaLayoutNavigationHelper).new
    end

    context 'non-member' do
      subject { FactoryGirl.create(:user, :non_member) }

      it 'shows non-member sidebar menu' do
        expect(subject.navigation).to eq 'non-member'
      end
    end

    context 'member' do
      it 'shows member sidebar menu' do
        expect(subject.navigation).to eq 'member'
      end
    end

    context 'member with accr' do
      subject { FactoryGirl.create(:user, :with_accr) }

      it 'shows member sidebar menu' do
        expect(subject.navigation).to eq 'member'
      end
    end

    context 'member with mpp' do
      subject { FactoryGirl.create(:user, :with_mpp) }

      it 'shows member sidebar menu' do
        expect(subject.navigation).to eq 'member'
      end
    end

    context 'member in-renewal' do
      subject { FactoryGirl.create(:user, :in_renewal) }

      it 'shows in-renewal sidebar menu' do
        expect(subject.navigation).to eq 'member-in-renewal'
      end
    end

    context 'member in-renewal late' do
      subject { FactoryGirl.create(:user, :in_renewal_late) }

      it 'shows in-renewal-late sidebar menu' do
        expect(subject.navigation).to eq 'member-in-renewal-late'
      end
    end
  end
end
