class LinksController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: %i[follow password_form verify_password]
  before_action :set_link, only: %i[show edit update destroy ]
  before_action :set_link_by_slug, only: %i[follow]
  before_action :authorize_user, only: [:follow]

  rescue_from ActiveRecord::RecordNotFound, with: :link_not_found

  def index
    @links = current_user.links
  end

  def show
  end

  def new
    @link = current_user.links.build
    @link.url = params[:url] if params[:url].present?
  end

  def create
    @link = current_user.links.build(link_params)

    if link_params_valid?
      if @link.save
        redirect_to @link, notice: 'Link was successfully created.'
      else
        render :new
      end
    else
      flash.now[:alert] = 'Please fill in all fields.'
      render :new
    end
  end

  def edit
  end

  def update
    if link_params_valid?
      if @link.update(link_params)
        redirect_to @link, notice: 'Link was successfully updated.'
      else
        render :edit
      end
    else
      flash.now[:alert] = 'Please fill in all fields.'
      render :edit
    end
  end

  def destroy
    @link.destroy
    
    redirect_to links_path, alert: 'Link was successfully destroyed.'
  end

  def follow
    # Acción para registrar el acceso y redirijir a la url original
    @link.accesses.create(ip_address: request.remote_ip)
    redirect_to @link.url, allow_other_host: true
  end
  
  def password_form
    # Acción para mostrar el formulario de contraseña
    @link = Link.find(params[:id])
  end

  def verify_password
    # Acción para verificar la contraseña ingresada
    @link = Link.find(params[:id])

    if params[:password] == @link.password
      @link.accesses.create(ip_address: request.remote_ip)
      redirect_to @link.url, allow_other_host: true
    else
      flash.now[:alert] = 'Incorrect password.'
      render 'password_form', layout: false
    end
  end

  private

  def set_link
    @link = current_user.links.find(params[:id])
  end

  def set_link_by_slug
    @link = current_user.links.find_by(slug: params[:slug])
  end

  def link_not_found
    flash[:alert] = 'Link not found'
    redirect_to links_path
  end

  def link_params
    params.require(:link).permit(:name, :url, :link_type, :expires_at, :password)
  end

  def link_params_valid?
    required_fields = %i[name url link_type]
    required_fields.all? { |field| params[:link][field].present? }
  end

  def authorize_user
    case @link.link_type
    when 'Private'
      authorize_private_link
    when 'Ephemeral'
      authorize_ephemeral_link
    when 'Temporary'
      authorize_temporal_link
    else
      true
    end
  end

  def authorize_private_link
    if @link.password.present? && params[:password] == @link.password
      true
    else
      render 'password_form', layout: false
      false
    end
  end
  
  def authorize_ephemeral_link
    if @link.accesses.present?
      render file: "#{Rails.root}/public/403.html", layout: false, status: :forbidden
      false
    else
      true
    end
  end

  def authorize_temporal_link
    if @link.expires_at && @link.expires_at >= Time.now
      true
    else
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
      false
    end
  end

end
