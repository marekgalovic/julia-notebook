FROM "jupyter/minimal-notebook"

USER root

ENV JULIA_VERSION=1.5.3

RUN mkdir /opt/julia-${JULIA_VERSION} && \
    cd /tmp && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/`echo ${JULIA_VERSION} | cut -d. -f 1,2`/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 && \
    rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz

RUN ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia

RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add("Flux"); using Flux' && \
    julia -e 'import Pkg; Pkg.add("JSON"); using JSON' && \
    julia -e 'import Pkg; Pkg.add("BSON"); using BSON' && \
    julia -e 'import Pkg; Pkg.add("IJulia"); using IJulia'