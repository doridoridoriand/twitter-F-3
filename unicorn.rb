require 'systemu'

@directory = '/home/vagrant/works/16tech/api/'

worker_processes 4
working_directory @directory

timeout 30
listen  3000

pid "#{@directory}config/pids/unicorn.pid"

stderr_path "#{@directory}log/unicorn.stderr.log"
stdout_path "#{@directory}log/unicorn.stdout.log"
