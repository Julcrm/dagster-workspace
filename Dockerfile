FROM python:3.11-slim

WORKDIR /opt/dagster/app

RUN mkdir -p $DAGSTER_HOME

RUN pip install --no-cache-dir \
    dagster \
    dagster-webserver

COPY workspace.yaml .

EXPOSE 3000

CMD ["dagster-webserver", "-w", "workspace.yaml", "-h", "0.0.0.0", "-p", "3000"]
