# Ruby gem: Gig

## Description:

A gem with a command line interface that will save repository owner images based on a repository search using GitHub's Search API.

## Specs:

- Ruby version: 2.7.3
- RSpec version: 3.10.0

## Usage:

- Run `gem build gig.gemspec` to build the gem
- Run `gem install ./gig-0.0.0.gem` to install the gem
- To run RSpec tests, run command `rake` in the root directory
- To run the programme, use `bin/gig <topic_name>` e.g. `bin/gig topic:ruby topic:rails`
- To view the downloaded files run `ls <topic_name>` e.g. `ls topic:ruby-topic:rails`
