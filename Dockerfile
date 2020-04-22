FROM sharelatex/sharelatex:latest
ARG VERSION=latest
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL

RUN apt-get update && \
    apt-get install -y --no-install-recommends texlive-full python3 python3-pip && \
    apt-get clean

RUN pip3 install pygments

# Activating shell-escape in Latex.
# Better solutions anyone?
RUN sed -i 's/shell_escape = p/shell_escape = t/g' /usr/share/texlive/texmf-dist/web2c/texmf.cnf

# Adding Uniba Style Files
ADD UBScala /UBScala
RUN cd UBScala && \
    ls -la && \
    chmod +x installttf.sh && \
    ./installttf.sh

LABEL de.uniba.ktr.overleaf.version=$VERSION \
      de.uniba.ktr.overleaf.name="Overleaf" \
      de.uniba.ktr.overleaf.docker.cmd="docker run --publish=80:80 --detach=true --name=overleaf unibaktr/overleaf" \
      de.uniba.ktr.overleaf.vendor="Marcel Grossmann" \
      de.uniba.ktr.overleaf.architecture=$TARGETPLATFORM \
      de.uniba.ktr.overleaf.vcs-ref=$VCS_REF \
      de.uniba.ktr.overleaf.vcs-url=$VCS_URL \
      de.uniba.ktr.overleaf.build-date=$BUILD_DATE
