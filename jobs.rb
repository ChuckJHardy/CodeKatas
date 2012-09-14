# Jobs: Accepts String of Jobs
#
# collect - Array of sequenced Jobs
# sequence - String of sequenced Jobs
#
# Examples
#
#   new('a, b => c')
#   # => <Jobs:0x0 @arg="a, b => c">
#
# Returns String of Ordered Jobs
class Jobs
  def initialize(arg)
    @arg = arg
  end

  def sequence
    collect.join
  end

  def collect
    job_collection.inject([]) do |acc, j|
      index = acc.index(j.job)
      if j.dependency?
        if index
          acc.insert(index, j.dependency)
        else
          acc << j.dependency
          acc << j.job
        end
      else
        acc << j.job unless index
      end

      acc
    end
  end

  private

  def job_collection
    JobCollection.new(@arg).jobs
  end
end

# JobCollection: Accepts String of Jobs
#
# jobs - Array of Job Objects
#
# Examples
#
#   new('a, b => c')
#   # => <JobCollection:0x0 @arg="a, b => c">
#
# Returns Array of Job Objects
class JobCollection
  def initialize(arg)
    @arg = arg
  end

  def jobs
    split_string.inject([]) { |acc, str| acc << Job.new(str) }
  end

  private

  def split_string
    @arg.split(',')
  end
end

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
  class SelfDependentError < StandardError
    def initialize(msg = "Jobs can't depend on themselves.")
      super(msg)
    end
  end

  def initialize(arg)
    @arg = arg
    validate
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

  def self_dependent?
    job == dependency
  end

  private

  def validate
    raise SelfDependentError if self_dependent?
  end

  def split_string
    @str ||= clear_white_space.split('=>')
  end

  def clear_white_space
    @arg.gsub(' ', '')
  end
end
