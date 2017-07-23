class ContactsController < ApplicationController
  def index
    # @contacts = Contact.all

    # JUST USING RUBY
    # all_contacts = Contact.all
    # @contacts = []
    # all_contacts.each do |contact|
    #   if contact.user_id == current_user.id
    #     @contacts << contact
    #   end
    # end

    # JUST USING ACTIVE RECORD
    # @contacts = Contact.where(user_id: current_user.id)

    # JUST USING RAILS ASSOCIATIONS
    @contacts = current_user.contacts

    render "index.html.erb"
  end

  def show
    @contact = Contact.find_by(id: params[:id])
    render "show.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    @contact = Contact.create(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone: params[:phone],
      bio: params[:bio]
    )
    flash[:success] = "Contact created."
    redirect_to "/contacts/#{@contact.id}"
  end

  def edit
    @contact = Contact.find_by(id: params[:id])
    render "edit.html.erb"
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    @contact.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], phone: params[:phone])
    flash[:success] = "Contact updated."
    redirect_to "/contacts/#{@contact.id}"
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    flash[:success] = "Contact deleted."
    redirect_to "/"
  end
end
