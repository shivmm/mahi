class CommentsController < ApplicationController

   load_and_authorize_resource
  
  # GET /comments
  # GET /comments.json
  def index
    redirect_to root_url
   # @comments = Comment.all
    #respond_to do |format|
      #format.html # index.html.erb
     # format.json { render json: @comments }
   # end
  end
  
  # GET /comments/1
  # GET /comments/1.json
  def show
   
    @comment = Comment.get(params[:id])
    redirect_to @comment.issue
   # respond_to do |format|
    #  format.html # show.html.erb
     # format.json { render json: @comment }
   # end
  end
  
  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end
  
  # GET /comments/1/edit
  def edit
    @comment = Comment.get(params[:id])
  end
  
  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.issue, notice: 'Comment was successfully created.' }
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
    #    @comment = Comment.get(params[:id])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.issue, notice: 'Comment was successfully updated.' }
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
    @comment = Comment.get(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @comment.issue, notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
