FROM ubuntu:latest
RUN apt-get update && apt-get -y update

RUN apt-get install -qy apt-utils
RUN apt-get install -qy build-essential python3.6 python3-pip python3-dev
# RUN apt-get install -qy python3.6
# RUN apt-get install -qy python3-pip
# RUN apt-get install -qy python3-dev
RUN pip3 -q install pip --upgrade
# RUN apt-get install -qy wget
# RUN apt-get install -qy Pkg  (think this is in julia prompt)
RUN apt-get install -qy julia

# RUN pip3 install -r requirements.txt
RUN pip3 install jupyter

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
