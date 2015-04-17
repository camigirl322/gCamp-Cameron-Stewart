namespace :cleanup  do
  desc 'clears all invalid data'

  task clean_memberships: :environment  do
    desc 'Removes all memberships where their users or their projects have already been deleted'
    Membership.all.each do |membership|
        if membership.user_id.nil? or membership.project_id.nil?
          puts "Destroying membership: #{membership.id}"
          membership.destroy
        else
          puts "No memberships to destroy!"
      end
    end
  end

  task clean_tasks: :environment do
    desc "Removes all tasks where their projects have been deleted"
      Task.all.each do |task|
        if task.project_id.nil?
          puts "Destroying task: #{task.id}"
          task.destroy
        else
          puts "No tasks to destroy!"
        end
      end
    end

    task clean_comments: :environment do
      desc "Removes all comments where their tasks have been deleted and Sets the user_id of comments to nil if their users have been deleted"
      Comment.all.each do |comment|
        if comment.task_id.nil?
          puts "Destroying comment: #{comment.id}"
        else
          puts "No comment to destroy!"
        end
        if comment.user_id.nil?
          comment.user_id = nil
        end
      end
    end

    task :default => [:clean_memberships, :clean_tasks] do
    end

end
