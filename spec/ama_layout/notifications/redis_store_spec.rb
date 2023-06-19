describe AmaLayout::Notifications::RedisStore do
  subject do
    described_class.new(
      db: 4,
      namespace: 'test_notifications',
      host: 'localhost'
    )
  end

  around(:each) do |example|
    subject.clear
    example.run
    subject.clear
  end

  describe '#get' do
    context 'when a key is not present' do
      it 'returns nil' do
        expect(subject.get('missing')).to be nil
      end
    end

    context 'when a key is present' do
      before(:each) do
        subject.set('key', 'value')
      end

      it 'returns the value' do
        expect(subject.get('key')).to eq('value')
      end
    end

    context 'with a default value' do
      it 'sets a nil key to the default value' do
        subject.get('missing', default: 'test')
        expect(subject.get('missing')).to eq('test')
      end
    end
  end

  describe '#set' do
    it 'sets the value for a given key' do
      subject.set('test', 'value')
      expect(subject.get('test')).to eq('value')
    end
  end

  describe '#delete' do
    context 'when a value is deleted' do
      before(:each) do
        subject.set('key', 'value')
      end

      it 'deletes the key' do
        subject.delete('key')
        expect(subject.get('key')).to be nil
      end
    end
  end

  describe '#transaction' do
    it 'does not commit if an exception is raised' do
      begin
        subject.transaction do |store|
          store.set('key', 'value')
          raise StandardError
        end
      rescue StandardError
      end
      expect(subject.get('key')).to be nil
    end

    it 'commits to redis successfully' do
      subject.transaction do |store|
        store.set('key', 'value')
      end
      expect(subject.get('key')).to eq('value')
    end
  end
end
