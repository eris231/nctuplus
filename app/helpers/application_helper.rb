module ApplicationHelper
	
	def loading_img
		html='<br><p class="text-center">'<<image_tag(asset_path("loading.gif"), size: '42x42')<<'</p>'
		html.html_safe
	end
	
	def loadingImg
		html="<h4 class='text-center'>"<<fa_icon("refresh spin 2x")<<"<h4>"
		html.html_safe
	end
	
  def div_alert
		'<div class="alert alert-danger">'
  end
  def div_notice
    '<div class="alert alert-notice">'
  end

end
