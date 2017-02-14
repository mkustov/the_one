RSpec.describe Matrix do
  %i(parse body_params source).each do |method_name|
    it { expect { subject.send(method_name) }.to raise_error('Not yet implemented') }
  end

  context '#format_time' do
    it 'properly parses time' do
      expect(subject.send(:format_time, '2030-12-31T13:00:06')).to eq '2030-12-31T13:00:06'
      expect(subject.send(:format_time, '2030-12-31T13:00:04Z')).to eq '2030-12-31T13:00:04'
      expect(subject.send(:format_time, '2030-12-31T22:00:02+09:00')).to eq '2030-12-31T13:00:02'
    end
  end
end
