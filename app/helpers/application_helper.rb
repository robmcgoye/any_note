module ApplicationHelper

  def current_account
    if user_signed_in?
      current_user.account
    end
  end

  def current_account_manager?(account)
    user_signed_in? && current_user.manager? && current_user.account.id == account.id  
  end

  def back_to_cabinet_path(cabinet_id)    
    # cookie_name = "story_#{story_id}"
    # if !cookies[cookie_name].nil?
    #   part = Part.where(id: cookies[cookie_name]).take
    #   if (part.present? && part.chapter.story_id == story_id) && (admin_user? || (part.published && part.publish_at <= Date.today))
    #     last_viewed_part = true
    #     return part_path(part)
    #   end
    # end
    # cookie value not working... load first part of this story
    cabinet = Cabinet.find(cabinet_id)
    cabinet.folders.each do |folder|
      if folder.present?
          note = folder.notes.first
        if note.present?
          return note_path(note)
        end
      end
    end
    # no valid note for this cabinet 
    # if defined?(first_folder) && first_folder.present?
      new_cabinet_note_path(cabinet)
    # else
    #   new_cabinet_folder_path(cabinet)
    # end
  end   

end
