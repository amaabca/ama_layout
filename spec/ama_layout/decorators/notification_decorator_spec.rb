describe AmaLayout::NotificationDecorator do
  let(:notification) do
    AmaLayout::Notification.new(
      header: 'test',
      content: 'content',
      type: :warning,
      created_at: Date.yesterday.beginning_of_day,
      active: true
    )
  end
  subject { described_class.new(notification) }

  describe '#created_at' do
    around(:each) do |example|
      Timecop.freeze(Time.zone.local(2017, 8)) do
        example.run
      end
    end

    it 'returns the time elapsed in english words' do
      expect(subject.created_at).to eq('1 day ago')
    end
  end

  describe '#icon' do
    it 'returns a div' do
      expect(subject.icon).to include('<div')
    end

    it 'contains the proper icon class' do
      expect(subject.icon).to include('fa-exclamation')
    end

    it 'contains the proper colour class' do
      expect(subject.icon).to include('right-sidebar__content-icon--orange')
    end
  end

  describe '#active_class' do
    context 'when active' do
      it 'returns the proper class' do
        expect(subject.active_class).to_not include('inactive')
        expect(subject.active_class).to include('active')
      end
    end

    context 'when inactive' do
      before(:each) do
        notification.dismiss!
      end

      it 'returns the proper class' do
        expect(subject.active_class).to include('inactive')
      end
    end
  end
end
