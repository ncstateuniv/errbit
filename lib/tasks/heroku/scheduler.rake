namespace :git do




  #desc "Fetch and merge from git server, using current checked out branch"
  #task :fetch_upstream do
   # puts 'Fetching upstream'
    #sh ""
    #puts 'Fetched'
  #end




desc "Rewrite your master branch so that any commits not in upstream/master are replayed on top of the fetched branch"
  task :update_fork do
    puts 'Git rebase'
    sh "git remote add upstream https://github.com/errbit/errbit.git; git fetch upstream; git checkout master; git rebase upstream/master"
    puts 'Rebased'
  end

  desc "Shows status of all files in git repo"
  task :status do
    puts 'Showing `git status` of all source files'
    sh "git status --short"




  end
end

