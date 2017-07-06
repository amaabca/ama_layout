describe AmaLayout::NotificationScrubber do
  describe '#initialize' do
    let(:sanitized) { Loofah.fragment(string).scrub!(subject).to_s }
    let(:string) { '<script>alert("haxxed");</script><a href="#" invalid="test">test</a>waffles' }

    it 'scrubs HTML tags from a string' do
      expect(sanitized).to eq('alert("haxxed");<a href="#">test</a>waffles')
    end
  end
end
