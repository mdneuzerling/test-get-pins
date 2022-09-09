FROM public.ecr.aws/lambda/provided
RUN yum -y install wget tar
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
  wget https://cdn.rstudio.com/r/centos-7/pkgs/R-4.2.1-1-1.x86_64.rpm && \
  yum -y install R-4.2.1-1-1.x86_64.rpm && \
  rm R-4.2.1-1-1.x86_64.rpm
ENV PATH="${PATH}:/opt/R/4.2.1/bin/"
RUN echo 'options(repos = c(CRAN = "https://packagemanager.rstudio.com/all/__linux__/centos7/latest"))' >> /opt/R/4.2.1/lib/R/etc/Rprofile.site

RUN yum update -y && yum install -y \
  libcurl-devel \
  openssl-devel \
  make \
  libxml2-devel \
  epel-release \
  pandoc

RUN Rscript -e "install.packages(c('lambdr', 'pins', 'paws.storage'))"

COPY runtime.R /opt/ml/runtime.R

RUN printf '#!/bin/sh\nRscript /opt/ml/runtime.R' > /var/runtime/bootstrap \
        && chmod +x /var/runtime/bootstrap

CMD ["get_pin_contents"]
