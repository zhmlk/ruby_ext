# Ruby class extras

### On RoR:
Add desired extention file to any folder.

Require the file when rails is initializing.

Exaple. This code loads all extras in `lib/ruby_ext/` folder:

    Dir[File.join(Rails.root, "lib", "ruby_ext", "*.rb")].each { |l| require l }
