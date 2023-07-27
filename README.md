# Nix Scala Minimal

A minimal Scala development environment as a Nix flake, based on:
- OpenJDK 17
- Metals
- SBT
- Scalafmt

## Usage

### Ad-hoc shell

```shell
nix develop github:what-the-functor/nix-scala-minimal
```

### direnv

`.envrc`
```
use flake github:what-the-functor/nix-scala-minimal
```

See also:
- [typelevel-nix](https://github.com/typelevel/typelevel-nix) for a more featureful flake.
