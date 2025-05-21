class SimpleJob < ApplicationJob
  queue_as :default

  around_perform :around_perform_example
  
  def perform(*args)
    puts "GGGGGGG: SimpleJob perform Strated #{args.inspect}"
  end

  def around_perform_example
    # its exicute before the perform
    puts "GGGGGGG: around_perform_example: BEFORE"
    yield
    # its exicute after the perform
    puts "GGGGGGG: around_perform_example: AFTERE"
  end
end
