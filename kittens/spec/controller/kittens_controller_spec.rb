require 'rails_helper'
require 'spec_helper' # debug gem requirement is in here
# to run with debug with `debugger` acting as the chokepoints, type in `bundle exec rspec`

RSpec.describe KittensController, type: :controller do
    # GET index interactions
    describe "GET #index" do
        it "returns a success response" do
            get :index
            # remember response is a baked in variable that holds whatever http status
            # the system is responding to the user with.
            expect(response).to have_http_status(:success)
        end

        it "are kittens assigned as @kittens? (instance variables for use across the current request)" do
            kitten1 = Kitten.create(name: "pickles", age: "6", cuteness: "9/10", softness: "10/10")
            kitten2 = Kitten.create(name: "rex", age: "3", cuteness: "10/10", softness: "8.5/10")

            get :index

            expect(assigns(:kittens)).to eq([kitten1, kitten2])
        end
    end

    describe "POST #create" do
        context "w/ valid params" do
            it "#create a new kitten using controller" do
                #debugger
                expect{
                    post :create, params: {
                        kitten: {
                            name:"muffin",
                            age:"1",
                            cuteness:"9.5/10",
                            softness:"10/10"
                        }
                    }
                }.to change(Kitten, :count).by(1)
            end

            it "return created http response" do
                post :create, params: {
                    kitten: {
                        name:"muffin",
                        age:"1",
                        cuteness:"9.5/10",
                        softness:"10/10"
                }}
                expect(response).to have_http_status(:created)
            end
        end
    end

    describe "POST then GET data" do
        it "#create then retrieve index" do
            #one `post :create` per kitten
            post :create, params: {
                kitten: {
                    name:"butterball",
                    age:"4",
                    cuteness:"7.5/10",
                    softness:"9.5/10"
                }
            }
            post :create, params: {
                kitten: {
                    name:"legolas",
                    age:"3000",
                    cuteness:"8.5/10",
                    softness:"6.5/10"
                }
            }
            #get :show, params: {id: 2}
            get :index
            p response.body
            expect(response.body).to include("legolas")
            
            get :show, params: {id: 1}
            p response.body
            expect(response.body).to include("7.5/10")
        end
    end
end