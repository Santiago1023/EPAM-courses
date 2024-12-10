/*
The following AWS CodePipeline source code is used to validate
and check the format of the codes before you can merge it with
the master branch.
*/

build:
  commands:
  - terraform validate
  - terraform fmt -check=true -write=false -diff=true