define :s3_repo do
  template "/etc/yum.repos.d/#{params[:name]}" do
    source "s3_repo.repo.erb"
    owner "root"
    group "root"
    cookbook 'yum-s3-plugin'
    variables({
      :name => params[:name],
      :base_url => params[:bucket_url],
      :access_key_id => params[:access_key],
      :secret_access_key => params[:secret_key]
    })
  end
end
