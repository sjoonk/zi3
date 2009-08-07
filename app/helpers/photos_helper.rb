module PhotosHelper
  def photo_thumbnail(photo)
    if photo
      image_tag photo.public_filename(:thumb), :title => photo.title
    else
      image_tag 'photo_thumb_70.png'
    end
  end
  
  def lightbox(photo)
    #<a href="#{photo.public_filename}" class="lightbox" title="#{photo.title || '제목 없음'}">
    #<img src="#{photo.public_filename(:thumb)}" width="100" height="100" alt=""/></a>
  end  
  
  def attachment_hint(attachment)
    size = attachment.attachment_options[:size] if attachment.attachment_options[:size]
    content_type = attachment.attachment_options[:content_type] if attachment.attachment_options[:content_type]
    ret = "(" if size || content_type
    ret += "파일크기: #{size} " if size
    ret += "확장자: #{content_type}" if content_type
    ret += ")" if size || content_type
  end
end
