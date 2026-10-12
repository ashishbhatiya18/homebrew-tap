# ashishbhatiya18/homebrew-tap

```sh
brew install ashishbhatiya18/tap/home
home install      # background jobs, one brew service each
```

| Formula | Description |
|---|---|
| [home](https://github.com/ashishbhatiya18/homelab/tree/main/home-cli) | Run your homelab from your Mac: nodes, stacks, bundle deploys, upgrades, encrypted Postgres backups (`home br`) |
| home-backup | `home` background job: backups when due |
| home-check | `home` background job: daily node and update check |
| home-cleanup | `home` background job: daily pruning of unused images and caches |
| home-deploy | `home` background job: deploys new node bundles |
| [otelgenie](https://github.com/ashishbhatiya18/otelgenie) | From a collector endpoint to working OpenTelemetry: a guided page on your own machine (`otelgenie install` keeps it running at http://127.0.0.1:11111/) |

The formulae are written by the release workflow in
[homelab](https://github.com/ashishbhatiya18/homelab) (`home-cli-v*` tags); the
binaries come from the package `ghcr.io/ashishbhatiya18/home-cli`. `hbr` is now
`home br`.

`otelgenie` is written by the release workflow in
[otelgenie](https://github.com/ashishbhatiya18/otelgenie) (`v*` tags); the binaries are that
repository's release assets, so only the built program is installed.
