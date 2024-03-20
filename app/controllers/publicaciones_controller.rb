class PublicacionesController < ApplicationController
    skip_before_action :protect_pages, only: [:index, :show]

    def index
      @categories=Category.all
      @publicaciones = Publicacion.all.with_attached_imagen.order(created_at: :desc)
      @pagy, @publicaciones = pagy_countless(@publicaciones, items: 10)

      #como pueo agregar load asynkkc a eso
      if params[:category_id].present? 
        @publicaciones = Publicacion.all.with_attached_imagen.order(created_at: :desc)
        #@publicaciones = @publicaciones.joins(user: :faculty)
        @publicaciones=@publicaciones.where(category_id: params[:category_id])  
      

      end

      if params[:faculty_id].present?
        @publicaciones = Publicacion.all.with_attached_imagen.order(created_at: :desc)
        @publicaciones = @publicaciones.joins(:user).where(users: { faculty_id: params[:faculty_id] })
      end




      
      if params[:query].present?
        @publicaciones = Publicacion.all.with_attached_imagen.order(created_at: :desc)
        @publicaciones = @publicaciones.search(params[:query])
      end
    end
    
    def show
     @publicacion= Publicacion.find(params[:id])
     @comments = @publicacion.comments.order(created_at: :desc)
     @respuestas=Response.all
    end
    
    def new
      @publicacion = Publicacion.new
    end
    
    def create
        @publicacion = Publicacion.new(publicacion_params)
        if @publicacion.save
          redirect_to publicaciones_path, notice: 'se subio tu publicacion'
        else
          render :new, status: :unprocessable_entity
        end
    end

    def edit
      autorizar! publicacion
      publicacion 
    end

    def update
      autorizar! publicacion
      if publicacion.update(publicacion_params)
        redirect_to publicaciones_path, notice: 'Tu publicaaacion se ha actualizado correctamente.'
      else 
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      autorizar! publicacion
      publicacion.destroy
      redirect_to publicaciones_path, notice: 'La publicación se ha eliminado correctamente.', status: :see_other

    end
    
    
      
    def publicacion
      @publicacion= Publicacion.find(params[:id])
    end
    
    private
    
    def publicacion_params
      params.require(:publicacion).permit(:titulo, :descripcion, :imagen, :category_id)
    end
  end
    