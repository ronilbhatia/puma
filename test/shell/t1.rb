system "ruby -rrubygems -Ilib bin/puma -p 10102 -C test/shell/t1_conf.rb test/rackup/hello.ru &"

sleep 1 until system "curl http://localhost:10102/"

Process.kill :TERM, Integer(File.read("t1-pid"))

sleep 1

log = File.read("t1-stdout")

File.unlink "t1-stdout" if File.file? "t1-stdout"
File.unlink "t1-pid" if File.file? "t1-pid"

if log =~ %r!GET / HTTP/1\.1!
  exit 0
else
  exit 1
end
