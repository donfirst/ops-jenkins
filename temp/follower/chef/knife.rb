current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name       "jenkins-master"
client_key      "#{current_dir}/client.pem"
chef_server_url "https://api.opscode.com/organizations/elastera"