defmodule Filix do
  @moduledoc """
  Module responsible for the core behavior/api/services of the application.

  Consumed by FilixWeb in varying capacities.

  Uses FilixPersistence for long term storage and querying.

  Currently uses ExAws.S3 for object storage, however the goal is to make the interface generic enough to use any static object storage service.
  Maybe even decentralized blockchain solutions.
  """

  # Use the pre_signed_url as the identifier of active processes
end
