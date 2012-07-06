class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json
  def index
    if current_user
      @comments = Comment.all
    else
      redirect_to new_user_session_path and return
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end
  
  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.get(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end
  
  # GET /comments/new
  # GET /comments/new.json
  def new
    if current_user
      @comment = Comment.new	
    else	
      redirect_to new_user_session_path and return
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end
  
  # GET /comments/1/edit
  def edit
    if current_user
      @comment = Comment.get(params[:id])
    else
      redirect_to new_user_session_path and return
    end
  end
  
  # POST /comments
  # POST /comments.json
  def create
    if current_user
      @comment = Comment.new(params[:comment])
    else 
      redirect_to new_user_session_path and return
    end 
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
          format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /comments/1
  # PUT /comments/1.json
  def update
    if current_user
      @comment = Comment.get(params[:id])
    else 
      redirect_to new_user_session_path and return
    end
    
    respond_to do |format|
      if @comment.update(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    if current_user
      @comment = Comment.get(params[:id])
      @comment.destroy
    else
      redirect_to new_user_session_path and return
    end
    
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
end
