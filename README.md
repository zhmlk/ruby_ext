# Ruby Class Extensions

This `Ruby` class extensions adds several powerful utility methods to enhance the functionality of Ruby's core classes.

---

## Installation & Setup (on Rails)
To use these extensions within a Ruby on Rails application:

1. **Add the extension file** to the desired folder (e.g., `lib/ruby_ext/`).
2. **Require the file** during Rails initialization. 

Example: Load all custom extensions from the `lib/ruby_ext/` folder.

```ruby
Dir[File.join(Rails.root, "lib", "ruby_ext", "*.rb")].each { |l| require l }
