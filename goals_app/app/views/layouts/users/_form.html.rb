<%= form_tag(users_path) do %>
    <div>
      <%= label_tag :username %>
      <%= text_field_tag :username %>
    </div>
  
    <div>
      <%= label_tag :password %>
      <%= password_field_tag :password %>
    </div>
  
    <%= submit_tag "Create User" %>
<% end %>