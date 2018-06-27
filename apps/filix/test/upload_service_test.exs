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

  test "happy path" do
    {ok, upload_service} = UploadService.start_link({%{file_params: @test_file}})
    assert UploadService.getstate(upload_service) == :storage_resources_prepared

    upload_service |> UploadService.update_upload_progress(upload_service)
  end


end
