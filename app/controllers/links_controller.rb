class LinksController < ApplicationController
  before_action :set_link, only: %i[show edit update destroy]

  def index
    @links = current_user.links
  end

  def show
    respond_to do |format|
      format.html # Esto renderizará el archivo show.html.erb por defecto
    end
  end

  def new
    @link = current_user.links.build
  end

  def create
    @link = current_user.links.build(link_params)
    if @link.save
      respond_to do |format|
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('link_form', partial: 'form', locals: { link: @link }) }
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    @link = Link.find(params[:id])
  
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("link_form", partial: "form", locals: { link: @link })
        end
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @link.destroy
  
    respond_to do |format|
      format.html { redirect_to @links, notice: 'Link was successfully destroyed.' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@link) }
    end
  end
  
  private

  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:name, :url, :link_type, :expires_at, :password)
  end
end
