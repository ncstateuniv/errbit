namespace :deploy do
 
  desc 'Deploys a branch to production. Use DEPLOY_BRANCH to specify which branch to deploy.'
  task :production do
    Rake::Task["git:status"]
    Rake::Task["git:update_fork"]
    Rake::Task["deploy:environment"].invoke("production")
    puts 'In production task.'
  end
 
  task :environment, :env do |t, args|
    deploy_branch(ENV["DEPLOY_BRANCH"], args.env)
    Rake::Task["heroku:migrate"].invoke("errbit-expertiza2019")
    Rake::Task["heroku:restart"].invoke("errbit-expertiza2019")
  end
 
  def deploy_branch(branch, environment)
    if branch
      puts 'In deploy_branch.'
      sh "git push #{environment} #{branch}:master"
    else
      puts "Please, specify a branch to deploy."
      exit 1
    end
  end
 
end
