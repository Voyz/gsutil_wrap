# gsutil_wrap
gsutil_wrap is a Docker image used to isolate the [Google Cloud's gsutil][gsutil] standalone tool from the [google/cloud-sdk][cloud-image] image.

Its primary use is to provide gsutil functionality in a lightweight fashion, for instance in the [Container Optimised OS][cos]. 


## <a name="usage"></a>Usage

gsutil_wrap is available as public Docker image called:

```posh
voyz/gsutil_wrap
```

As such, it can be used as follows:

```posh
docker run -v /host/path:/container/path --entrypoint gsutil voyz/gsutil_wrap cp gs://bucket/path /container/path
```

This can be used in the [startup-script][startup-script] of your GCP instance to download data from your [Storage bucket][storage] upon instance boot. This is particularly useful when using [Container Optimised OS][cos].

## Key concepts

#### Authentication

Designed to work on a GCP Compute Engine instance, gsutil_wrap will attempt to use the default service account credentials available on the instance it is run from to authenticate with the GCP Storage.

#### How does it work?

When run as intended (see [Usage](#usage)), Docker will mount a volume binding a host directory to a container directory running the gsutil_wrap image. Then gsutil is used to download files to into that mounted volume, which will now become available in the host directory too.

Credit to [Guillaume Blaquiere][so-answer] for outlining this method of downloading files using a Docker image.

#### Motivation

Based on suggestions from [this StackOverflow question][so], I attempted to find a solution that wouldn't require large [google/cloud-sdk][cloud-image] image (2.41GB at the time of writing this) being used to fetch small files from the Google Cloud Storage. 

gsutil_wrap image weighs 220MB decompressed and takes only a few seconds to pull.

## License
See [LICENSE](LICENSE)

[gsutil]: https://cloud.google.com/storage/docs/gsutil
[cloud-image]: https://hub.docker.com/r/google/cloud-sdk/
[cos]: https://cloud.google.com/container-optimized-os
[storage]: https://cloud.google.com/storage/docs
[startup-script]: https://cloud.google.com/compute/docs/startupscript
[so]: https://stackoverflow.com/questions/64555078/copy-files-to-container-optimised-os-from-a-gcp-storage-bucket
[so-answer]: https://stackoverflow.com/a/64562200/3508719