describe AmaLayout::NotificationSet do
  let(:store) do
    AmaLayout::Notifications::RedisStore.new(
      db: 4,
      namespace: 'test_notifications',
      host: 'localhost'
    )
  end
  let(:key) { 1 }
  let(:duration) { AmaLayout::Notification::DEFAULT_LIFESPAN.to_i }
  let(:store_key) { key.to_s }
  let(:digest) { '8ca9f850c18acc17643038b2341bee3ede8a24c0f3e92f56f2109ce49fdcb616' }
  let(:json) do
    <<-JSON
    {
      "#{digest}": {
        "type": "notice",
        "header": "test",
        "content": "test",
        "created_at": "2017-06-19T06:00:00.000Z",
        "active": true,
        "lifespan": #{duration},
        "version": "1.0.0"
      }
    }
    JSON
  end
  let(:stale_json) do
    <<-JSON
    {
      "d3c2bc71904100674325791b371db7446097f956ea76a304e787abd5f2588665": {
        "type": "notice",
        "header": "stale",
        "content": "stale",
        "created_at": "2012-06-19T06:00:00.000Z",
        "active": true,
        "lifespan": #{duration},
        "version": "1.0.0"
      }
    }
    JSON
  end

  subject { described_class.new(store, key) }

  around(:each) do |example|
    Timecop.freeze(Time.zone.local(2017, 6, 19)) do
      store.clear
      example.run
      store.clear
    end
  end

  describe '#intialize' do
    context 'with valid JSON in data store' do
      before(:each) do
        store.set(store_key, notification)
      end

      context 'without stale notifications in the data store' do
        let(:notification) { json }

        it 'fetches the notifications' do
          expect(subject.size).to eq(1)
        end
      end

      context 'with stale notifications in the data store' do
        let(:notification) { stale_json }

        it 'returns an empty set' do
          expect(subject).to be_empty
        end

        it 'cleans out stale notifications from the data store' do
          subject
          expect(store.get(store_key)).to eq('{}')
        end
      end
    end

    context 'with invalid JSON in data store' do
      before(:each) do
        store.set(store_key, '{"invalid_json":')
      end

      it 'logs to Rails logger' do
        expect(Rails.logger).to receive(:error).with(instance_of(String))
        subject
      end

      it 'deletes the key in data store' do
        subject
        expect(store.get(store_key)).to be nil
      end

      it 'returns an empty set' do
        expect(subject).to be_empty
      end

      it 'sets the base attribute to a hash' do
        expect(subject.base).to be_a(Hash)
      end
    end

    context 'with no entry in data store' do
      it 'returns an empty set' do
        expect(subject).to be_empty
      end
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

    it 'saves a notification in data store' do
      subject.create(header: 'test', content: 'test')
      expect(store.get(store_key)).to be_a(String)
    end

    context 'when the same notification exists but is dismissed' do
      before(:each) do
        store.set(store_key, json)
        subject.first.dismiss!
        subject.save
        subject.create(header: 'test', content: 'test')
      end

      it 'does not overwrite the notification' do
        expect(subject.active).to be_empty
      end

      it 'still has the dismissed notification in the data store' do
        data = JSON.parse(store.get(store_key))
        notification = data.values.first
        expect(data.values.first['active']).to be false
      end
    end
  end

  describe '#delete' do
    before(:each) do
      store.set(store_key, json)
    end

    context 'with an array as an argument' do
      it 'deletes the notification from the data store' do
        data = subject.delete([digest])
        expect(data).to be_a(described_class)
        expect(data).to be_empty
        expect(store.get(store_key)).to eq('{}')
      end

      it 'returns falsey if notthing is deleted' do
        expect(subject.delete(['missing'])).to be_falsey
      end
    end

    context 'with string arguments' do
      it 'deletes the notification from the data store' do
        data = subject.delete(digest)
        expect(data).to be_a(described_class)
        expect(data).to be_empty
        expect(store.get(store_key)).to eq('{}')
      end

      it 'returns falsey if nothing is deleted' do
        expect(subject.delete('missing')).to be_falsey
      end
    end
  end

  describe '#destroy' do
    context 'when data is removed' do
      before(:each) do
        subject.create(header: 'test', content: 'test', lifespan: 1.day)
      end

      it 'returns a NotificationSet instance' do
        expect(subject.destroy!).to be_a(described_class)
      end

      it 'removes the notifications from the data store' do
        subject.destroy!
        expect(store.get(store_key)).to be nil
      end

      it 'returns an empty set' do
        expect(subject.destroy!).to be_empty
      end
    end

    context 'when data is not removed' do
      it 'returns false' do
        expect(subject.destroy!).to be false
      end
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
      expect(subject.active).to be_empty
    end

    it 'returns the NotificationSet instance' do
      expect(subject.save).to be_a(described_class)
    end
  end

  describe '#inspect' do
    it 'returns a stringified instance' do
      expect(subject.inspect).to eq('<AmaLayout::NotificationSet>: []')
    end
  end

  context 'scoping' do
    before(:each) do
      subject.create(header: 'test', content: 'test')
      subject.create(header: 'inactive', content: 'inactive')
      subject.last.dismiss!
      subject.save
    end

    describe '#all' do
      it 'returns both active and inactive notifications' do
        expect(subject.all.size).to eq(2)
      end
    end

    describe '#active' do
      it 'returns only active notifications' do
        expect(subject.active.size).to eq(1)
      end
    end
  end
end
