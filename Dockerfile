FROM amazonlinux:2023

USER root
WORKDIR /

COPY user-data.sh /user-data.sh
RUN chmod +x user-data.sh && ./user-data.sh

ENTRYPOINT [ "/bin/bash" ]