/**
  Dashboard 02 - equal to dashboard 01 but with use of custom library and iteration for creating panels
 */
local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local textPanel = grafana.text;
local graphPanel = grafana.graphPanel;
local prometheus = grafana.prometheus;

local customVariables = import '../lib/custom_template_variables.libsonnet';

local panels = [
  {
    title: 'CPU Usage',
    formatY1: 'percentunit',
    gridPos: {h: 6, w: 6, x: 0, y: 2},
    targets: [
      {
        expr: 'process_cpu_usage{service=\"$service\"}',
        legendFormat: 'process_cpu_usage'
      },
      {
        expr: 'system_cpu_usage{service=\"$service\"}',
        legendFormat: 'system_cpu_usage'
      },
    ],
  },
  {
    title: 'Memory - Heap',
    formatY1: 'decbytes',
    gridPos: {h: 6, w: 6, x: 6, y: 2},
    targets: [
      {
        expr: 'sum(jvm_memory_max{service=\"$service\", area=\"heap\"})',
        legendFormat: 'max'
      },
      {
        expr: 'sum(jvm_memory_committed{service=\"$service\", area=\"heap\"})',
        legendFormat: 'committed'
      },
      {
        expr: 'sum(jvm_memory_used{service=\"$service\", area=\"heap\"})',
        legendFormat: 'used'
      },
    ],
  },
  {
    title: 'Memory - Non-Heap',
    formatY1: 'decbytes',
    gridPos: {h: 6, w: 6, x: 12, y: 2},
    targets: [
      {
        expr: 'sum(jvm_memory_max{service=\"$service\", area=\"nonheap\"})',
        legendFormat: 'max'
      },
      {
        expr: 'sum(jvm_memory_committed{service=\"$service\", area=\"nonheap\"})',
        legendFormat: 'committed'
      },
      {
        expr: 'sum(jvm_memory_used{service=\"$service\", area=\"nonheap\"})',
        legendFormat: 'used'
      },
    ],
  },
];

dashboard.new(
  title='Demo Title'
)
.addTemplate(
  customVariables.prometheus()
)
.addPanels(
  [
    row.new(
      title='$service',
      repeat='service',
      showTitle=true,
    ) + { gridPos: {h: 2, w: 24, x: 0, y: 0} },
  ] + [
    graphPanel.new(
      title=obj.title,
      fill=2,
      formatY1=obj.formatY1,
      datasource='LocalPrometheus',
    )
    .addTargets(
      [
        prometheus.target(
          expr=target.expr,
          legendFormat=target.legendFormat,
          intervalFactor=1,
        )
        for target in obj.targets
      ],
    ) + {gridPos: obj.gridPos},
    for obj in panels
  ],
)