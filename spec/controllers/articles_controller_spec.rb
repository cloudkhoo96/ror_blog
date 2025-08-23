require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  before do
    # Include Devise test helpers for controller tests
    sign_in user
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "assigns @articles" do
      article = create(:article)
      get :index
      expect(assigns(:articles)).to eq([article])
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: article.id }
      expect(response).to have_http_status(:ok)
    end

    it "should not found" do
      get :show, params: { id: 1000 }
      expect(response).to have_http_status(:not_found)
    end

    it "assigns the requested article to @article" do
      get :show, params: { id: article.id }
      expect(assigns(:article)).to eq(article)
    end
  end

  describe "GET #new" do
    context "when user is not authenticated" do
      before { sign_out user }

      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated" do
      it "returns a successful response" do
        get :new
        expect(response).to have_http_status(:ok)
      end

      it "assigns a new article to @article" do
        get :new
        expect(assigns(:article)).to be_a_new(Article)
      end
    end
  end

  describe "POST #create" do
    context "when user is authenticated" do
      before { sign_in user }

      context "with valid parameters" do
        it "creates a new article" do
          expect {
            post :create, params: { article: attributes_for(:article) }
          }.to change(Article, :count).by(1)
        end

        it "redirects to the created article" do
          post :create, params: { article: attributes_for(:article) }
          expect(response).to redirect_to(article_path(Article.last))
        end
      end

      context "with invalid parameters" do
        it "does not create a new article" do
          expect {
            post :create, params: { article: attributes_for(:article, title: nil) }
          }.not_to change(Article, :count)
        end

        it "re-renders the new template with unprocessable_entity status" do
          post :create, params: { article: attributes_for(:article, title: nil) }
          expect(response).to render_template(:new)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "when user is not authenticated" do
      before { sign_out user }

      context "with valid parameters" do
        it "redirects to login page" do
          post :create, params: { article: attributes_for(:article) }
          expect(response).to redirect_to(new_user_session_path)
        end

        it "does not create article" do
          expect { post :create, params: { article: attributes_for(:article) }}.not_to change { Article.count }
        end
      end
    end
  end

  describe "GET #edit" do
    context "when user is authenticated" do
      before { sign_in user }

      it "returns a successful response" do
        get :edit, params: { id: article.id }
        expect(response).to have_http_status(:ok)
      end

      it "assigns the requested article to @article" do
        get :edit, params: { id: article.id }
        expect(assigns(:article)).to eq(article)
      end
    end

    context "when user is not authenticated" do
      before { sign_out user }

      it "redirects to login page" do
        get :edit, params: { id: article.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated and tries to edit an article not belonging to user" do
      before { sign_in create( :user ) }
      
      it "redirect to root path" do
        get :edit, params: { id: article.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH #update" do
    context "when user is authenticated" do
      before { sign_in user }

      context "with valid parameters" do
        it "updates the requested article" do
          patch :update, params: { id: article.id, article: { title: "Updated Title" } }
          article.reload
          expect(article.title).to eq("Updated Title")
        end

        it "redirects to the updated article" do
          patch :update, params: { id: article.id, article: { title: "Updated Title" } }
          expect(response).to redirect_to(article_path(article))
        end
      end

      context "with invalid parameters" do
        it "does not update the article" do
          patch :update, params: { id: article.id, article: { title: nil } }
          expect(article.reload.title).not_to be_nil
        end

        it "re-renders the edit template with unprocessable_entity status" do
          patch :update, params: { id: article.id, article: { title: nil } }
          expect(response).to render_template(:edit)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "when user is not authenticated" do
      before { sign_out user }

      it "redirects to login page" do
        patch :update, params: { id: article.id, article: { title: "Updated Title" } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated and tries to update an article not belonging to user" do
      before { sign_in create( :user ) }
      
      it "redirect to root path" do
        patch :update, params: { id: article.id, article: { title: "Updated Title" } }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when user is authenticated" do
      before { sign_in user }

      it "destroys the requested article" do
        article
        expect {
          delete :destroy, params: { id: article.id }
        }.to change(Article, :count).by(-1)
      end

      it "redirects to the root path with see_other status" do
        delete :destroy, params: { id: article.id }
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(:see_other)
      end
    end
  end

  context "when user is not authenticated" do
    before { sign_out user }

    it "redirects to login page" do
      delete :destroy, params: { id: article.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when user is authenticated and tries to delete an article not belonging to user" do
    before { sign_in create( :user ) }
    
    it "redirect to root path" do
      delete :destroy, params: { id: article.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
