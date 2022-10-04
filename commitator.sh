#!/bin/bash

echo "Enter your repository link"
read repo

# Cean directory
rm -rf dir

# Max commits per day
echo "Enter the max number of commits you'd like in a day"
read max

# Initialize git
mkdir dir && cd dir
git init

# Days application
N=365
date=$(date +%s)

echo "Generating fake contributions"
for i in $(seq $N -1 0)
    do
        rand=$(((RANDOM % $max ) + 1))
        for j in $(seq 1 $rand)
            do
                filename="${i}_${j}"

                let "new_date = $date - ($i * 60*60*24)"

                touch $filename
                git add $filename
                git commit --date="$new_date" -m "$filename" >/dev/null 2>>../error.log

            done
    done

git remote add origin $repo
git push origin master
