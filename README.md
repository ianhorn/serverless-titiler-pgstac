# serverless-titiler-pgstac

This repo is a mashup of the [titiler-pgstac](https://github.com/stac-utils/titiler-pgstac) and the [titiler-lambda-layer](https://github.com/developmentseed/titiler-lambda-layer) repos.  The intention is to deploy an instance of titiler-pgstac as a lambda function similar to the methods Development Seed uses in its [AWS Serverless Application (SAM)](https://developmentseed.org/titiler/deployment/aws/sam/)

### Get started
To get started with this repo, clone the repository and create a Python environment.

```bash
# clone the repo
git clone https://github.com/ianhorn/serverless-titiler-pgstac.git
cd serverless-titiler-pgstac

# Create a python environment
python -m venv venv
python -m pip install -r requirements_local.txt

# activate environment
source venv/bin/activte
```

## Create lambda layer
I tried building a *docker-compose.yml* file that would build the lambda layer and store it locally.  But this build script will work too.

```bash
./build.sh
```

You should now have a package.zip file.  Deploy that to AWS as a Lambda Layer

```bash
# deploy lambda layer
./titiler-pgstac-lambda-layer/scripts/deploy.py
```
Optional - list your layers

```bash
# run list script
./list.py | jq
```

You should get a response like this.

```bash
[
  {
    "region": "us-west-2",
    "layers": [
      {
        "name": "titiler-pgstac",
        "arn": "arn:aws:lambda:<region}:<account>:layer:titiler-pgstac:<version>",
        "version": <version>
      }
    ]
  }
]
```

# Launch Serveless Application (SAM)

In the same region you created the Lambda layer, use the AWS Console to navigate to [CloudFormation](https://us-west-2.console.aws.amazon.com/cloudformation/).  

1. Create a stack - with new resources
2. Specify the template  
     - provide a url to a template saved in a bucket or upload the [sam.yml](sam.yml) file.  
3. Give your stack a name
4. Update the parameters for your pgstac instance*
5. Add any tags or other optional items
6. Check the acknowledgement boxes
7. Review the stack and hit submit.  

\*Be sure to update any other variable settings.  You'll need to enable stac and mosaic if you want to use those, obviously.

<!-- 
## SAM application

<p><a href="https://console.aws.amazon.com/lambda/home?#/create/app?applicationId=arn:aws:serverlessrepo:us-east-1:552819999234:applications/TiTiler" rel="noreferrer"><img src="https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg" alt="Launch Stack"></a></p>

Link: https://serverlessrepo.aws.amazon.com/applications/us-east-1/552819999234/TiTiler

> **Note**
> You can change the `TiTiler` version by changing the Lambda Layer version `LayerVersion` parameter before deploying.

see: [SAM Application template](/sam.yml) -->
