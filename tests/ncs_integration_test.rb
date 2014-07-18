require 'C:\ruby\NCS\ncs'

ncs = NationalCrimeSearch.new('youruser@email.com',
                              'your_user_token', true)
puts '=> Testing valid_token'
t = ncs.send_request(:valid_token, email: ncs.username)
puts t

puts '=> Testing generate_token'
t = ncs.send_request(:generate_token,
                     email: 'efficientforms@nationalcrimesearch.com',
                     token: ncs.token)
puts t

puts '=> Testing fake endpoint'
t = ncs.send_request(:fake_endpoint,
                     email: 'efficientforms@nationalcrimesearch.com',
                     token: ncs.token)
puts t
