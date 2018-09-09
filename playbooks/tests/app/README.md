Example InSpec Profile
======================

This profile shows the implementation of an InSpec Application (app) profile.

Official documentation
https://www.inspec.io/docs/reference/resources/

How to
------

To manually reproduce the creation of this profile, follow the steps below:

Initialize a new profile

```bash
$ inspec init profile app
$
```

Run the tests against a target and generate reports in HTML

```bash
$ inspec exec app -t ssh://vagrant@app1.local --sudo -i ~/keys/app/libvirt/private_key --reporter html:app1.local.html
$ inspec exec app -t ssh://vagrant@app2.local --sudo -i ~/keys/app/libvirt/private_key --reporter html:app2.local.html
$
```
