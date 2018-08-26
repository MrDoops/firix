defmodule Filix.Uploading.UploadRules do
  alias Filix.File

  def check_status(:request_upload, %File{status: :requested} = file) do
    %File{ file |
      status: :requested,
    }
  end

end
