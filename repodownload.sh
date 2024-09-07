#!/bin/bash
git clone git@github.com:wevansprojects/MinimalSystemSetup.git
cd MinimalSystemSetup
git config user.name "William Evans"
git config user.email "williamjevans@hotmail.com"
git branch 
touch .gitignore
echo "*.swp" >> .gitignore
git add .
git commit -m "Initial commit"
git status
git push --set-upstream origin main
