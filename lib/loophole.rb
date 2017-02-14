class Loophole < Matrix
  attr_accessor :node_pairs, :routes

  private

  def parse
    self.node_pairs = JSON.parse(File.read("db/#{source}/node_pairs.json"))['node_pairs']
    self.routes = JSON.parse(File.read("db/#{source}/routes.json"))['routes']
  end

  def body_params
    routes.map do |route|
      node_pair = node_pairs.detect { |np| np['id'] == route['node_pair_id'] }
      {
        'start_time'=> format_time(route['start_time']),
        'end_time'=> format_time(route['end_time']),
        'start_node' => node_pair['start_node'],
        'end_node' => node_pair['end_node']
      }.merge(default_params) if node_pair
    end.compact
  end

  def source
    'loopholes'
  end
end
