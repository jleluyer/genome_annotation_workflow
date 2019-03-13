#!/usr/bin/env bash

# Clean up
rm 00_scripts/datarmor_jobs/GENBLAST*sh

# launch scripts for Colosse
for file in $(ls x*fa|sed 's/.fa//g')

do
	base=$(basename "$file")
	toEval="cat 00_scripts/01_genblast_homology.sh | sed 's/__BASE__/$base/g'"; eval $toEval > 00_scripts/datarmor_jobs/GENBLAST_"$base".sh
done


#Submit jobs
for i in $(ls 00_scripts/datarmor_jobs/GENBLAST*sh); do qsub $i; done

