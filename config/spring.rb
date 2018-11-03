%w(
  .ruby-version
  .rbenv-vars
  tmp/restart.txt
  tmp/caching-dev.txt
  app/policies
  app/decorator
  app/queries
).each { |path| Spring.watch(path) }
