Rails.application.routes.draw do
  resources(:users, path: '', param: :username,
            only: [:show, :edit, :update]) do
    resources :posts, except: [:edit, :update] do
      resources(:versions, path: 'v', param: :permalink,
                except: [:index, :edit, :update])
    end
  end
end
