#!/bin/bash
set -eu

# Decrypt a private SSH key having its public key registered on GitHub. It will
# be used to establish an identity with rights to push to the git repository
# hosting our Helm charts: https://github.com/kubism/charts
openssl aes-256-cbc -K $encrypted_189e52c2c347_key -iv $encrypted_189e52c2c347_iv -in deploy_key.enc -out deploy_key -d
chmod 0400 ci/deploy_key

docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"

# Activate logging of bash commands now that the sensitive stuff is done
set -x

# As chartpress uses git to push to our Helm chart repository, we configure
# git ahead of time to use the identity we decrypted earlier.
export GIT_SSH_COMMAND="ssh -i ${PWD}/ci/deploy_key"

if [ "${TRAVIS_TAG:-}" == "" ]; then
    # Using --long, we are ensured to get a build suffix, which ensures we don't
    # build the same tag twice.
    chartpress --push --publish-chart --long
else
    # Setting a tag explicitly enforces a rebuild if this tag had already been
    # built and we wanted to override it.
    chartpress --push --publish-chart --tag "${TRAVIS_TAG}"
fi

# Let us log the changes chartpress did, it should include replacements for
# fields in values.yaml, such as what tag for various images we are using.
git --no-pager diff