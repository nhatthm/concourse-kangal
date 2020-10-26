# Kangal Resource for Concourse

Run [Kangal](https://github.com/hellofresh/kangal) with [Concourse](https://github.com/concourse/concourse)

## Source Configuration

* `proxy_host`: *Optional.* The hostname of kangal proxy.
* `phase`: *Optional.* Phase to be filtered while checking resource.
* `tags`: *Optional.* List of tags in `yaml` format.

For example
```yaml
resources:
- name: my-load-tests
  type: kangal
  icon: nuke
  source:
    proxy_host: kangal-proxy.tld
    tags:
      team: platform
      department: tech
      plan: user-registration
```

## Behavior

### `check`: Check for load tests

Return list of load tests from http://kangal-proxy.tld/load-test API and filter by `source.phase` and `source.tags`.

### `in`: Get load test

Return the chosen load test data from http://kangal-proxy.tld/load-test/{load-test-name} API.

### `out`: Run a new load test

#### Parameters

* `plan`: The path to load test file.
* `data`: The path to load test data.
* `pods`: Number of distributed pods for the load test.
* `overwrite`: Overwrite the load test if exists. Possible values: `true` or `false`
* `type`: Load test type.

Those parameters will be used to create load test with this API call.

The load test will be tagged with `tags` in `source` configuration plus current timestamp in nanoseconds (in order to sort the versions).

```shell
curl -X POST http://${KANGAL_PROXY_ADDRESS}/load-test \
  -H 'Content-Type: multipart/form-data' \
  -F distributedPods=${pods} \
  -F testFile=@${plan} \
  -F testData=@${data} \
  -F tags=${tags} \
  -F type=${type} \
  -F overwrite=${overwrite}
```

## Usage

Example:

```yaml
resource_types:
- name: kangal
  type: docker-image
  source:
    repository: nhatthm/concourse-kangal
    tag: latest

resources:
- name: my-load-tests
  type: kangal
  icon: nuke
  source:
    tags:
      team: platform
      department: tech
      plan: user-registration

groups:
- name: load-tests
  jobs:
  - my-load-tests

jobs:
- name: my-load-tests
  public: false
  serial: true
  plan:
    # Prepare testplan.jmx and testdata.csv
    #
    # For example:
    #   Output of these tasks is load-tests/testplan.jmx and load-tests/testdata.csv
    #
    # - in_parallel:
    #   - get: source-code
    #     attempts: ((default_attempts))
    #     timeout: ((default_timeout))
    #     resource: master-source-code
    #
    #   - get: every-4am
    #     timeout: ((default_timeout))
    #     trigger: true
    #
    # - task: prepare
    #   timeout: ((default_timeout))
    #   file: source-code/ci/tasks/prepare-load-tests.yml
    #   params:
    #     ENV: live
    #     LOAD_TEST_FILE: testplan.template.jmx

    - put: run
      resource: my-load-tests
      params:
        plan: load-tests/testplan.jmx
        data: load-tests/testdata.csv
        pods: "9"
```
