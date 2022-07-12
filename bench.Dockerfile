FROM ocaml/opam:debian-10-ocaml-4.14
RUN sudo rm /usr/bin/opam && sudo ln -s /usr/bin/opam-2.1 /usr/bin/opam \
    && sudo apt-get install -y jq \
# https://github.com/sharkdp/hyperfine
    && curl -fsSL https://github.com/sharkdp/hyperfine/releases/download/v1.13.0/hyperfine_1.13.0_arm64.deb --output hyperfine.deb \
    && sudo dpkg -i hyperfine.deb \
    && mkdir benchppx
WORKDIR benchppx
COPY --chown=opam:opam . ./
RUN opam install . --deps-only \
    && opam exec -- dune build ./benchppx.exe
RUN hyperfine --export-json ./hyperfinejson.txt --show-output './_build/default/.ppx/*/ppx.exe ./benchppx.ml'
# WORKDIR hyperfinejson.txt