FROM sharelatex/sharelatex:latest

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
    ./installttf.sh

LABEL de.uniba.ktr.cadvisor.version=$VERSION \
      de.uniba.ktr.cadvisor.name="Overleaf" \
      de.uniba.ktr.cadvisor.docker.cmd="docker run --publish=80:80 --detach=true --name=overleaf unibaktr/overleaf" \
      de.uniba.ktr.cadvisor.vendor="Marcel Grossmann" \
      de.uniba.ktr.cadvisor.architecture=$TARGETPLATFORM \
      de.uniba.ktr.cadvisor.vcs-ref=$VCS_REF \
      de.uniba.ktr.cadvisor.vcs-url=$VCS_URL \
      de.uniba.ktr.cadvisor.build-date=$BUILD_DATE
