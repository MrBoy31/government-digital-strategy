# makes a "deploy" folder which contains ALL the things we need

require "shell/executer.rb"
require "fileutils"
require_relative "./utils.rb"
require "formatador"
require "paint"

# remove deploy folder
Shell.execute("rm -r deploy")


# copy built folder to form the basis of our deploy folder
FileUtils.cp_r("built", "deploy")

# get rid of the assets symlink
Shell.execute("rm deploy/assets")

# make assets folder
Utils.make_if_not_exists("deploy/assets")

#### CSS ####
Utils.make_if_not_exists("deploy/assets/css")
Dir.glob("assets/css/*.min.css").each do |file|
  FileUtils.cp(file, "deploy/#{file}")
end

#### JS #####
Utils.make_if_not_exists("deploy/assets/javascripts")
FileUtils.cp("assets/javascripts/built.js", "deploy/assets/javascripts/built.js")
FileUtils.cp("assets/javascripts/require.js", "deploy/assets/javascripts/require.js")

#### DATA ####
FileUtils.cp_r("assets/data", "deploy/assets/data")

#### IMGS ####
FileUtils.cp_r("assets/images", "deploy/assets/images")

#### PDFS ####
Dir.glob("built/**/*.pdf").each do |pdf|
  file_path = pdf.split "/"
  file_path.shift
  file_path = file_path.join "/"
  FileUtils.cp(pdf, "deploy/#{file_path}")
end

#### DOCS WE DONT NEED ####
FileUtils.rm_r("deploy/digital/assisted")
FileUtils.rm_r("deploy/sample-document")
FileUtils.rm("deploy/actions.html")
FileUtils.rm("deploy/departments.html")

