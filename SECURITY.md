# Security Policy

## Reporting a vulnerability

Please report vulnerabilities through
[GitHub private vulnerability reporting](https://github.com/p4gs/homebrew-p4gs/security/advisories/new)
— it keeps the report private while it is triaged and fixed, and it credits you
in the advisory when it is published.

Please do **not** open a public issue for a security report, and do not include
proof-of-concept secrets or live credentials in a report.

What to expect:

- **Acknowledgement** within 72 hours.
- **Triage verdict** (accepted / not a vulnerability / needs more info) within 7 days.
- **Fix or mitigation** for accepted reports targeted within 30 days, with a
  published GitHub Security Advisory. Coordinated disclosure is the default; if a
  fix needs longer, you'll get a status update and a revised timeline rather than
  silence.

## What is in scope here

This repository is a **Homebrew tap** — formula definitions, not the source of
the tools themselves. In scope for a report against this repo:

- A formula whose `sha256` does not match the artifact its `url` points at.
- A formula pointing at an artifact that is not the intended release (wrong repo,
  wrong tag, a mutable ref, a non-GitHub host).
- Anything in a formula's `install`, `test`, or `postinstall` block that executes
  something other than unpacking and installing the pinned artifact.
- Repository configuration that would let an unreviewed or unsigned commit reach
  `main`.

Vulnerabilities **in the tools themselves** belong in their own repositories —
for example [p4gs/sscs-bootstrapper](https://github.com/p4gs/sscs-bootstrapper/security/advisories/new).
A crash or a wrong verdict in `sscsb` is a `sscs-bootstrapper` report, not a tap
report.

## How this tap protects you

- **Pinned artifacts.** Every formula pins a release tag and the `sha256` of that
  exact file. Homebrew aborts on a mismatch, so a swapped artifact fails the
  install rather than silently succeeding.
- **Signed, attested upstreams.** Release artifacts are keyless-signed with
  Cosign (Fulcio + Rekor) and carry GitHub build-provenance and SBOM
  attestations. Verify one yourself:

  ```sh
  gh attestation verify <asset>.tar.gz --repo p4gs/sscs-bootstrapper
  ```

- **Signature-gated `main`.** Signed commits required, force-push blocked.
- **Dogfooded.** This repository is hardened with `sscsb` itself — `.sscsb/`
  policy, secret-scanning hooks, pinned CI.
