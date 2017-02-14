RSpec.describe Sniffer do
  it_should_behave_like 'source'

  let(:parsed_routes) {
    [
      { 'route_id' => '1', 'time' => '2030-12-31T13:00:06', 'time_zone' => 'UTC±00:00' },
      { 'route_id' => '2', 'time' => '2030-12-31T13:00:07', 'time_zone' => 'UTC±00:00' },
      { 'route_id' => '3', 'time' => '2030-12-31T13:00:00', 'time_zone' => 'UTC±00:00' }
    ]
  }

  let(:parsed_node_times) {
    [
      { 'node_time_id' => '1', 'start_node' => 'lambda', 'end_node' => 'tau', 'duration_in_milliseconds' => '1000' },
      { 'node_time_id' => '2', 'start_node' => 'tau', 'end_node' => 'psi', 'duration_in_milliseconds' => '1000' },
      { 'node_time_id' => '3', 'start_node' => 'psi', 'end_node' => 'omega', 'duration_in_milliseconds' => '1000' },
      { 'node_time_id' => '4', 'start_node' => 'lambda', 'end_node' => 'psi', 'duration_in_milliseconds' => '1000' }
    ]
  }

  let(:parsed_sequences) {
    [
      { 'route_id' => '1', 'node_time_id' => '1' },
      { 'route_id' => '1', 'node_time_id' => '2' },
      { 'route_id' => '1', 'node_time_id' => '3' },
      { 'route_id' => '2', 'node_time_id' => '4' },
      { 'route_id' => '2', 'node_time_id' => '3' },
      { 'route_id' => '3', 'node_time_id' => '9' }
    ]
  }

  context '#parse' do
    it 'assigns routes, node_times and sequences attributes' do
      expect(subject).to receive('routes=')
      expect(subject).to receive('node_times=')
      expect(subject).to receive('sequences=')
      subject.send(:parse)
    end

    it 'processes csvs' do
      subject.send(:parse)
      expect(subject.routes).to eq parsed_routes
      expect(subject.node_times).to eq parsed_node_times
      expect(subject.sequences).to eq parsed_sequences
    end
  end

  context '#body_params' do
    before do
      allow(subject).to receive(:routes).and_return(parsed_routes)
      allow(subject).to receive(:node_times).and_return(parsed_node_times)
      allow(subject).to receive(:sequences).and_return(parsed_sequences)
    end

    it_should_behave_like 'proper body params'
  end

  context '#format_time' do
    it 'properly parses miliseconds offsets' do
      expect(subject.send(:format_time, '2030-12-31T13:00:06')).to eq '2030-12-31T13:00:06'
      expect(subject.send(:format_time, '2030-12-31T13:00:06', 1000)).to eq '2030-12-31T13:00:07'
      expect(subject.send(:format_time, '2030-12-31T13:00:06', 3000)).to eq '2030-12-31T13:00:09'
    end
  end
end
