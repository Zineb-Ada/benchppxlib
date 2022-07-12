#!/bin/bash

# cat ./hyperfinejson.txt
hyperfinejson=$(jq .results[0].mean hyperfinejson.txt)

function pr_bench {
     # echo jq '.' ./hyperfinejson.txt \
     echo '{"results": [{"name": "'$1'", "metrics": [{"name": "'$2'", "value": '$3', "units": "ms"}]}]}'
}

pr_bench ppxderiving derivingshow $hyperfinejson
