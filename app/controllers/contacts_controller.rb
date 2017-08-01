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
    if current_user
      @contacts = current_user.contacts
      if params[:input_group_name]
        @contacts = Group.find_by(name: params[:input_group_name]).contacts.where(user_id: current_user.id)
      end
      render "index.html.erb"
    else
      flash[:warning] = "You must be logged in to see your contacts!"
      redirect_to "/login"
    end

  end

  def show
    @contact = Contact.find_by(id: params[:id])
    render "show.html.erb"
  end

  def new
    @contact = Contact.new
    render "new.html.erb"
  end

  def create
    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone: params[:phone],
      bio: params[:bio],
      user_id: current_user.id
    )
    if @contact.save
      flash[:success] = "Contact created."
      redirect_to "/contacts/#{@contact.id}"
    else
      render "new.html.erb"
    end
  end

  def edit
    @contact = Contact.find_by(id: params[:id])
    render "edit.html.erb"
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    if @contact.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], phone: params[:phone])
      flash[:success] = "Contact updated."
      redirect_to "/contacts/#{@contact.id}"
    else
      render "edit.html.erb"
    end
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    flash[:success] = "Contact deleted."
    redirect_to "/"
  end
end
