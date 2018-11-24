#!/bin/sh

set -x

yarn flatten

# docker pull mythril/myth
# docker pull luongnguyen/oyente
# docker pull trailofbits/slither

alias myth="docker run -v $(pwd):/opt mythril/myth"
alias oyente="docker run -v $(pwd):/opt luongnguyen/oyente /oyente/oyente/oyente.py"

alias slither="docker run -v $(pwd):/opt trailofbits/slither"

for contract in $(ls temp/); do
  sed -i -e 's/0.5.0/>0.4.9/g' temp/$contract
  echo "Analyzing $contract with Mythril..."
  myth -x /opt/temp/$contract
  # echo "Analyzing $contract with Oyente..."
  # oyente -s /opt/temp/$contract
  echo "Analyzing $contract with Slither..."
  slither /opt/temp/$contract
done
