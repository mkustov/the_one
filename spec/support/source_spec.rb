RSpec.shared_examples 'source' do
  %i(parse body_params source).each do |method_name|
    it { expect { subject.send(method_name) }.not_to raise_error("Not yet implemented") }
  end
end

RSpec.shared_examples 'proper body params' do
  it 'formats request params properly' do
    expect(subject.send(:body_params)).to be_kind_of(Array)
    subject.send(:body_params).each do |body|
      expect(body).to have_key('start_time')
      expect(body).to have_key('end_time')
      expect(body).to have_key('start_node')
      expect(body).to have_key('end_node')
      expect(body).to have_key('source')
      expect(body).to have_key('passphrase')

      expect(body['start_time']).not_to be_nil
      expect(body['end_time']).not_to be_nil
      expect(body['start_node']).not_to be_nil
      expect(body['end_node']).not_to be_nil
      expect(body['source']).not_to be_nil
      expect(body['passphrase']).not_to be_nil
    end
  end
end
