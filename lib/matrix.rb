require 'httparty'

class Matrix

  def get_out
    [Sentinel, Sniffer, Loophole].map { |klass| klass.new.submit }
  end

  private

  def submit
    parse
    body_params.map { |body| puts "\n"; print post(body) }
  end

  def parse
    raise "Not yet implemented"
  end

  def body_params
    raise "Not yet implemented"
  end

  def source
    raise "Not yet implemented"
  end

  def parse_csv(file_name)
    res = []
    CSV.foreach("db/#{source}/#{file_name}.csv", headers: true) { |row| res << row.to_hash }
    self.public_send("#{file_name}=", res)
  end

  def post(body)
    HTTParty.post("http://challenge.distribusion.com/the_one/routes",
      body: body.to_json,
      headers: { 'Content-Type' => 'application/json' } )
  end

  def format_time(str)
    DateTime.parse(str).to_time.utc.strftime("%FT%T")
  end

  def default_params
    { 'source' => source, 'passphrase' => 'Kans4s-i$-g01ng-by3-bye' }
  end
end
