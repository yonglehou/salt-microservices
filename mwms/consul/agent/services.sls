# {% set services = salt['pillar.get']('consul:services', {}) %}

{% for service_name, service_config in services %}
{% set consul_service_definition = {"service": service_config} %}
/etc/consul/service-{{ service_name }}.json:
  file.managed:
    - contents: {{ consul_service_definition | json() }}
    - require:
      - file: /usr/local/sbin/consul
      - file: /etc/consul
    - watch_in:
      - module: consul-agent-reload
{% endfor %}
