module NoteHelper
  def print_note(n)
    unless n.nil?
    %{<li class="clearfix">
        <h2>#{ n.author.name }</h2>
        <div class="time">hace #{ time_ago_in_words(n.created_at) }</div>
        <p>#{ n.text }</p>
        #{ if current_user_admin?
        link_to [n.milestone, n],
                    method: :delete,
                    data: { confirm: t('notes.delete.sure')},
                    class: 'delete' do
            '<span class="glyphicon glyphicon-remove"></span>'.html_safe
             end
         end
         if n.visibility=='every_body'
            '<span class="glyphicon glyphicon-eye-open"></span>'.html_safe
        else if n.visibility=='mentors'
            '<span class="glyphicon glyphicon-eye-close"></span>'.html_safe
        else
            '<span class="glyphicon glyphicon-lock"></span>'.html_safe
        end
          end }
      </li>}.html_safe
    end
  end
end