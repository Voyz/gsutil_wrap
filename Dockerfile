FROM python:3.7.7-slim-buster

RUN python -m pip install gsutil

RUN echo '[GoogleCompute]\nservice_account = default' > /etc/boto.cfg

ENTRYPOINT ["bash"]