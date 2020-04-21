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
