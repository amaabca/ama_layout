describe AmaLayout::NotificationSet do
  let(:redis) do
    AmaLayout::Notifications::RedisStore.new(
      db: 4,
      namespace: 'test_notifications',
      host: 'localhost'
    )
  end
  let(:key) { 1 }
  let(:redis_key) { "users/#{key}" }
  let(:json) do
    <<-JSON
    {
      "02ac263cea5660e9f9020cb46e93772ed7755f2a60c40ad8961d2a15c1f99e6f": {
      "type": "notice",
      "header": "test",
      "content": "test",
      "created_at": "2017-06-19T11:26:57.730-06:00",
      "active": true,
      "version": "1.0.0"
      }
    }
    JSON
  end

  subject { described_class.new(redis, key) }

  around(:each) do |example|
    redis.clear
    example.run
    redis.clear
  end

  describe '#intialize' do
    context 'with valid JSON in redis' do
      before(:each) do
        redis.set(redis_key, json)
      end

      it 'fetches the notifications' do
        expect(subject.size).to eq(1)
      end
    end

    context 'with invalid JSON in redis' do
      before(:each) do
        redis.set(redis_key, '{"invalid_json":')
      end

      it 'logs to Rails logger' do
        expect(Rails.logger).to receive(:error).with(instance_of(String))
        subject
      end

      it 'deletes the key in redis' do
        subject
        expect(redis.get(redis_key)).to be nil
      end

      it 'returns an empty set' do
        expect(subject).to be_empty
      end

      it 'sets the base attribute to a hash' do
        expect(subject.base).to be_a(Hash)
      end
    end

    context 'with no entry in redis' do
      it 'returns an empty set' do
        expect(subject).to be_empty
      end
    end
  end

  describe '#each' do
    before(:each) do
      redis.set(redis_key, json)
    end

    it 'iterates the array' do
      output = []
      subject.each do |element|
        output << element
      end
      expect(output).to_not be_empty
    end
  end

  describe '#create' do
    it 'returns the NotificationSet instance' do
      expect(subject.create(header: 'test', content: 'test')).to be_a(described_class)
    end

    it 'creates a new active notification' do
      subject.create(header: 'test', content: 'test')
      expect(subject.size).to eq(1)
    end

    it 'saves a notification in redis' do
      subject.create(header: 'test', content: 'test')
      expect(redis.get(redis_key)).to be_a(String)
    end
  end

  describe '#find' do
    context 'when id is not preset' do
      it 'returns nil' do
        expect(subject.find('invalid')).to be nil
      end
    end

    context 'when id is present' do
      let(:id) { subject.last.id }

      before(:each) do
        subject.create(header: 'test', content: 'test')
      end

      it 'returns the notification' do
        expect(subject.find(id)).to eq(subject.last)
      end
    end
  end

  describe '#save' do
    before(:each) do
      subject.create(header: 'test', content: 'test')
    end

    it 'saves the notifications' do
      expect(subject.last.active?).to be true
      subject.last.dismiss!
      subject.save
      expect(subject).to be_empty
    end

    it 'returns the NotificationSet instance' do
      expect(subject.save).to be_a(described_class)
    end
  end

  describe '#inspect' do
    it 'returns a stringifed instance' do
      expect(subject.inspect).to eq('<AmaLayout::NotificationSet>: []')
    end
  end
end
