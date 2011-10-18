ssh_user    = "ubuntu@50.16.230.36"
remote_root = "/srv/static/tiberiasconstructioninc.com"
ssh_key     = `echo ~/.ec2/gsg-keypair.pem`.delete("\n")
dropbox_dir = ""

desc "Runs preview"
task :preview do
  puts "** starting preview server"
  system "staticmatic preview ."
end

desc "Build the site"
task :build => ["styles:clear"] do
  puts "** building site"
  system "staticmatic build ."
end

desc "Clear and generate new styles, build, and deploy"
task :deploy => :build do
  puts "** deploying site"
  system("rsync -avz --rsh \"ssh -i #{ssh_key}\" --delete site/ #{ssh_user}:#{remote_root}")
end

namespace :dropbox do
  desc "Sync images from dropbox to src"
  task :images do
    if dropbox_dir.empty?
      puts "** skipping dropbox image sync: dropbox_dir is not defined"
    else
      if not File.directory?(d = File.join(dropbox_dir, 'images'))
        puts "** skipping dropbox image sync: '#{d}' is not a directory"
      else
        puts "** synching images from dropbox"
        system("rsync -avz --delete #{d} site")
      end
    end
  end

  desc "Sync favicon from dropbox to src"
  task :favicon do
    if dropbox_dir.empty?
      puts "** skipping dropbox favicon sync: dropbox_dir is not defined"
    else
      if not File.exists?(f = File.join(dropbox_dir, 'favicon.ico'))
        puts "** skipping favicon sync: '#{f}' does note exist"
      else
        puts "** synching favicon from dropbox"
        system("cp #{f} site/")
      end
    end
  end

  desc "Sync required files from dropbox"
  task :sync => [:images, :favicon]
end

namespace :javascripts do
  desc "Clear javascripts"
  task :clear do
    puts "** clearing compressed javascripts"
    system "rm -Rfv site/javascripts/*"
  end

  desc "Generate javascripts"
  task :generate => :clear do
    puts "** compressing javascripts"
    system "jammit -c config/assets.yml -o site/javascripts -f"
  end
end

namespace :styles do
  desc "Clear styles"
  task :clear do
    puts "** clearing generated styles"
    system "rm -Rfv site/stylesheets/*"
  end

  desc "Regenerate styles"
  task :generate => :clear do
    puts "** generating styles" 
    system "compass compile -c config/compass.rb"
  end
end
