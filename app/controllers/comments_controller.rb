class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    
    if @comment.save
      redirect_to Publicacion.find(params[:publicacion_id]), notice: "Comentario creado correctamente"
    else
      flash.now[:alert] = "Hubo un problema al crear el comentario"
      render "publicaciones/show"
    end
  end

  def destroy
    @publicacion = Publicacion.find(params[:publicacion_id])
    @comment = @publicacion.comments.find(params[:id])
    @comment.destroy
    redirect_to @publicacion, notice: "Comentario eliminado correctamente"
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :publicacion_id, :user_id)
  end
end
