class RepositoryDecorator < SimpleDelegator

  def display_name
    name.gsub("-", " ").titleize
  end
end