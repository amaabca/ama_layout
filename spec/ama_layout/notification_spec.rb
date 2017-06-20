describe AmaLayout::Notification do
  let(:instance) do
    described_class.new(
      header: 'test',
      content: 'test',
      active: true,
      created_at: Time.current
    )
  end

  describe '#initialize' do
    subject do
      described_class.new(
        header: 'test',
        'content': 'test',
        'active': true,
        'created_at': time
      )
    end

    context 'with a time created_at attribute' do
      let(:time) { Time.current }

      it 'accepts both symbols and strings as hash keys' do
        expect(subject.header).to eq('test')
        expect(subject.active).to be true
      end

      it 'sets a version by default' do
        expect(subject.version).to eq(described_class::FORMAT_VERSION)
      end
    end

    context 'with a string created_at attribute' do
      let(:time) { '1984-01-01' }

      it 'parses the string as a time' do
        expect(subject.created_at).to eq(Time.zone.parse(time))
      end
    end

    context 'with an invalid type attribute' do
      let(:parameters) do
        {
          type: :invalid,
          header: 'test',
          content: 'test',
          created_at: Time.current,
          active: true
        }
      end

      it 'raises ArgumentError' do
        expect { described_class.new(parameters) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#<=>' do
    let(:old) do
      described_class.new(
        header: 'test',
        content: 'test',
        active: true,
        created_at: Date.new(1984)
      )
    end
    let(:new) do
      described_class.new(
        header: 'test',
        content: 'test',
        active: true,
        created_at: Date.new(2017)
      )
    end

    it 'sorts by created_at date' do
      expect(old <=> new).to eq(-1)
    end
  end

  describe '#active?' do
    subject do
      described_class.new(
        header: 'test',
        content: 'test',
        active: active,
        created_at: Time.current
      )
    end

    context 'when active' do
      let(:active) { true }

      it 'returns true' do
        expect(subject.active?).to be true
      end
    end

    context 'when inactive' do
      let(:active) { false }

      it 'returns false' do
        expect(subject.active?).to be false
      end
    end
  end

  describe 'dismissed?' do
    subject do
      described_class.new(
        header: 'test',
        content: 'test',
        active: active,
        created_at: Time.current
      )
    end

    context 'when active' do
      let(:active) { true }

      it 'returns false' do
        expect(subject.dismissed?).to be false
      end
    end

    context 'when inactive' do
      let(:active) { false }

      it 'returns true' do
        expect(subject.dismissed?).to be true
      end
    end
  end

  describe '#dismiss!' do
    it 'returns true' do
      expect(instance.dismiss!).to be true
    end

    it 'sets the :active flag to false' do
      instance.dismiss!
      expect(instance.active?).to be false
    end
  end

  describe '#digest' do
    context 'with the same objects' do
      let(:other) { instance.dup }

      it 'produces the same digest' do
        expect(instance.digest).to eq(other.digest)
      end
    end

    context 'with different objects' do
      let(:other) do
        described_class.new(
        header: 'other',
        content: 'other',
        active: true,
        created_at: Time.current
      )
      end

      it 'produces different digests' do
        expect(instance.digest).to_not eq(other.digest)
      end
    end
  end

  describe '#to_h' do
    it 'returns a hash' do
      expect(instance.to_h).to be_a(Hash)
    end

    it 'is not empty' do
      expect(instance.to_h).to_not be_empty
    end
  end
end
