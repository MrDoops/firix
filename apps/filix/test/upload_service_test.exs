defmodule UploadServiceTest do
  use ExUnit.Case
  alias Filix.Uploading.UploadService

  @test_file = %File{
    name: "mountain",
    size: 1200,
    type: "JPEG",
    url: nil,
    tags: ["pictures", "photos", "hikes"]
  }

  # TODO figure out how to mock ExAWS S3 / make a test adapter that follows setup_storage_resources for test uses.
  test "typical successful upload progression" do
    {ok, upload_service} = UploadService.start_link({%{file_params: @test_file}})
    assert UploadService.upload_status(upload_service) == {:storage_resources_prepared, %{file_params: %{name: "mountain", size: 1200, type: "JPEG", presigned_url: presigned_url}}}
    assert presigned_url != nil

    upload_service |> UploadService.update_upload_progress(upload_service, 10)
    assert UploadService.upload_status(upload_service) == {:uploading, _}

    upload_service |> UploadService.update_upload_progress(upload_service, 99)
    assert UploadService.upload_status(upload_service) == {:uploading, _}

    upload_service |> UploadService.update_upload_progress(upload_service, 100)
    assert UploadService.upload_status(upload_service) == {:complete, _}
  end


end
