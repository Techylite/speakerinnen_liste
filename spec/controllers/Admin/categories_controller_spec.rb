describe Admin::CategoriesController, type: :controller do
  let!(:admin) { Profile.create!(FactoryGirl.attributes_for(:admin,{email: 'FactoryGirl@test.de'})) }
  let!(:non_admin) { Profile.create!(FactoryGirl.attributes_for(:published, {email: "ral@mail.com"})) }
  let!(:category_params) { FactoryGirl.attributes_for(:category) }
  
  describe 'GET new' do   
    context "when a new category is added" do
      before(:each) do
        sign_in admin
        get :new
        
      end
      specify{ expect(response.status).to eq 200 }
      specify{ expect(response).to render_template(:new) }
    
  describe "when search param is not provided" do
    before { get :new }


    it "should return success" do
      expect(response.status).to eq 200
    end

    it "should redirect to the categories page" do 
      expect(response).to render_template(:new)
    end

    
  end
  end
end

 describe 'GET Index' do
  context "when admin is signed in" do
    before(:each) do
      sign_in admin
      get :index, { search: "Education" }
      @category = Category.create!{ FactoryGirl.attributes_for(:category) }

    describe "when search param is provided" do
    end
  
    it "should return success" do
      expect(response.status).to eq 200
    end

    it "should redirect to the categories page" do 
      expect(response).to render_template(:index)
    end

    it "should contain queried results" do
        expect(assigns(:categories)).to_not include(@category)
    end
 
  describe "when search param is not provided" do
      before { get :id => @category}
    end

    it "should return success" do
      expect(response.status).to eq 200
    end

    it "should redirect to the categories  page" do 
      expect(response).to render_template(:index)
    end

    it "should contain all results" do
      expect(assigns(:categories)).to include(@category)
      expect(assigns(:categories)).to include(@category)
    end

   end
  end
end

  describe 'POST create' do
     before(:each) do
       sign_in admin
       @category = FactoryGirl.create(:category) 
     end

     context "When creating a category" do
       it "create a new category" do
         expect {
           post :create, { :category => category_params}
         }.to change(Category,:count).by(1)
       end

       it "should redirect to admin categories page" do 
         post :create, { :category => category_params}
         expect(response).to redirect_to ('/#{I18n.locale}/admin/categories')
         expect(response.status).to eq 302
       end
    end
  end

  describe 'PUT update' do
    context "when admin is signed in" do
      before(:each) do
        sign_in admin
        @category = Category.create(FactoryGirl.attributes_for(:category))
      end
  

      describe "when valid params are supplied" do
        before { put :update, { id:@category.id, :category => { name: "Education" } } }
  
        it "should return a 302 status response" do
          expect(response.status).to eq 302
        end

        it "should update the requested Category" do
          expect(response).to redirect_to ('/#{I18n.locale}/admin/categories')
        end
      end

      describe "when valid params are not supplied" do
        before { put :update,{ id:@category.id, :category => { name: " " } } }
 
        it "should return a 200 status response" do
          expect(response.status).to eq 200
        end

        it "should not update the requested Category" do
          @category.reload
          expect(response).to render_template(:edit)

        end
      end
    end

    context "when user is not admin" do
      before(:each) do
        sign_in non_admin
        @category = Category.create(FactoryGirl.attributes_for(:category))
        put :update, {:id => @category, :category => { name: "Education" } }
      end

      specify{ expect(response.status).to eq 302 }
      specify{ expect(response).to redirect_to('/#{I18n.locale}/profiles') }
    end
  end 
 
  describe 'DELETE destroy' do
    context "When admin is signed_in" do
      before(:each) do
        sign_in admin
        @category = Category.create(FactoryGirl.attributes_for(:category))
      end

      it "should destroy requested profile" do
       expect {
           post :create, { :category => category_params}
         }.to change(Category,:count).by(1)
      end

      it "should not find the destroyed category" do
        delete :destroy, {:id => @category}
        expect {Category.find (@category)}.to raise_exception(ActiveRecord::RecordNotFound)
      end

      it "should return 302 response status" do
        delete :destroy, {:id => @category }
        expect(response.status).to eq 302
      end      
    end

    context "When non_admin is signed_in" do
      before(:each) do
        sign_in non_admin
        @category = Category.create(FactoryGirl.attributes_for(:category))
        delete :destroy, {:id => @category.id }
      end
      specify{ expect(response.status).to eq 302 }
      it "should not destroy the requested Category" do
        expect(Category.where(:id => @category).count).to eq 1
      end
    end
  end

end

#WP


  