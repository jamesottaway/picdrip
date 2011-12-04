task :acceptance do
  picdrip = Process.spawn 'rackup -p 9292 -E test'
  
  until is_port_open?('localhost', '9292') do
    puts "Waiting for Picdrip to start listening..."
    sleep 1
  end
  
  flickr_fakr = Process.spawn 'flickr_fakr'

  until is_port_open?('localhost', '4567') do
    puts "Waiting for FlickrFakr to start listening..."
    sleep 1
  end

  trap("INT") {
    Process.kill(9, picdrip) rescue Errno::ESRCH
    Process.kill(9, flickr_fakr) rescue Errno::ESRCH
    exit 0
  }
  
  Rake::Task['cucumber'].invoke
  
  Process.kill 9, picdrip
  Process.kill 9, flickr_fakr
end

private

def is_port_open?(ip, port)
  begin
    Timeout::timeout(1) do
      begin
        s = TCPSocket.new(ip, port)
        s.close
        return true
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        return false
      end
    end
  rescue Timeout::Error
  end

  return false
end