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

#### Parameters

* `report`: Set to `true` to generate `report.json` file and export the report to env vars.

#### Environment Variables

The `env` file will be generated with these variables

```bash
export LOAD_TEST_NAME=loadtest-running-orangutan
export LOAD_TEST_TYPE=JMeter
export LOAD_TEST_DISTRIBUTED_PODS=6
export LOAD_TEST_PHASE=finished
export LOAD_TEST_TAGS=plan:user-registration,team:platform,department:tech
export LOAD_TEST_TIMESTAMP=1604054807914
export LOAD_TEST_TIMESTAMP_60MIN_BEFORE=1604051207914
export LOAD_TEST_TIMESTAMP_45MIN_BEFORE=1604052107914
export LOAD_TEST_TIMESTAMP_30MIN_BEFORE=1604053007914
export LOAD_TEST_TIMESTAMP_15MIN_BEFORE=1604053907914
export LOAD_TEST_TIMESTAMP_15MIN_AFTER=1604055707914
export LOAD_TEST_TIMESTAMP_30MIN_AFTER=1604056607914
export LOAD_TEST_TIMESTAMP_45MIN_AFTER=1604057507914
export LOAD_TEST_TIMESTAMP_60MIN_AFTER=1604058407914
export LOAD_TEST_DATE_60MIN_BEFORE=2020-10-30T09:46:47Z
export LOAD_TEST_DATE_45MIN_BEFORE=2020-10-30T10:01:47Z
export LOAD_TEST_DATE_30MIN_BEFORE=2020-10-30T10:16:47Z
export LOAD_TEST_DATE_15MIN_BEFORE=2020-10-30T10:31:47Z
export LOAD_TEST_DATE_15MIN_AFTER=2020-10-30T11:01:47Z
export LOAD_TEST_DATE_30MIN_AFTER=2020-10-30T11:16:47Z
export LOAD_TEST_DATE_45MIN_AFTER=2020-10-30T11:31:47Z
export LOAD_TEST_DATE_60MIN_AFTER=2020-10-30T11:46:47Z
export LOAD_TEST_DATE_MS_60MIN_BEFORE=2020-10-30T09:46:47.000Z
export LOAD_TEST_DATE_MS_45MIN_BEFORE=2020-10-30T10:01:47.000Z
export LOAD_TEST_DATE_MS_30MIN_BEFORE=2020-10-30T10:16:47.000Z
export LOAD_TEST_DATE_MS_15MIN_BEFORE=2020-10-30T10:31:47.000Z
export LOAD_TEST_DATE_MS_15MIN_AFTER=2020-10-30T11:01:47.000Z
export LOAD_TEST_DATE_MS_30MIN_AFTER=2020-10-30T11:16:47.000Z
export LOAD_TEST_DATE_MS_45MIN_AFTER=2020-10-30T11:31:47.000Z
export LOAD_TEST_DATE_MS_60MIN_AFTER=2020-10-30T11:46:47.000Z
```

<details>
  <summary>If you set report to true, these env vars below will be added.</summary>

```bash
export LOAD_TEST_REPORT_APDEX_OVERALL_APDEX=0.5
export LOAD_TEST_REPORT_APDEX_OVERALL_TOLERATION_THRESHOLD=200
export LOAD_TEST_REPORT_APDEX_OVERALL_FRUSTRATION_THRESHOLD=500
export LOAD_TEST_REPORT_APDEX_OVERALL_LABEL=Total
export LOAD_TEST_REPORT_APDEX_ITEMS_0_APDEX=0.5
export LOAD_TEST_REPORT_APDEX_ITEMS_0_TOLERATION_THRESHOLD=200
export LOAD_TEST_REPORT_APDEX_ITEMS_0_FRUSTRATION_THRESHOLD=500
export LOAD_TEST_REPORT_APDEX_ITEMS_0_LABEL=/register
export LOAD_TEST_REPORT_STATISTICS_OVERALL_LABEL=Total
export LOAD_TEST_REPORT_STATISTICS_OVERALL_NUM_SAMPLES=160780
export LOAD_TEST_REPORT_STATISTICS_OVERALL_KO=11
export LOAD_TEST_REPORT_STATISTICS_OVERALL_ERROR_RATE=0.01
export LOAD_TEST_REPORT_STATISTICS_OVERALL_AVERAGE=2105.69
export LOAD_TEST_REPORT_STATISTICS_OVERALL_MIN=5
export LOAD_TEST_REPORT_STATISTICS_OVERALL_MAX=64165
export LOAD_TEST_REPORT_STATISTICS_OVERALL_90TH_PERCENTILE=4186.9
export LOAD_TEST_REPORT_STATISTICS_OVERALL_95TH_PERCENTILE=7783.85
export LOAD_TEST_REPORT_STATISTICS_OVERALL_99TH_PERCENTILE=12995.98
export LOAD_TEST_REPORT_STATISTICS_OVERALL_THROUGHPUT=476.55
export LOAD_TEST_REPORT_STATISTICS_OVERALL_RECEIVED=201.65
export LOAD_TEST_REPORT_STATISTICS_OVERALL_SENT=104.92
export LOAD_TEST_REPORT_STATISTICS_ITEMS_0_LABEL=/register
export LOAD_TEST_REPORT_STATISTICS_ITEMS_0_NUM_SAMPLES=160780
export LOAD_TEST_REPORT_STATISTICS_ITEMS_0_KO=11
export LOAD_TEST_REPORT_STATISTICS_ITEMS_0_ERROR_RATE=0.01
export LOAD_TEST_REPORT_STATISTICS_ITEMS_0_AVERAGE=2105.69
export LOAD_TEST_REPORT_STATISTICS_ITEMS_0_MIN=5
export LOAD_TEST_REPORT_STATISTICS_ITEMS_0_MAX=64165
export LOAD_TEST_REPORT_STATISTICS_ITEMS_0_90TH_PERCENTILE=4186.9
export LOAD_TEST_REPORT_STATISTICS_ITEMS_0_95TH_PERCENTILE=7783.85
export LOAD_TEST_REPORT_STATISTICS_ITEMS_0_99TH_PERCENTILE=12995.98
export LOAD_TEST_REPORT_STATISTICS_ITEMS_0_THROUGHPUT=476.55
export LOAD_TEST_REPORT_STATISTICS_ITEMS_0_RECEIVED=201.65
export LOAD_TEST_REPORT_STATISTICS_ITEMS_0_SENT=104.92
export LOAD_TEST_REPORT_ERRORS_ITEMS_0_ERROR_TYPE=connect timed out
export LOAD_TEST_REPORT_ERRORS_ITEMS_0_NUM_ERRORS=2
export LOAD_TEST_REPORT_ERRORS_ITEMS_0_PERCENT_IN_ERRORS=18.18
export LOAD_TEST_REPORT_ERRORS_ITEMS_0_PERCENT_IN_SAMPLES=0
export LOAD_TEST_REPORT_ERRORS_ITEMS_1_ERROR_TYPE=504/GATEWAY_TIMEOUT
export LOAD_TEST_REPORT_ERRORS_ITEMS_1_NUM_ERRORS=4
export LOAD_TEST_REPORT_ERRORS_ITEMS_1_PERCENT_IN_ERRORS=36.36
export LOAD_TEST_REPORT_ERRORS_ITEMS_1_PERCENT_IN_SAMPLES=0
export LOAD_TEST_REPORT_ERRORS_ITEMS_2_ERROR_TYPE=Non HTTP response code: java.net.SocketTimeoutException/Non HTTP response message: Read timed out
export LOAD_TEST_REPORT_ERRORS_ITEMS_2_NUM_ERRORS=5
export LOAD_TEST_REPORT_ERRORS_ITEMS_2_PERCENT_IN_ERRORS=45.45
export LOAD_TEST_REPORT_ERRORS_ITEMS_2_PERCENT_IN_SAMPLES=0
```
</details>

#### Report

<details>
  <summary>Click to view example</summary>

```json
{
  "apdex": {
    "overall": {
      "apdex": "0.5022484139818385",
      "toleration_threshold": "200",
      "frustration_threshold": "500",
      "label": "Total"
    },
    "items": [
      {
        "apdex": "0.5022484139818385",
        "toleration_threshold": "200",
        "frustration_threshold": "500",
        "label": "/register"
      }
    ]
  },
  "statistics": {
    "overall": {
      "label": "Total",
      "num_samples": "160780",
      "ko": "11",
      "error_rate": "0.006841646971016296",
      "average": "2105.686049259857",
      "min": "5",
      "max": "64165",
      "90th_percentile": "4186.9000000000015",
      "95th_percentile": "7783.850000000002",
      "99th_percentile": "12995.980000000003",
      "throughput": "476.55180181515317",
      "received": "201.64581964027423",
      "sent": "104.91854895285611"
    },
    "items": [
      {
        "label": "/register",
        "num_samples": "160780",
        "ko": "11",
        "error_rate": "0.006841646971016296",
        "average": "2105.686049259857",
        "min": "5",
        "max": "64165",
        "90th_percentile": "4186.9000000000015",
        "95th_percentile": "7783.850000000002",
        "99th_percentile": "12995.980000000003",
        "throughput": "476.55180181515317",
        "received": "201.64581964027423",
        "sent": "104.91854895285611"
      }
    ]
  },
  "errors": {
    "overall": null,
    "items": [
      {
        "error_type": "connect timed out",
        "num_errors": "2",
        "percent_in_errors": "18.181818181818183",
        "percent_in_samples": "0.0012439358129120537"
      },
      {
        "error_type": "504/GATEWAY_TIMEOUT",
        "num_errors": "4",
        "percent_in_errors": "36.36363636363637",
        "percent_in_samples": "0.0024878716258241074"
      },
      {
        "error_type": "Non HTTP response code: java.net.SocketTimeoutException/Non HTTP response message: Read timed out",
        "num_errors": "5",
        "percent_in_errors": "45.45454545454545",
        "percent_in_samples": "0.0031098395322801346"
      }
    ]
  }
}
```
</details>

### `out`: Run a new load test

#### Parameters

* `plan`: The path to load test file.
* `data`: The path to load test data.
* `pods`: Number of distributed pods for the load test.
* `overwrite`: Overwrite the load test if exists. Possible values: `true` or `false`
* `type`: Load test type.

###### Optional
* `vars`: The path to environment variables file.

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
  -F overwrite=${overwrite} \
  -F envVars=@${vars}
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
        vars: load-tests/envVars.csv
        pods: "9"
```
