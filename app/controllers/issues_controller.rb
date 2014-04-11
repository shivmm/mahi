class IssuesController < ApplicationController
  
  load_and_authorize_resource

  # GET /issues
  # GET /issues.json
  def index
    #debugger
    @issues = Issue.all(:order => [:comment_count.desc, :id.desc])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
#    debugger
    @issue = Issue.get(params[:id])
    @comment = Comment.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.json
  def new
    @issue = Issue.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue }
    end
  end
  
  # GET /issues/1/edit
  def edit
    @issue = Issue.get(params[:id])
  end
  
  # POST /issues
  # POST /issues.json
  def create
    params[:issue][:user_id] = current_user.id
    @issue = Issue.new(params[:issue])
    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render json: @issue, status: :created, location: @issue }
      else 
        format.html { render action: "new" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /issues/1
  # PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue = Issue.get(params[:id])
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully deleted' }
      format.json { head :no_content }
    end
  end
end
