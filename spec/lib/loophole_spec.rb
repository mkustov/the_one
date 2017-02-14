RSpec.describe Loophole do
  it_should_behave_like 'source'

  let(:parsed_node_pairs) {
    [
      { 'id' => '1', 'start_node' => 'gamma', 'end_node' => 'theta' },
      { 'id' => '2', 'start_node' => 'beta', 'end_node' => 'theta' },
      { 'id' => '3', 'start_node' => 'theta', 'end_node' => 'lambda'}
    ]
  }

  let(:parsed_routes) {
    [
      { 'route_id' => '1', 'node_pair_id' => '1', 'start_time' => '2030-12-31T13:00:04Z', 'end_time' => '2030-12-31T13:00:05Z' },
      { 'route_id' => '1', 'node_pair_id' => '3', 'start_time' => '2030-12-31T13:00:05Z', 'end_time' => '2030-12-31T13:00:06Z' },
      { 'route_id' => '2', 'node_pair_id' => '2', 'start_time' => '2030-12-31T13:00:05Z', 'end_time' => '2030-12-31T13:00:06Z' },
      { 'route_id' => '2', 'node_pair_id' => '3', 'start_time' => '2030-12-31T13:00:06Z', 'end_time' => '2030-12-31T13:00:07Z' },
      { 'route_id' => '3', 'node_pair_id' => '9', 'start_time' => '2030-12-31T13:00:00Z', 'end_time' => '2030-12-31T13:00:00Z' }
    ]
  }

  context '#parse' do
    it 'assigns node_pairs and routes attributes' do
      expect(subject).to receive('node_pairs=')
      expect(subject).to receive('routes=')
      subject.send(:parse)
    end

    it 'processes json' do
      subject.send(:parse)
      expect(subject.node_pairs).to eq parsed_node_pairs
      expect(subject.routes).to eq parsed_routes
    end
  end

  context '#body_params' do
    before do
      allow(subject).to receive(:node_pairs).and_return(parsed_node_pairs)
      allow(subject).to receive(:routes).and_return(parsed_routes)
    end

    it_should_behave_like 'proper body params'
  end
end
