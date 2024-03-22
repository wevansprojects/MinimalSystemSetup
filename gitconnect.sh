read -p "Enter your github repository name: " repo
git clone git@github.com:wevansprojects/$repo.git
cd "$repo"
git config user.name "Name"
git config user.email "firstname.lastname@domain.com"
git remote add origin git@github.com:wevansprojects/$repo.git
touch testfile.txt
git add .
git commit -m "Initial commit"
git status
git push --set-upstream origin main
