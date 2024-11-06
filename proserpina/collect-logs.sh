#!/usr/bin/env bash


function reformat {
  while read line
  do
    PARTY="${c%%-*}"
    NODE="${c##*-}"
    echo -n "$line" | jq -c '{party : "'"$PARTY"'", node : '"$NODE"', at : .at} + (.data.val | del (.kind))'
  done
}

for c in hon-1 hon-2 hon-3 hon-4 hon-5 adv-6 adv-7 adv-8 adv-9
do
  podman logs --names --follow proserpina-$c \
  | tee >( gzip -9c > proserpina-$c.log.gz ) \
  | grep ForgedBlock \
  | reformat $c \
  | tee blocks-$c.jsonarray &
done
wait

cat blocks-???-?.jsonarray | dasel -r json -w csv | sort -ur > chain.csv
