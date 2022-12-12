class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @rental = Rental.find(params[:rental_id])
  end

  def create
    @rental = Rental.find(params[:rental_id])
    @user = current_user
    @review = Review.new(review_params)
    @gear = @rental.gear
    @review.rental = @rental
    @review.user_id = @user.id
    if @review.save
      redirect_to gear_path(@gear), notice: "Successfully created review", status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to user_rentals_path(@user), notice: "Successfully edited review", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to gears_path(@user), notice: "Review was successfully destroyed."
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_user
    @user = current_user
  end

end
