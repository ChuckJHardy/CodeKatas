# Job: Accepts Job String with our without a dependency
#
# dependency? - Job has a dependency
#
# Examples
#
#   new('a => b')
#   # => <Job:0x0 @job="a", @dependency="b">
#
#   new('c')
#   # => <Job:0x1 @job="c", @dependency=nil>
#
# Returns Job Object

class Job
  def initialize(arg)
    @arg = arg
  end

  def job
    split_string[0]
  end

  def dependency
    split_string[1]
  end

  def dependency?
    !dependency.nil?
  end

  private

  def split_string
    @str ||= clear_white_space.split('=>')
  end

  def clear_white_space
    @arg.gsub(' ', '')
  end
end
