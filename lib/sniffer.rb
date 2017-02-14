class Sniffer < Matrix
  attr_accessor :routes, :node_times, :sequences

  private

  def parse
    [:routes, :node_times, :sequences].each { |entry| parse_csv(entry) }
  end

  def body_params
    routes.map do |route|
      route_sequenses = sequences.select { |sequence| sequence['route_id'] == route['route_id'] }
      route_duration = route_sequenses.inject(0) do |sum, hop|
        hop_time = find_node_time(hop['node_time_id'])
        next unless hop_time
        sum + hop_time['duration_in_milliseconds'].to_i
      end

      start_node = find_node_time(route_sequenses.first['node_time_id'])
      end_node = find_node_time(route_sequenses.last['node_time_id'])
      next if start_node == end_node

      {
        'start_time'=> format_time(route['time']),
        'end_time'=> format_time(route['time'], route_duration),
        'start_node' => start_node['start_node'],
        'end_node' => end_node['end_node']
      }.merge(default_params)
    end.compact
  end

  def source
    'sniffers'
  end

  def format_time(str, offset = 0)
    Time.at(DateTime.parse(str).to_time.to_i + offset / 1000.0).utc.strftime("%FT%T")
  end

  def find_node_time(node_time_id)
    node_times.detect { |node_time| node_time['node_time_id'] == node_time_id }
  end
end
