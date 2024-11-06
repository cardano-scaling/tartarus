#!/usr/bin/env bash


cat << EOI > graph.dot
digraph g {
rankdir=RL
node [shape=record]
"GenesisH" [label="genesis" shape=oval]

EOI

jq -r '"\"" + .block[0:8] + "\" [label=<<b>" + .block[0:8] + "</b>|block " + (.blockNo | tostring) + "|slot " + (.slot | tostring) + "|node " + (.node | tostring) + ">]"'           blocks-hon-?.jsonarray >> graph.dot
jq -r '"\"" + .block[0:8] + "\" [label=<<b>" + .block[0:8] + "</b>|block " + (.blockNo | tostring) + "|slot " + (.slot | tostring) + "|node " + (.node | tostring) + "> color=red]"' blocks-adv-?.jsonarray >> graph.dot

jq -r '"\"" + .block[0:8] + "\" -> \"" + .blockPrev[0:8] + "\""'             blocks-hon-?.jsonarray >> graph.dot
jq -r '"\"" + .block[0:8] + "\" -> \"" + .blockPrev[0:8] + "\" [color=red]"' blocks-adv-?.jsonarray >> graph.dot

cat << EOI >> graph.dot
}
EOI
