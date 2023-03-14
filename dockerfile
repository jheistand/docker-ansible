FROM ubuntu:jammy

RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update \
    && apt-get install -y \
      python3 \
      python3-pip \
      python3-dev \
      python3-winrm \
      ansible \
      krb5-user \
      libkrb5-dev \
      gcc \
    && pip install pyvmomi \
    && ansible-galaxy collection install ansible.windows community.windows community.general community.vmware \
    && rm -rf /var/lib/apt/lists/*
RUN pip install pykerberos pywinrm requests_kerberos --upgrade
COPY krb5.conf /etc/krb5.conf
COPY *.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates
RUN useradd -ms /bin/bash apprunner
USER apprunner

CMD [ "ansible-playbook", "--version" ]
