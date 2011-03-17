require 'spec_helper'
require 'git_svn_sync/svn'

describe GitSvnSync::Svn do
  describe :new_branch_name do
    %w[trunk branches/any_branch tags/any_tag].each do |elem|
      it %(strips "#{elem}" from the end of the path and appends branches/branch_name) do
        GitSvnSync::Svn.new_branch_name("https://subversion/argo/parity/#{elem}", "new_branch").should == "https://subversion/argo/parity/branches/new_branch"
      end
    end
  end
end
