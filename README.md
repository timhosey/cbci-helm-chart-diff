# cbci-helm-chart-diff
Display diffs between two Helm charts for CloudBees CI.

## Usage
To use this, runs `diffs.sh` and provide your current Helm chart version. It will then pull the latest, pull the specified version, and compare the two.

Can be adapted to specify both versions if you'd like, but latest seemed most logical at initial authoring.