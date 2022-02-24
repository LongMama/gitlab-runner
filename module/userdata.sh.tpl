#!/bin/bash

yum install -y git
curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/rpm/gitlab-runner_amd64.rpm"
rpm -i gitlab-runner_amd64.rpm

cat <<EOF> /home/${user}/.ssh/id_rsa.pem
${key}
EOF

ip=`curl http://169.254.169.254/latest/meta-data/public-ipv4`

gitlab-runner register \
  --non-interactive \
  --url ${url} \
  --registration-token ${token} \
  --executor "ssh" \
  --description "ssh-runner" \
  --tag-list ${tags} \
  --ssh-host $ip \
  --ssh-port "22" \
  --ssh-user ${user} \
  --ssh-identity-file "/home/${user}/.ssh/id_rsa.pem" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"

gitlab-runner install -u gitlab-runner
gitlab-runner start
