### OnTheBeach Developer Test

#### Installation
    git clone git@github.com:ChuckJHardy/OTBDevTest.git ~/tmp/OTBDevTest
    gem install rspec
    rspec

#### Usage
    irb
    require '~/tmp/OTBDevTest/jobs'
      # => true
      
    Jobs.new('a => b, c => d, e, c').sequence
      # => "badce"
      
    Jobs.new('a => b, c => d, e, c').collect
      # => ["b", "a", "d", "c", "e"]