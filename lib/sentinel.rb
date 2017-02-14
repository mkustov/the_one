class Sentinel < Matrix
  attr_accessor :routes

  private

  def parse
    parse_csv(:routes)
  end

  def body_params
    result = []
    parsed_route_ids = []
    routes.each do |route|
      next if parsed_route_ids.include? route['route_id']
      parsed_route_ids << route['route_id']

      sorted_routes = routes.select { |r| r['route_id'] == route['route_id'] }.sort_by{|r| r['index']}
      next if sorted_routes.size < 2

      start_node = sorted_routes.first
      end_node = sorted_routes.last

      result << {
        'start_time'=> format_time(start_node['time']),
        'end_time'=> format_time(end_node['time']),
        'start_node' => start_node['node'],
        'end_node' => end_node['node']
      }.merge(default_params)
    end
    result
  end

  def source
    'sentinels'
  end
end
