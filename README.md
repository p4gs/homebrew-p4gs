# homebrew-p4gs

Homebrew tap for [p4gs](https://github.com/p4gs) open-source tools.

```sh
brew tap p4gs/p4gs
brew install sscsb
```

Or in one step, without tapping first:

```sh
brew install p4gs/p4gs/sscsb
```

## Formulae

| Formula | What it is |
|---------|------------|
| [`sscsb`](Formula/sscsb.rb) | [SSCS Bootstrapper](https://github.com/p4gs/sscs-bootstrapper) — software supply chain security for solo developers and small teams who write code with AI, bootstrapped into a git repository in one command. |

## What you are trusting when you tap this

A Homebrew tap is a supply-chain trust anchor: tapping it means `brew` will run
Ruby from this repository on your machine, and install binaries whose URLs this
repository chooses. That deserves to be said plainly rather than assumed.

So this tap is held to the same standard as the tools it distributes:

- **Every formula installs a pinned artifact.** Each `url` points at a specific
  release tag and carries the `sha256` of that exact file. Homebrew refuses the
  install if the bytes it downloads do not match. Nothing here builds from a
  moving `HEAD` or fetches `latest`.
- **The artifacts are signed and attested at their source.** `sscsb` releases are
  keyless-signed with [Cosign](https://github.com/sigstore/cosign) (Fulcio
  certificate + Rekor transparency log) and carry GitHub build-provenance and
  SBOM attestations. You can verify any release asset yourself:

  ```sh
  gh attestation verify sscsb-v0.2.0-aarch64-apple-darwin.tar.gz --repo p4gs/sscs-bootstrapper
  ```

- **This repository is itself hardened by `sscsb`.** It carries `.sscsb/`
  policy, secret-scanning hooks, and pinned CI. Run `sscsb verify` inside a clone
  to see its posture — the tool distributing itself through this tap is used on
  the tap.
- **Commits are signature-gated.** `main` requires signed commits and rejects
  force-pushes. An AI agent can prepare a change here; it cannot land one.

## Verifying an install yourself

```sh
brew install p4gs/p4gs/sscsb
sscsb --version

# Where brew put it, and what it hashed:
brew info p4gs/p4gs/sscsb
brew fetch p4gs/p4gs/sscsb --force   # prints the SHA-256 it downloaded
```

## Reporting a problem

Formula bugs — a bad checksum, a broken install, a missing platform — belong
here: [open an issue](https://github.com/p4gs/homebrew-p4gs/issues).

Bugs in the tools themselves belong in their own repositories, e.g.
[p4gs/sscs-bootstrapper](https://github.com/p4gs/sscs-bootstrapper/issues).

Security reports: see [SECURITY.md](SECURITY.md). Please do not open a public
issue for a vulnerability.
