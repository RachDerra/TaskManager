class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.all.order(dead_line: :desc).page(params[:page])
    elsif params[:sort_priority]
      @tasks = current_user.tasks.all.order(priority: :asc).page(params[:page])
    else
      @tasks = current_user.tasks.all.order(created_at: :desc).page(params[:page])
    end

    if params[:name].present? && params[:number].present?
      @tasks = current_user.tasks.search_name(params[:name]).search_status(params[:number]).page(params[:page])
    elsif params[:name].present?
      @tasks = current_user.tasks.search_name(params[:name]).page(params[:page])
    elsif params[:number].present?
      @tasks = current_user.tasks.search_status(params[:number]).page(params[:page])
    end

  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def confirm
    render :new if @task.invalid?
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :retail, :dead_line, :priority, :status)
    end
end
