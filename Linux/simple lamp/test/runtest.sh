##! /usr/bin/bash
#
# Author:  Bram Martens, credits to Bert Van Vreckem <bert.vanvreckem@gmail.com>. 
# 
#
# The .bats files in the directory are tested
#
# The script installs BATS if needed. 

# <<< start Variables

bats_archive="v0.4.0.tar.gz"
bats_url="https://github.com/sstephenson/bats/archive/${bats_archive}"
bats_install_dir="/opt/bats"
bats="${bats_install_dir}/libexec/bats"
test_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# color definitions
Blue='\e[0;34m'
Yellow='\e[0;33m'
Reset='\e[0m'

# >>> End of Variables

# <<< start functions
# Usage: install_bats_if_needed
install_bats_if_needed() {
  pushd "${bats_install_dir%/*}" > /dev/null
  if [[ ! -d "${bats_install_dir}" ]]; then
    wget "${bats_url}"
    tar xf "${bats_archive}"
    mv bats-* bats
    rm "${bats_archive}"
  fi
  popd > /dev/null
}

find_tests(){
  local tests=$(find -type f -name "*.bats" -printf '%p\n' 2> /dev/null)

  echo "${tests}"
}
# >>> End functions

# <<< start script

install_bats_if_needed

# List all test cases in the directory
tests=$(find_tests "${test_dir}" 1)

#execute all tests
for test_case in ${tests}; do
  echo -e "${Blue}Running test ${Yellow}${test_case}${Reset}"
  ${bats} "${test_case}"
done


# >>> end script