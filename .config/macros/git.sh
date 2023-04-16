alias ga='git add'
alias gap='git add -p'
alias gbv='git branch -vv'
alias gch='git checkout'
alias gchb='git checkout -b'
alias gchd='git checkout develop'
alias gcm='git commit -m'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdcc='git diff --cached --compact-summary'
alias gdco='git diff --compact-summary'
alias glf="git log --graph --all --full-history --format='%C(yellow) %h "`
  `"%Cgreen %cr %Cblue %an %C(white) %C(auto) %d %s'"`
  `" --date=format:'%Y-%m-%d %H:%M:%S'"
alias gm='git merge'
alias gmv='git mv'
alias gp='git push'
alias gpo='git push --set-upstream origin $(git branch --show-current)'
alias gpu='git pull'
alias gpuo='git pull origin $(git branch --show-current)'
alias gs='git status'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'

gfl() (
  BRANCH_TYPE=$1
  BRANCH_NAME=$2

  _is_branch_type_supported() {
    [[ $1 == f || $1 == h || $1 == b ]]
  }

  read -r -d '' HELP_TEXT <<'EOF'
Usage:  BRANCH_TYPE BRANCH_NAME
Create a git branch using gitflow standards, and checks it out.

Possible branch types:
  f     to create a feature branch
  h     to create a hotfix branch
  b     to create a bug branch

Examples:
  gfl f ABC-123  Create a new branch called feature/ABC-123 and checks it out.
  gfl b DFE-456  Create a new branch called bug/DFE-456 and checks it out.
EOF
  
  declare -A BRANCHES_PREFIX_FROM_TYPE
  BRANCHES_PREFIX_FROM_TYPE[f]=feature
  BRANCHES_PREFIX_FROM_TYPE[h]=hotfix
  BRANCHES_PREFIX_FROM_TYPE[b]=bug

  if [ -z "$BRANCH_TYPE" ] \
    || [ -z "$BRANCH_NAME" ] \
    || ! _is_branch_type_supported "$BRANCH_TYPE"
  then
    echo "$HELP_TEXT"
    return 1
  fi

  git checkout -b ${BRANCHES_PREFIX_FROM_TYPE[$BRANCH_TYPE]}/"$BRANCH_NAME"
)
