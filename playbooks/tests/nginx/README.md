Example InSpec Profile
======================

This profile shows the implementation of an InSpec NGINX profile.

Official documentation
https://www.inspec.io/docs/reference/resources/

How to
------

To manually reproduce the creation of this profile, follow the steps below:

Initialize a new profile

```bash
$ inspec init profile nginx
$
```

Run the tests against a target and generate reports in HTML

```bash
$ inspec exec nginx -t ssh://vagrant@nginx.local --sudo -i ~/keys/nginx/libvirt/private_key --reporter html:nginx.local.html
$
```
