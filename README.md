### folsom_webmachine

This is an application that exposes folsom metrics via http using webmachine.


#### usage

        > folsom_webmachine_sup:start_link().
        > application:start(folsom).
        
        or just run start_dev.sh start_dev is a bit differnt from above method.
        * This will automatically takes care of starting all the dependencies app for you. What is going during start up stage.
        * It starts sasl so that the app is an erlang node being managed by Erlang SASL. Better progress report etc.
        * the script gave the node a short name as folsom. You can change that to your liking.
        
        On a suucessful start, You will see something like the follow in shell (pay attention to the last few lines)
        =PROGRESS REPORT==== 23-Jul-2014::13:14:06 ===
          supervisor: {local,folsom_webmachine_sup}
             started: [{pid,<0.96.0>},
                       {name,webmachine_mochiweb},
                       {mfargs,
                           {webmachine_mochiweb,start,
                               [[{ip,"127.0.0.1"},
                                 {port,"5565"},
                                 {log_dir,"priv/log"},
                                 {dispatch,
                                     [{["_system"],
                                       folsom_webmachine_system_resource,[]},
                                      {["_memory"],
                                       folsom_webmachine_memory_resource,[]},
                                      {["_statistics"],
                                       folsom_webmachine_statistics_resource,
                                       []},
                                      {["_process"],
                                       folsom_webmachine_process_resource,[]},
                                      {["_port"],
                                       folsom_webmachine_port_resource,[]},
                                      {["_ping"],
                                       folsom_webmachine_ping_resource,[]},
                                      {["_health"],
                                       folsom_webmachine_health_resource,[]},
                                      {["_metrics"],
                                       folsom_webmachine_metrics_resource,[]},
                                      {["_metrics",id],
                                       folsom_webmachine_metrics_resource,[]},
                                      {["_ets"],
                                       folsom_webmachine_ets_resource,[]},
                                      {["_dets"],
                                       folsom_webmachine_dets_resource,
                                       []}]}]]}},
                       {restart_type,permanent},
                       {shutdown,5000},
                       {child_type,worker}]
                       
        =PROGRESS REPORT==== 23-Jul-2014::13:14:06 ===
                 application: folsom_webmachine
                  started_at: folsom_webmachine@developerVBox
#### Sanity Test
        run sanity_test.sh
        It only runs the Query Erlang VM metrics, stats and information listed below automatically. 
        This is to show that you at least have a working setup.

#### To Generaate an Erlang OTP Release
        run ./rebar -v generate or Make release
        If you want to package this as an Erlang OTP release application.
        sanity_test.sh is also copied to the package bin.
        All the release package configuration details in rel/reltool.config
        Release is generated under rel/folsom_webmachine, with the Erlang runtime and project depencies library in.
        Erlang Release only responsible for Erlang app but not the external depedencies for example those C lib.
        That means you can just zipped thie folder and deployed to a clean machine (provided you have all the c lib, that they need)
        There is no need to install erlang runtime o target system as that is already embedded inside the release.
        
        Note there is no appup configuration and related logic, so no hot code swap at the momemt.
        
        Look at rel/files/folsom_webmachine to see the details:
        Sample usage
        To start a running release Use folsom_webmachine start 
        To attach a running folsom_webmachine node. Use folsom_webmachine attach. 

#### api

Query the list of available metrics:

        $ curl http://localhost:5565/_metrics

Query a specific metric:

        $ curl http://localhost:5565/_metrics/name

Create a new metric:

        $ curl -X PUT http://localhost:5565/_metrics -d '{"id": "a", "type": "counter"}' -H "Content-Type: application/json"

Update a metric:

        $ curl -X PUT http://localhost:5565/_metrics/a -d '{"value" : {"inc": 1}}' -H "Content-Type: application/json"

Delete a metric:

        $ curl -X DELETE http://localhost:5565/_metrics/a

Query Erlang VM metrics:

        $ curl http://localhost:5565/_memory

Query Erlang VM stats:

        $ curl http://localhost:5565/_statistics

Query Erlang VM information:

        $ curl http://localhost:5565/_system

#### output

        $ curl http://localhost:5565/_metrics/a
        {"value":{"min":1,"max":1000,"mean":322.2,"median":100,"variance":185259.19999999998,"standard_deviation":430.4174717643325,"skewness":1.2670136514902162,"kurtosis":-1.2908313302242205,"percentile":{"75":500,"95":1000,"99":1000,"999":1000},"histogram":{"10":2,"20":0,"30":0,"50":0,"100":1,"200":0,"300":0,"400":0,"500":1,"1000":1,"99999999999999":0}}}


         $ curl http://localhost:5565/_metrics/test

         {"value":{"1303483997384193":{"event":"asdfasdf"}}}


         $ curl http://localhost:5565/_memory
         {"total":11044608,"processes":3240936,"processes_used":3233888,"system":7803672,"atom":532137,"atom_used":524918,"binary":696984,"code":4358030,"ets":385192}

#### To Develop

        

