describe AmaLayout::Notifications::AbstractStore do
  context 'when inheriting' do
    subject { Class.new(described_class).new }

    describe '#get' do
      it 'raises NotImplementedError' do
        expect { subject.get('test') }.to raise_error(NotImplementedError)
      end
    end

    describe '#set' do
      it 'raises NotImplementedError' do
        expect { subject.set('test', 'test') }.to raise_error(NotImplementedError)
      end
    end

    describe '#delete' do
      it 'raises NotImplementedError' do
        expect { subject.delete('test') }.to raise_error(NotImplementedError)
      end
    end
  end
end
