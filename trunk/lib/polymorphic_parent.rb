module PolymorphicParent
  #
  # DRYing up for polymorphic controller (like commentable controller)
  # It produces some useful helper methods like these:
  # def parent_object
  #   case
  #     when params[:note_id] then Note.find_by_id(params[:note_id])
  #     when params[:photo_id] then Photo.find_by_id(params[:photo_id])
  #     when params[:page_id] then Page.find_by_id(params[:page_id])
  #   end    
  # end  
  # 
  # def parent_url(parent)
  #   case
  #     when params[:note_id] then note_url(parent)
  #     when params[:photo_id] then photo_url(parent)
  #     when params[:page_id] then page_url(parent)
  #   end    
  # end  

  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    attr_reader :parents
    protected
    def parent_resources(*parents)
      @parents = parents
      send :include, InstanceMethods
    end
  end
  
  module InstanceMethods
    protected

    def parent_id(parent)
      request.path_parameters["#{ parent }_id"]
    end

    def parent_type
      self.class.parents.detect { |parent| parent_id(parent) }
    end

    def parent_class
      parent_type && parent_type.to_s.classify.constantize
    end

    def parent_object
      parent_class && parent_class.find_by_id(parent_id(parent_type))
    end
  end

end