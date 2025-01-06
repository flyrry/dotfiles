function git_pull_install
  if test -e yarn.lock
    git pull && yarn install
  else if test -e pnpm-lock.yaml
    git pull && pnpm install
  else
    git pull
  end
end
