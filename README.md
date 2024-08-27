## Tagging and Pushing Image

Below instruction explains how to create the image tne push to the container registry.

### Build the Image

```
docker build --tag test-python-app:1.0 . 
```

### Login to repo with docker
[Instruction](https://cloud.google.com/artifact-registry/docs/docker/pushing-and-pulling) 

```
gcloud auth print-access-token \
--impersonate-service-account  ACCOUNT | docker login \
-u oauth2accesstoken \
--password-stdin https://LOCATION-docker.pkg.dev
```
- Example:

``` 
cat key.json | docker login -u _json_key_base64 --password-stdin \
https://us-west1-docker.pkg.dev 
```

### Tag and push code to artifact repository
[Instruction](https://cloud.google.com/artifact-registry/docs/docker/pushing-and-pulling) 


 ```docker tag SOURCE-IMAGE LOCATION-docker.pkg.dev/PROJECT-ID/REPOSITORY/IMAGE:TAG```

- Example: 
```docker tag test-python-app:1.0 europe-west9-docker.pkg.dev/project-name/take-home-repo/test-python-app:1.0```

#### Push code
```docker push tagged_docker_image:1.0```

## Deploying kubernete file

- Create kubernetes cluser using from console or provided kubernetes terraform script
- Execute command to configure kubectl client
    ```
        gcloud container clusters get-credentials cluster-name \
        --zone us-central1-c --project project-name 
    ```

- Execute command to apply deployment.yaml to cluster
    - ```
        kubectl apply -f deployment.yaml
    ```
