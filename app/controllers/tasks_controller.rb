class TasksController < ApplicationController
  
  # before_actionメソッドを利用してset_taskメソッドを各アクション実行前に呼び出し
  before_action :set_task, only: %i[show edit update destroy]

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  # scope :recent, -> { order(created_at: :desc) }
  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if params[:back].present?
      render :new
      return
    end

    if @task.save
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to task_url, notice: "タスク「#{@task.name}」を更新しました"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}を削除しました。」"
  end

  def done_change
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true)
    @task = current_user.tasks.find(params[:task_id])
    if @task.done?
      @task.update(done: false)
    else
      @task.update(done: true)
    end
    render json: @tasks
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :note, :deadline)
  end

  # idパラメータからタスクオブジェクトを検索して@taskに代入する
  def set_task
    @task = current_user.tasks.find(params[:id])
  end


end
