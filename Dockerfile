FROM python:3.11-slim

WORKDIR /opt/dagster/app

ENV DAGSTER_HOME=/opt/dagster/dagster_home
RUN mkdir -p /opt/dagster/dagster_home

RUN pip install --upgrade pip
RUN pip install --no-cache-dir dagster dagster-webserver dagster-postgres

COPY workspace.yaml .
COPY dagster.yaml $DAGSTER_HOME/dagster.yaml

EXPOSE 3000

CMD ["dagster-webserver", "-w", "workspace.yaml", "-h", "0.0.0.0", "-p", "3000"]