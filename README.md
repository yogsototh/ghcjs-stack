> This project has two homes.
> It is ok to work in github, still, for a better decentralized web
> please consider contributing (issues, PR, etc...) throught:
>
> https://gitlab.esy.fun/yogsototh/ghcjs-stack

---


# ghcjs-stack
align ghcjs with stack


Allow to create ghcjs installation archive which has the same versions as the `stack --resolver`

exceptions:
`integer-gmp` - this needs some love to makie it 
`cabal`  
`ghc-prim`

downside is we need to maintain patches for all versions we have...
