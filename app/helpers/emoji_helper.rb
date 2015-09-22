module EmojiHelper
  def emojify(content)
    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}"
               style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end.html_safe if content.present?
  end

  def top_emojis
    [':joy:', ':unamused:', ':heart_eyes:', ':relaxed:', ':ok_hand:',
     ':heart:', ':kissing_heart:', ':blush:', ':pensive:', ':weary:', ':sob:',
     ':smirk:', ':grin:', ':two_hearts:', ':flushed:', ':thumbsup:',
     ':raised_hands:', ':wink:', ':information_desk_person:', ':relieved:',
     ':see_no_evil:', ':sunglasses:', ':v:', ':pray:']
  end
end
