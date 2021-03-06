class PlansController < ApplicationController

  before_filter :authenticate_user! , only: [:new, :create]

  @@amt = 0

  def index
  	@plans = Plan.all
  end

  def new
    # raise params.inspect
  	@amount = params[:amount]
    @@amt = @amount
    @issue_id = params[:issue_id]
    @@issue_id = @issue_id
  end

  def create
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      customer.sources.create(source: params[:stripeToken])
      @am = @@amt
      @issue_iid = @@issue_id
      # byebug
      @issue = Issue.find(@issue_iid)
      @issue.payment = true
      @issue.save!
        Stripe::Charge.create(
            :customer =>  customer.id,
            :amount   =>  @@amt,
            :description  => "Charges By User",
            :currency => 'usd'
           )

        rescue Stripe::CardError  => e
          flash[:error] = e.message
          redirect_to root_path
  end
end
