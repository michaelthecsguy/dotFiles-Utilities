require 'git_svn_sync'

module GitSvnSync
  module Git
    class << self
      def verify_treeish(treeish)
        GitSvnSync.verbose_execute "git rev-parse --verify --quiet #{treeish}", false, :on_error => :do_nothing
        raise StandardError.new("Invalid git reference #{treeish}") unless $? == 0
      end

      def export_project(git_tree, dir)
        print "Exporting git project at #{git_tree}..."
        GitSvnSync.verbose_execute("git archive #{git_tree} | (cd #{dir}; tar xf -)")
        puts "done"
      end

      def construct_commit_message(treeish)
        tag = GitSvnSync.verbose_execute("git describe --tags #{treeish}", true, :on_error => :do_nothing).chomp

        if $? != 0
          commit = GitSvnSync.verbose_execute("git describe --always #{treeish}", true).chomp

          branch = GitSvnSync.verbose_execute("git name-rev --name-only #{treeish}", true).chomp
          branch.sub!(/~.*/, '')

          remote = GitSvnSync.verbose_execute("git config --get branch.#{branch}.remote", true, :on_error => :do_nothing).chomp
          if remote.empty?
            if branch == "remotes/#{treeish}"
              branch = treeish
              local = " remote branch"
              if treeish =~ %r{^([^/]+)/}
                remote_ref = " from #{url_for_remote $1}"
              end
            else
              local = " local branch"
            end
          else
            from = url_for_remote(remote)
            merge = GitSvnSync.verbose_execute("git config --get branch.#{branch}.merge", true).chomp

            remote_ref=" from #{from}(#{merge})"
          end

          "Imported git snapshot from #{commit} on#{local} #{branch}#{remote_ref}"
        else
          "Imported git snapshot from tag #{tag}"
        end
      end

      def url_for_remote(remote)
        GitSvnSync.verbose_execute("git config --get remote.#{remote}.url", true).chomp
      end
    end
  end
end
