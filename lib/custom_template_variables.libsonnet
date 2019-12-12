local grafana = import 'grafonnet/grafana.libsonnet';
local template = grafana.template;

{
  /**
  * returns a basic template variable for dashboards using the same prometheus source
  */
  prometheus():: template.new(
    name='service',
    datasource='LocalPrometheus',
    query='label_values(service)',
    allValues=null,
    current='all',
    refresh='load',
    includeAll=true,
    multi=true,
  ),
}