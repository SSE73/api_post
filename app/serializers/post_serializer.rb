class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :human_created_at

  def human_created_at
    object.created_at.strftime("%d/%m/%Y")
  end

end