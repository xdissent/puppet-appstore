module Puppet::Parser::Function
  newfunction(:appstore_password, :type => :rvalue) do |args|
    hiera_password = lookupvar('appstore::password')
    appstore_user = lookupvap('appstore::appleid')

    command = "security -q find-generic-password -w -a #{appstore_user} -s 'Apple App Store' /Users/#{lookupvar('::boxen_user')}/Library/Keychains/login.keychain"

    if hiera_password == :undefined || hiera_password.nil?
      begin
        Puppet::Util::Execution.execute(command).to_str
      rescue Puppet::ExecutionFailure => detail
        raise Puppet::ParseError, "Failed to lookup App Store password from keychain"
      end
    else
      hiera_password
    end
  end
end
