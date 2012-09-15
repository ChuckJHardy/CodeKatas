# JobError: Custom Error Class
#
# Examples
#
#   raise SelfDependencyError
#   # => JobError::SelfDependencyError
#          Jobs can't depend on themselves.
#
#   raise CircularDependencyError
#   # => JobError::CircularDependencyError
#          Jobs can't have circular dependencies.
#
# Raises JobError
module Error
  class SelfDependencyError < StandardError
    def initialize(msg = "Jobs can't depend on themselves.")
      super(msg)
    end
  end

  class CircularDependencyError < StandardError
    def initialize(msg = "Jobs can't have circular dependencies.")
      super(msg)
    end
  end
end

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
      @acc, @j = acc, j

       if j.dependency?
          if job_exists?
            validate
            acc.insert(job_position, dependency)
          else
            acc << dependency unless dependency_exists?
            acc << job
          end
       else
         acc << job unless job_exists?
       end

       acc
    end
  end

  private

  def job_collection
    JobCollection.new(@arg).jobs
  end

  def job
    @j.job
  end

  def dependency
    @j.dependency
  end

  def job_position
    @acc.index(job)
  end

  def dependency_position
    @acc.index(dependency)
  end

  def job_exists?
    job_position
  end

  def dependency_exists?
    dependency_position
  end

  def circular?
    if dpos = dependency_position
      dpos > job_position
    end
  end

  def validate
    raise Error::CircularDependencyError if circular?
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
    raise Error::SelfDependencyError if self_dependent?
  end

  def split_string
    @str ||= clear_white_space.split('=>')
  end

  def clear_white_space
    @arg.gsub(' ', '')
  end
end
