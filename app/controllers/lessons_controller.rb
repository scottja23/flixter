class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_in_course

  def show

  end

  private

  def require_enrollment_in_course
    course = current_lesson.section.course
    enrolled = current_user.enrolled_in?(course)
    if enrolled == false
      redirect_to course_path(course), alert: 'Enroll In Course To Access Lessons'
    end
  end

  helper_method :current_lesson

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
