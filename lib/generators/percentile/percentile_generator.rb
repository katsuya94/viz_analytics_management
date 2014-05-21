class PercentileGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_percentile_file
  	template "percentile.rb", "app/models/definitions/#{class_name.underscore}_percentile.rb"
  end
end
