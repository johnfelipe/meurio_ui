# coding: utf-8

module MeurioUi
  module ViewHelpers
    def meurio_header_for app
      @app = app
      render file: 'meurio_ui/meurio_header'
    end

    def application_name app
      return "Nossas Cidades"      if app == :minhascidades
      return "Panela de Pressão"   if app == :pdp
      return "Imagine"             if app == :imagine
      return "Faça Acontecer"      if app == :apoie
      return "De Olho"             if app == :deolho
      return "De Guarda"           if app == :deguarda
      return "Multitude"           if app == :multitude
      return "Compartilhaço"       if app == :compartilhaco
      return "Legislando"          if app == :legislando
    end

    def meurio_ui_assets
      return nil if request.protocol == 'https://'
      content_tag :link, nil, rel: "stylesheet", href: "http://i.icomoon.io/public/b6dafa29d0/MeuRio/style.css"
    end

    def sign_in_path
      if [:pdp, :multitude, :minhascidades, :compartilhaco, :legislando].include? @app
        "http://192.168.1.5:3001/?service=#{request.url}"
      else
        "http://accounts.#{ENV["MEURIO_DOMAIN"]}/?redirect_url=#{request.url}"
      end
    end

    def sign_out_path
      if [:pdp, :multitude, :minhascidades, :compartilhaco, :legislando].include? @app
        "http://192.168.1.5:3001/logout?service=#{request.url}"
      else
        "http://accounts.#{ENV["MEURIO_DOMAIN"]}/logout?redirect_url=#{request.url}"
      end
    end

    def edit_profile_path
      if [:pdp, :multitude, :minhascidades, :compartilhaco, :legislando].include? @app
        "http://192.168.1.5:3001/users/#{current_user.id}/edit"
      else
        "http://accounts.#{ENV["MEURIO_DOMAIN"]}/users/#{current_user.id}/edit"
      end
    end
  end
end
