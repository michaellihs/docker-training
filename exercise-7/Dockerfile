FROM centos:7

RUN yum update -y
RUN yum install -y wget vim

CMD ["127.0.0.1"]
ENTRYPOINT ["ping", "-c", "3"]
