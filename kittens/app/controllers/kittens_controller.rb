class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    render json: @kittens
  end

=begin
-- this section was temporarily lifted from index.html.erb  
<ul>
  <% @kittens.each do |kitten| %>
    <li>
      <%= kitten.name %>
      <%= kitten.age %>
      <%= kitten.cuteness %>
      <%= kitten.softness %>
    </li>
  <% end %>
</ul>
=end

  def show
    @kitten = Kitten.find(params[:id])
    render json: @kitten
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      redirect_to @kitten, :status => 201
    else
      #@kittens = Kitten.all #redundant since you are already redirecting to index which does this again.
      
      #strongly expect this is why my route's prefix for #create is `kittens` instead of `kitten`
      redirect_to action: 'index', :status => :unprocessable_entity
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
    #render json: @kitten
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      redirect_to @kitten
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])

    if @kitten.destroy
      redirect_to kittens_path, status: :see_other
    #else
      #redirect_to root_path, status: :see_other
    end
  end

  private
  def kitten_params
    # honestly because i have validation for most of these attributes they might need
    # to be handled by something aside from .permit()
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end

end
