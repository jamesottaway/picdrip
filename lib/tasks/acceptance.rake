task :acceptance do
  pid = Process.spawn 'rackup -p 9292 -E test'

  trap("INT") {
    Process.kill(9, pid) rescue Errno::ESRCH
    exit 0
  }
  
  until is_port_open?('localhost', '9292') do
    puts "Waiting for server to start listening..."
    sleep 1
  end
  
  Rake::Task['cucumber'].invoke
  
  Process.kill 9, pid
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