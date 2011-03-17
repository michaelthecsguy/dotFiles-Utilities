module GitSvnSync
  def self.verbose_execute(cmd, return_output=false, options={})
    puts "Executing #{cmd}:" if $VERBOSE

    retval="" if return_output
    IO.popen("#{cmd} 2>&1") do |f|
      f.each_line do |line|
        puts line if $VERBOSE
        retval << line if return_output
      end
    end

    puts "...done\nExit status: #{$?.to_i}" if $VERBOSE

    raise StandardError.new("Error executing #{cmd}") unless $? == 0 || options[:on_error] == :do_nothing

    retval
  end
end
