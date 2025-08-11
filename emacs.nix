{ pkgs }:

(pkgs.emacsPackagesFor pkgs.emacsNativeComp).emacsWithPackages (
  epkgs: with epkgs; [
    (pkgs.runCommand "default.el" { } ''
      mkdir -p $out/share/emacs/site-lisp
          cp ${./init.el} $out/share/emacs/site-lisp/default.el
    '')
    breadcrumb
    browse-at-remote
    browse-kill-ring
    cider
    clojure-mode
    corfu
    diff-hl
    eat
    ef-themes
    embark-consult
    envrc
    exec-path-from-shell
    flymake
    focus
    fullframe
    gptel
    hide-mode-line
    highlight-symbol
    ibuffer-project
    j-mode
    justl
    ledger-mode
    magit
    marginalia
    markdown-mode
    modus-themes
    move-dup
    nix-ts-mode
    ocaml-ts-mode
    orderless
    paredit
    reformatter
    rg
    slime
    symbol-overlay
    use-package
    vertico
    vterm
    which-key
    whole-line-or-region
    xref
    yasnippet
    zygospore
    (treesit-grammars.with-grammars (
      treesit-pkgs: with treesit-pkgs; [
        tree-sitter-typescript
        tree-sitter-nix
        tree-sitter-tsx
        tree-sitter-json
      ]
    ))
  ]
)
