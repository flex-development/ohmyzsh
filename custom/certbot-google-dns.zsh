#!/bin/zsh

# Certbot x Google Domains
#
# References:
#
# - https://brew.sh
# - https://certbot-dns-google.readthedocs.io/en/stable
# - https://certbot.eff.org/instructions?ws=nginx&os=osx
# - https://cloud.google.com/sdk/gcloud/reference/iam/service-accounts
# - https://itsmetommy.com/2019/08/03/auto-renew-lets-encrypt-wildcard-certificate-using-google-cloud-dns

certbot_google_dns() {
  # 1. Install certbot (letsencrypt)
  [[ -z $(type -p certbot) ]] && brew install certbot

  # 2. Install python (and pip3)
  [[ -z $(type -p python) ]] && brew install python

  # 3. Install certbot-dns-google plugin
  if [[ $(pip3 list certbot-dns-google | fgrep certbot-dns-google) == "" ]]; then
    pip3 install certbot-dns-google
  fi

  # Service account user
  local USER=certbot

  # 4. Create file to store credentials
  gcloud iam service-accounts create $USER --project $PROJECT_ID --format json

  # Service account email
  local SA=$USER@$PROJECT_ID.iam.gserviceaccount.com

  # 5. Assign dns admin permissions
  gcloud projects add-iam-policy-binding $PROJECT_ID --role=roles/dns.admin --member=serviceAccount:$SA

  # File to store private key
  local PK=~/.secrets/certbot/google/$DOMAIN.json

  # 6. Create private key for service account
  gcloud iam service-accounts keys create $PK --iam-account=$SA

  # 7. Create certificate(s)
  certbot certonly --dns-google --dns-google-credentials $PK -d *.$DOMAIN $@
}
