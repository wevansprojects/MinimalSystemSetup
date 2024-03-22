read -p "Enter your github username: " username
read -p "Enter your github emailaddress: " email
read -p "Enter your github repository name: " repo
git clone git@github.com:wevansprojects/$repo.git
cd "$repo"
git config user.name "$username"
git config user.email "$email"
git add .
git commit -m "Initial commit"
git push -u origin master
