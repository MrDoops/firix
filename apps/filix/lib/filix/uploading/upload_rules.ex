defmodule Filix.Uploading.UploadRules do
  alias Filix.File

  def check_status(%File{status: :requested} = file, :request_upload) do
    %File{ file |
      status: :requested,
    }
  end

  def check_status(%File{upload_progress: progress} = file, :update_upload_progress) do
    cond do
      (progress >= 100)                -> %File{ file | status: :complete, upload_progress: 100}
      (progress > 0 && progress < 100) -> %File{ file | status: :uploading}
    end
  end

end
