def full_title(page_title)
  base_title = "Insta Clone"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in_as(user)
  post user_login_path, params: { session: { email: user.email,
                              password: user.password } }
end
