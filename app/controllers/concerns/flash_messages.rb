module FlashMessages
  extend ActiveSupport::Concern

  def nounify(obj)
    case obj
    when String, Symbol
      obj.to_s.titleize
    else
      obj.class.to_s.titleize
    end
  end

  def flash_success(obj)
    noun = nounify obj
    flash[:success] =
      case params[:action]
      when 'create'
        "New #{noun.downcase} successfully created"
      when 'update'
        "#{noun} successfully updated"
      when 'destroy'
        "#{noun} successfully deleted"
      else
        "#{params[:action].titleize} successfully performed on #{noun.downcase}"
      end
  end

  def flash_error(obj)
    noun = nounify obj
    flash[:error] =
      case params[:action]
      when 'create'
        "There was a problem creating the #{noun.downcase}"
      when 'update'
        "There was a problem updating the #{noun.downcase}"
      when 'destroy'
        "There was a problem deleting the #{noun.downcase}"
      else
        "There was a problem performing #{params[:action].titleize.downcase} "\
        "on the #{noun.downcase}"
      end
  end
end