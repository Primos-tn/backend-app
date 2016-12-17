class Web::MediaController < Web::BaseController

  def index
    CarrierWave.configure do |config|
      path = File.join(config.root, params[:path])
      puts path
      puts path
      puts path
      puts path
      puts File.symlink?(path)
      #path = '/home/hassenfath/www/b24/2/brand/1/small_thumb_prod2700724_E34061391_F.jpeg'
      if File.exists?(path) ||  File.symlink?(path)
        send_file(path,
                  :disposition => 'inline',
                  :type => 'image/jpeg',
                  :x_sendfile => true)
      end
    end
  end
end

