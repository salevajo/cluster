node_name = "{{OPTIONS.node_name}}"
bind_addr = "{{OPTIONS.consul_address}}"
client_addr = "{{OPTIONS.consul_address}}"
addresses {
  http = "{{OPTIONS.consul_address}}"
}
data_dir = "{{PATH.consul_var}}"
datacenter = "dc1"

{% if not OPTIONS.client_only %}
server = true
server_name = "{{OPTIONS.node_name}}"
bootstrap_expect = {{OPTIONS.bootstrap_expect}}
{% else %}
server = false
{% endif %}

{{OPTIONS.consul_retry_join}}

ui = true
telemetry {
  dogstatsd_addr = "{{OPTIONS.consul_address}}:8125"
  disable_hostname = false
}
disable_anonymous_signature = true
disable_update_check = true

limits {
  https_handshake_timeout = "45s"
  http_max_conns_per_client = 300
  rpc_handshake_timeout = "45s"
  rpc_max_conns_per_client = 300
}
