dcf_cloud='docker-cloud.yml'
dcf_test='docker-compose.test.yml'
dco='docker compose'

alias docker.down.dev="doppler.run.dev -- $dco down"
alias docker.down.test="doppler.run.test -- $dco -f $dcf_test down"
alias docker.down.prod="doppler.run.prod -- $dco -f $dcf_cloud down"
alias docker.down.stg="doppler.run.stg -- $dco -f $dcf_cloud down"
alias docker.restart.dev="docker.down.dev && docker.up.dev"
alias docker.restart.prod="docker.down.prod && docker.up.prod"
alias docker.restart.stg="docker.down.stg && docker.up.stg"
alias docker.restart.test="docker.down.test && docker.up.test"
alias docker.up.dev="doppler.run.dev -- $dco up --build"
alias docker.up.prod="doppler.run.prod -- $dco -f $dcf_cloud up"
alias docker.up.stg="doppler.run.stg -- $dco -f $dcf_cloud up"
alias docker.up.test="doppler.run.test -- $dco -f $dcf_test up --build"
