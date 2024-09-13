class SaveimageController < ApplicationController

    def save_image
        require "aws-sdk-s3"
        bucket_name = "ai-images-promptlab"
        object_key = "object"
        file_path = "testimage.png"

        @object= Aws::S3::Object.new(bucket_name, object_key)
        File.open(file_path, "rb") do |file|
            @object.put(body: file)
          end


    end

end