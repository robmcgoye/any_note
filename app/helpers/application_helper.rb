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
    cookie_name = "#{current_user.account.id}_cabinet_#{cabinet_id}"
    if !cookies[cookie_name].nil?
      note = Note.where(id: cookies[cookie_name]).take
      if note.present? && note.folder.cabinet_id == cabinet_id 
        return note_path(note)
      end
    end
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
    new_cabinet_note_path(cabinet)
  end   

end
