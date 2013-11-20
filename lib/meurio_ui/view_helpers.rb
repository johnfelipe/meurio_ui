# coding: utf-8

module MeurioUi
  module ViewHelpers
    def meurio_header_for app
      content_tag(:header, class: :meurio_header) do
        meurio_brand_and_user_panel + application_menu
      end
    end

    def meurio_brand_and_user_panel
      content_tag(:div, class: :meurio_logo_and_user_menu) do
        content_tag(:div, class: :row) do
          content_tag(:div, class: :meurio_logo) do
            link_to image_tag('meurio.png'), 'http://meurio.org.br/'
          end +
          content_tag(:div, class: :user_menu) do
            if current_user.present?
              content_tag(:div, class: :current_user) do
                image_tag(current_user.avatar_url) + current_user.name + content_tag(:span, nil, class: 'icon-triangle-down')
              end +
              content_tag(:div, class: :current_user_links) do
                link_to('Minhas campanhas', user_campaigns_path(current_user)) +
                if can?(:moderate, Campaign)
                    link_to('Moderar campanhas', unmoderated_campaigns_path)
                end +
                if can?(:export, User)
                  link_to("Exportar todos os usuários", users_path(:format => :csv))
                end
              end
            else
              link_to 'Entrar', "http://accounts.meurio.org.br/?redirect_url=#{request.url}", class: :hollow_btn
            end
          end +
          content_tag(:div, nil, class: :clear)
        end
      end
    end

    def application_menu
      content_tag(:div, class: :meurio_apps_and_application_menu) do
        content_tag(:div, class: :row) do
          content_tag(:div, class: :meurio_apps) do
            content_tag(:div, class: :current_app) do
              link_to(root_path) do
                image_tag("#{app}.png") + content_tag(:span, application_name(app))
              end +
              content_tag(:span, nil, class: 'icon-arrow-box')
            end +
            content_tag(:div, class: :other_apps) do
              link_to('http://meurio.org.br/', class: :meurio_app) do
                image_tag("#{app}.png") + content_tag(:span, application_name(app))
              end +
              link_to('http://paneladepressao.meurio.org.br/', class: :meurio_app) do
                image_tag("#{app}.png") + content_tag(:span, application_name(app))
              end +
              link_to('http://imagine.meurio.org.br/', class: :meurio_app) do
                image_tag("#{app}.png") + content_tag(:span, application_name(app))
              end +
              link_to('https://apoie.meurio.org.br/', class: :meurio_app) do
                image_tag("#{app}.png") + content_tag(:span, application_name(app))
              end +
              link_to('http://deolho.meurio.org.br/', class: :meurio_app) do
                image_tag("#{app}.png") + content_tag(:span, application_name(app))
              end +
              link_to('http://deguarda.meurio.org.br/', class: :meurio_app) do
                image_tag("#{app}.png") + content_tag(:span, application_name(app))
              end
            end
          end +
          content_tag(:div, yield(:application_menu), class: :application_menu) + content_tag(:div, nil, class: :clear)
        end
      end
    end
  end

  def application_name app
    return "Ação em Rede"       if app == :mr
    return "Panela de Pressão"  if app == :pdp
    return "Imagine"            if app == :imagine
    return "Faça Acontecer"     if app == :apoie
    return "De Olho"            if app == :deolho
    return "De Guarda"          if app == :deguarda
  end
end
