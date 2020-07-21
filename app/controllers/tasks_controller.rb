class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    if logged_in?
      # binding.pry
    @tasks = current_user.tasks.all.order(created_at: "DESC").page(params[:page]).per(5)
    # @tasks = Task.all.order(params[:sort])
    #終了期限でのソート
    if params[:sort_expired]
      @tasks = current_user.tasks.all.order(end_at: "DESC").page(params[:page]).per(5)
    end
    #優先順位でソート
    if params[:sort_priority]
      @tasks = current_user.tasks.all.order(priority: "DESC").page(params[:page]).per(5)
    end
    #NAMEおよび進捗状況で検索
    if params[:search].present?
      if params[:name].present? && params[:completed].present? && params[:label_id].present?
        @tasks = current_user.tasks.where("name LIKE ?", "%#{ params[:name] }%").page(params[:page]).per(5)
        @tasks = @tasks.where(completed: params[:completed]).page(params[:page]).per(5)
        @labelling = Labelling.where(label_id: params[:label_id]).pluck(:task_id)
        @tasks = @tasks.where(id: @labelling)
      elsif params[:name].present? && params[:completed].present?
        @tasks = current_user.tasks.where("name LIKE ?", "%#{ params[:name] }%").page(params[:page]).per(5)
        @tasks = @tasks.where(completed: params[:completed]).page(params[:page]).per(5)
      elsif params[:name].present? && params[:label_id].present?
        @tasks = current_user.tasks.where("name LIKE ?", "%#{ params[:name] }%").page(params[:page]).per(5)
        @labelling = Labelling.where(label_id: params[:label_id]).pluck(:task_id)
        @tasks = @tasks.where(id: @labelling)
      elsif params[:completed].present? && params[:label_id].present?
        @tasks = @tasks.where(completed: params[:completed]).page(params[:page]).per(5)
        @labelling = Labelling.where(label_id: params[:label_id]).pluck(:task_id)
        @tasks = @tasks.where(id: @labelling)
      elsif params[:name].present?
        @tasks = current_user.tasks.where("name LIKE ?", "%#{ params[:name] }%").page(params[:page]).per(5)
      elsif params[:completed].present?
        @tasks = @tasks.where(completed: params[:completed]).page(params[:page]).per(5)
      elsif params[:label_id].present?
        @labelling = Labelling.where(label_id: params[:label_id]).pluck(:task_id)
        @tasks = @tasks.where(id: @labelling)
      end
    end
    else
      redirect_to new_session_path
      flash[:notice] = 'ログインをしてください'
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.build(task_params)
    # binding.pry
    # @task = Task.new(task_params)
    # @task.user_id = current_user.id
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :content, :end_at, :completed, :priority, label_ids: [])
    end
end
