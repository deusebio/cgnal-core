# syntax=docker/dockerfile:1

FROM python:3.7-slim-buster as builder

WORKDIR /app

COPY requirements/requirements.txt requirements/requirements.txt
RUN pip3 install -r requirements/requirements.txt

COPY LICENSE MANIFEST.in versioneer.py setup.py setup.cfg README.md .
COPY cgnal/core cgnal/core

RUN python3 setup.py sdist && ls -t dist/* | tail -n1 | xargs pip install


FROM python:3.7-slim-buster
WORKDIR /app
ENV PYTHONPATH=/app/site-packages
COPY --from=builder /usr/local/lib/python3.7/site-packages /app/site-packages
ENTRYPOINT ["python"]
