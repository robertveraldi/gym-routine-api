class RoutinesController < ApplicationController
  def create
    routine = Routine.new!(
      user_id: params[:user_id],
      exercise_id: params[:exercise_id],
      reps: params[:reps]
    )

    if routine.save
      render json: {message: "Exercise added to routine."}
    else
      render json: {error: routine.error.full_messages}
  end
end
