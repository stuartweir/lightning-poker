require 'tmpdir'
require 'pty'

BIN = File.expand_path("../../bin/play", __FILE__)

describe 'CLI' do
  
  before(:example) do
    dir = Dir.tmpdir + '/highcard_test_state'
    'rm -Rf #{dir}'
    'mkdir -p #{dir}'
    ENV['HIGHCARD_DIR'] = dir
  end
  
  example 'it works' do
    PTY.spawn(BIN) do |output, input, pid|
      sleep 0.5
      
      input.write("y\n")
      
      sleep 0.5
      
      buffer = output.read_nonblock(1024)
      puts buffer
      raise unless buffer.include?("You won") || buffer.include?("You lost")
    end
  end
  
  example 'betting on a winning hand' do
    PTY.spawn(BIN) do |output, input, pid|
      sleep 0.5
      
      input.write("y\n")
      
      sleep 0.5
      
      buffer = output.read_nonblock(1024)
      puts buffer
      raise unless buffer.include?("You won") || buffer.include?("You lost")
    end
  end
end