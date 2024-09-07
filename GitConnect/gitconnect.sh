#!/bin/bash
function pause(){
local message="$@"
[ -z $message ] && message="Press [Enter] key to continue..."
read -p "$message" readEnterKey
}

echo "PLEASE NOTE:"
echo "This script is for personal use only.  Use at your own risk."
echo ":-------------------------------------------------------------------------------------------:"
echo ":GIT CONNECT CHECKLIST:                                                                     "
echo "Please ensure you have an .ssh directory the relevant ssh keys with the correct permissions "
echo "Please open a tab in the terminal and run the following commands                            "
echo "git --version; ssh -T git@github.com; cat ~/.ssh/config | grep 'github\|\user git\|public'  "
echo "To Learn More About Connecting To Git Type: vim GitExampleForNewProject.txt" 
echo ":-------------------------------------------------------------------------------------------:"
echo "Please Confirm You Are OK To Continue Y/N ?";read input

pause

if [ $input == "Y" ]; then
      echo "OK Continuing Script..."
      echo "Example: git clone git@github.com:someproject/somerepo.git"

      read -p "Enter your github project name: " project
      read -p "Enter your github repository name: " repo
      read -p "Enter your github username: " username
      read -p "Enter your github email: " email
      read -p "Enter your branch name:(Pressing Enter will default to main) " branch

      echo "#!/bin/bash" >> repodownload.sh
      echo "git clone git@github.com:$project/$repo.git" >> repodownload.sh
      echo "cd $repo" >> repodownload.sh
      echo "git config user.name \"$username\"" >> repodownload.sh
      echo "git config user.email \"$email\"" >> repodownload.sh
#      echo "git remote add origin git@github.com:wevansprojects/$repo.git" >> repodownload.sh
      if [ -z "$branch" ]
      then
        branch="main"
      else
        echo "git checkout -b $branch" >> repodownload.sh
      fi
      echo "git branch " >> repodownload.sh
      echo "touch .gitignore" >> repodownload.sh
      echo "echo \"*.swp\" >> .gitignore" >> repodownload.sh
      echo "git add ." >> repodownload.sh
      echo "git commit -m \"Initial commit\"" >> repodownload.sh
      echo "git status" >> repodownload.sh
      echo "git push --set-upstream origin $branch" >> repodownload.sh
      chmod +x repodownload.sh

      echo "#!/bin/bash" >> gitcommit.sh
      echo "git add ." >> gitcommit.sh
      echo "git commit -m \"amended file\"" >> gitcommit.sh
      echo "git push" >> gitcommit.sh
      chmod +x gitcommit.sh

      echo "Program COMPLETED"
      echo "Scripts generated to clone and push to github"
      echo "To Clone a Repo: repodownload.sh"
      echo "To Run Commit Commands: gitcommit.sh"

elif [ $input == "N" ]; then
	echo "OK Exiting Script..."
      exit
else
	echo "I Don't Understand Your Selection:"
      exit
fi

