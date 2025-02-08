class Admin::ContactsController < ApplicationController
  def index
    @contacts = Contact.order(created_at: :desc)
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      flash[:notice] = "Contact status updated successfully."
    else
      flash[:alert] = "Failed to update contact status."
    end
    redirect_to admin_contact_path(@contact)
  end

  private

  def contact_params
    params.require(:contact).permit(:status)
  end
end
