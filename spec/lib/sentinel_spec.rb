RSpec.describe Sentinel do
  it_should_behave_like 'source'

   let(:parsed_routes) {
    [
      { 'route_id' => '1', 'node' => 'alpha', 'index' => '0', 'time' => '2030-12-31T22:00:01+09:00' },
      { 'route_id' => '1', 'node' => 'beta', 'index' => '1', 'time' => '2030-12-31T18:00:02+05:00' },
      { 'route_id' => '1', 'node' => 'gamma', 'index' => '2', 'time' => '2030-12-31T16:00:03+03:00' },
      { 'route_id' => '2', 'node' => 'delta', 'index' => '0', 'time' => '2030-12-31T22:00:02+09:00' },
      { 'route_id' => '2', 'node' => 'beta', 'index' => '1', 'time' => '2030-12-31T18:00:03+05:00' },
      { 'route_id' => '2', 'node' => 'gamma', 'index' => '2', 'time' => '2030-12-31T16:00:04+03:00' },
      { 'route_id' => '3', 'node' => 'zeta', 'index' => '0', 'time' => '2030-12-31T22:00:02+09:00'}
    ]
  }

  context '#parse' do
    it 'assigns routes, node_times and sequences attributes' do
      expect(subject).to receive('routes=')
      subject.send(:parse)
    end

    it 'processes csvs' do
      subject.send(:parse)
      expect(subject.routes).to eq parsed_routes
    end
  end

  context '#body_params' do
    before do
      allow(subject).to receive(:routes).and_return(parsed_routes)
    end

    it_should_behave_like 'proper body params'
  end
end
