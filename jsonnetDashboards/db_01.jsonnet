local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local template = grafana.template;
local row = grafana.row;
local textPanel = grafana.text;
local graphPanel = grafana.graphPanel;
local prometheus = grafana.prometheus;

dashboard.new(
  title='Demo Title'
)
.addTemplate(
  template.new(
    name='service',
    datasource='LocalPrometheus',
    query='label_values(service)',
    allValues=null,
    current='all',
    refresh='load',
    includeAll=true,
    multi=true,
  )
)
.addPanels([
  row.new(
    title='$service',
    repeat='service',
    showTitle=true,
  ) + { gridPos: {h: 2, w: 24, x: 0, y: 0} },
  graphPanel.new(
    title='CPU Usage',
    fill=2,
    formatY1='percentunit',
    datasource='LocalPrometheus',
  )
  .addTargets([
    prometheus.target(
      expr='process_cpu_usage{service=\"$service\"}',
      intervalFactor=1,
      legendFormat='process_cpu_usage',
    ),
    prometheus.target(
      expr='system_cpu_usage{service=\"$service\"}',
      intervalFactor=1,
      legendFormat='system_cpu_usage',
    ),
  ]) + {gridPos: {h: 6, w: 6, x: 0, y: 2}},
  graphPanel.new(
    title='Memory - Heap',
    fill=1,
    formatY1='decbytes',
    datasource='LocalPrometheus',
  )
  .addTargets([
    prometheus.target(
      expr='sum(jvm_memory_max{service=\"$service\", area=\"heap\"})',
      intervalFactor=1,
      legendFormat='max',
    ),
    prometheus.target(
      expr='sum(jvm_memory_committed{service=\"$service\", area=\"heap\"})',
      intervalFactor=1,
      legendFormat='committed',
    ),
    prometheus.target(
      expr='sum(jvm_memory_used{service=\"$service\", area=\"heap\"})',
      intervalFactor=1,
      legendFormat='used',
    ),
  ]) + {gridPos: {h: 6, w: 6, x: 6, y: 2}},
  graphPanel.new(
    title='Memory - Non-Heap',
    formatY1='decbytes',
    datasource='LocalPrometheus',
    fill=2,
  )
  .addTargets([
    prometheus.target(
      expr='sum(jvm_memory_max{service=\"$service\", area=\"nonheap\"})',
      intervalFactor=1,
      legendFormat='max',
    ),
    prometheus.target(
      expr='sum(jvm_memory_committed{service=\"$service\", area=\"nonheap\"})',
      intervalFactor=1,
      legendFormat='committed',
    ),
    prometheus.target(
      expr='sum(jvm_memory_used{service=\"$service\", area=\"nonheap\"})',
      intervalFactor=1,
      legendFormat='used',
    ),
  ]) + {gridPos: {h: 6, w: 6, x: 12, y: 2}},
])