#!/bin/bash
for fn in fusion_recipes_cj2 missions skills_set `seq -f cards_section_%g 1 12` ; do
  curl http://mobile$1.tyrantonline.com/assets/${fn}.xml -R -z data/${fn}.xml -o data/${fn}.xml
done
