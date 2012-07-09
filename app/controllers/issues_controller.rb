class IssuesController < ApplicationController
  
  load_and_authorize_resource

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @issue = Issue.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.json
  def new
    if current_user
      @issue = Issue.new
    else
      redirect_to new_user_session_path and return
    end
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/1/edit
  def edit
    if current_user
      @issue = Issue.get(params[:id])
    else
      redirect_to new_user_session_path and return
    end
  end

  # POST /issues
  # POST /issues.json
  def create
    if current_user
      @issue = Issue.new(params[:issue])
    else
      redirect_to new_user_session_path and return
    end 
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
    if current_user
      @issue = Issue.get(params[:id])
    else
      redirect_to new_user_session_path and return
    end
    respond_to do |format|
      if @issue.update(params[:issue])
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
    if current_user
      @issue = Issue.get(params[:id])
      @issue.destroy
    else
      redirect_to new_user_session_path and return
    end
    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end
end
