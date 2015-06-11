Terminus Est
------------

[![Circle CI](https://circleci.com/gh/pine613/Est/tree/master.svg?style=svg&circle-token=9545739e66e386e4701be6dd34729db49ac94d42)](https://circleci.com/gh/pine613/Est/tree/master)

## Development environments

- Carton
- Amon2
- [WebService::Slack::IncomingWebHook](https://metacpan.org/pod/WebService::Slack::IncomingWebHook)
- [Context.IO](https://context.io/)
- [OpenShift](https://www.openshift.com/)

## Getting started

```sh
$ carton install --deployment
$ carton exec -- perl ./script/est-server --port=$PORT
```
