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

            # just a reminder for myself:
            # fyi the :kittens is just the instance variable used in the controller action,
            # so :kittens because you used #index and it uses the @kittens instance var
            # and consequently, :kitten would be it instead if you used #show (as it uses @kitten not @kittens)
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
        context "valid params" do
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

        context "invalid params" do
            it "making kitten with bad cutness param" do
                p "about to #create"
                post :create, params:{
                    kitten:{
                        name: "noodles",
                        age: "4",
                        cuteness: "nine out of 10",
                        softness: "10/10"
                    }
                }
                p response.status
                expect(response).to_not have_http_status(:success) # successes are in the 200 range
                #expect(response).to have_http_status(:success) # this does in fact cause the test to fail, AS I DESIRED. good check
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end
    describe "edit+update tests" do
        it "modify existing kitten data" do
            #premade item
            kitten = Kitten.create(name: "hotodg", age: "2", cuteness: "8/10", softness: "7.5/10")

            #access item
            #ps the spots where that's a 1 should normally be something like: `kitten.id`
            #get :edit, params: {id: 1}
            puts "inside edit+update tests"
            #retrived_data = response.body
            #puts retrived_data
            new_name = "hotcat"
            #change item
            patch :update, params: {id: 1, kitten: {name: new_name}}

            #puts kitten.name
            expect(response).to redirect_to(kitten_path(kitten))

            #puts response
            hotcat = Kitten.find(1)
            #puts hotcat.name
            expect(hotcat.name).to eq(new_name)
        end
    end

    describe "delete entry" do
        it "deleting a kitten in db" do
            victim = Kitten.create(name: "gible", age: "1", cuteness: "5/10", softness: "6.5/10")

            get :index
            puts response.body

            expect(Kitten.where(name: "gible")).to exist

            delete :destroy, params: {id: 1}
            puts response.body

            expect(Kitten.where(name: "gible")).to_not exist
        end

        #broken test
        xit "trying to delete an item that doesnt exist" do
            victim = Kitten.create(name: "gible", age: "1", cuteness: "5/10", softness: "6.5/10")

            get :index

            delete :destroy, params: {id: 1}

            expect(Kitten.where(name: "gible")).to_not exist

            expect{ delete :destroy, params: {id: 1}}.to have_http_status(:not_found)
        end
    end
end