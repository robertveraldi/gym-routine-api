class RoutinesController < ApplicationController
before_action: authenticate_user, except: [:index]

  def create #need to make it save to current_user.routines
    if current_user
      routine = Routine.create!(
        # user_id: params[:user_id],
        user_id: current_user.id,
        exercise_id: params[:exercise_id],
        reps: params[:reps],
      )

      if routine.save
        render json: { message: "Exercise added to routine." }
      else
        render json: { error: routine.error.full_messages }
      end
    end
  end

  def update
    routine = Routine.find_by(id: params[:id])
    routine.reps = params[:reps] || routine.reps
    routine.save

    render json: { message: "Routine successfully updated." }
  end

  def destroy 
    routine = Routine.find_by(id: params[:id])
    routine.destroy
    render json: { message: "This part of your routine has successfully been removed." }
  end

  def show #do i need this?
    routine = Routine.find_by(id: params[:id])
    render json: routine
  end

  def index #only show current users routines
    if current_user
      routine = Routine.all.order(:id)
      # Routine.find_by(user_id: current_user.id).all
      render json: routine
    end
  end
end
