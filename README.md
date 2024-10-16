# Ruby Class Extensions

This collection of Ruby class extensions enhances the functionality of core Ruby classes, including `String` and others, with additional utility methods. These extensions provide useful features such as string manipulation, validation, encryption, hashing, and type conversions.

---

## Installation & Setup (on Rails)
To use these extensions within a Ruby on Rails application:

1. **Add the extension file** to the desired folder (e.g., `lib/ruby_ext/`).
2. **Require the file** during Rails initialization. 

Example: Load all custom extensions from the `lib/ruby_ext/` folder.

```ruby
Dir[File.join(Rails.root, "lib", "ruby_ext", "*.rb")].each { |l| require l }
