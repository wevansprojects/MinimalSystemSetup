#read -p "Enter your github username: " username
#read -p "Enter your github emailaddress: " email
read -p "Enter your github repository name: " repo
git clone git@github.com:wevansprojects/$repo.git
cd "$repo"
git config user.name "William Evans"
git config user.email "williamjevans@hotmail.com"
git remote add origin git@github.com:wevansprojects/$repo.git
touch testfile.txt
git add .
git commit -m "Initial commit"
git status
git push --set-upstream origin main
#git push -u origin master
#git remote add origin git@github.com:wevansprojects/$repo.git
#git add .
#git commit -m "Initial commit"
#git push -u origin master
