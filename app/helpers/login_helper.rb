module LoginHelper

    def vaidate_access_token
        access_token = params[:access_token]
        AccessToken.validate(access_token)
    end
end
