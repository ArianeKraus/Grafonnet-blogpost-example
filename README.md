This repo includes a Grafonnet example with the usage of a self build, custom library.
(Grafonnet/lib and Jsonnet are needed for usage)

Jsonnet files can be compiled to JSON files through executing the command below in the shell within the root folder:

> $ jsonnet jsonnetDashboards/db_01.jsonnet 

With the command above, the resulting JSON will be shown in the shell. To store the JSON in a file use '-o' option:

> $ jsonnet -o db_01.json jsonnetDashboards/db_01.jsonnet 

How to get Jsonnet
1. Take a look at the getting started section of [Jsonnet](https://jsonnet.org/learning/getting_started.html).
2. Or download directly/ read the instructions [here](https://github.com/google/jsonnet) on the C++ repo [or here](https://github.com/google/go-jsonnet) on the Go repo.
3. You might want to add the jsonnet executable to your path variables for easier usage.

How to get Grafonnet
1. Grafonnet can be cloned from its [github repo](https://github.com/grafana/grafonnet-lib/tree/master/grafonnet).
2. To tell Jsonnet Grafonnet should be used as a library you need to pass grafonnet in during the command.

> $ jsonnet -J [grafonnetPath] jsonnetDashboards/db_01.jsonnet 

or add Grafonnet as a JSONNET_PATH environment variable.

Some more detailed information on how this was created can be found on the corresponding [blogpost](https://www.novatec-gmbh.de/en/blog/grafana-dashboards-as-code-with-grafonnet).
