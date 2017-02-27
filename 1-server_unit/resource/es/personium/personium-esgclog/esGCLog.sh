#! /bin/sh
#
# Personium
# Copyright 2016 - 2017 FUJITSU LIMITED
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
FULL_GC_LOG_FILE_NAME=fullGC.log
FULL_GC_LOG_DIRECTORY=/personium/elasticsearch/log

# Print out jstat line only when the full gc performed.
while :
do
        # Get processID of Elasticsearch
        ES_PROCESS_ID=`/opt/jdk/bin/jps | /bin/grep -w WrapperSimpleApp | /bin/cut -d " " -f 1`

        if [ -n "$ES_PROCESS_ID" ]; then
                # Print out jstat line only when the full gc is performed.
                echo "Elastisearch process detected: $ES_PROCESS_ID" >> $FULL_GC_LOG_DIRECTORY/$FULL_GC_LOG_FILE_NAME
                /opt/jdk/bin/jstat -gcutil -t $ES_PROCESS_ID 5s | /bin/awk '{print strftime("%Y/%m/%d %H:%M:%S"), $0; fflush()}' | /bin/awk -f /personium/personium-esgclog/printFullGC.awk >> $FULL_GC_LOG_DIRECTORY/$FULL_GC_LOG_FILE_NAME
                # When the target process is killed, the jstat command terminates.  We will try to find a new process ID with while-loop.
        else
                # In case of that Elasticsearch is not running,  sleep a while, then try to find a new process...
                /bin/sleep 5s
        fi
done
