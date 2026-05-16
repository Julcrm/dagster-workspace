# =============================================================================
# Dagster Workspace — Webserver & Daemon
# Central orchestration service. Connects to each project's gRPC code server
# and exposes the Dagster UI on port 3000.
# Runtime: Python 3.11-slim, dagster, dagster-webserver, dagster-postgres
# =============================================================================

FROM python:3.11-slim

WORKDIR /opt/dagster/app

ENV DAGSTER_HOME=/opt/dagster/dagster_home
RUN mkdir -p /opt/dagster/dagster_home

RUN pip install --upgrade pip
RUN pip install --no-cache-dir dagster dagster-webserver dagster-postgres

# workspace.yaml lists the gRPC code servers (one per project)
COPY workspace.yaml .
# dagster.yaml configures storage backend (PostgreSQL)
COPY dagster.yaml $DAGSTER_HOME/dagster.yaml

EXPOSE 3000

CMD ["dagster-webserver", "-w", "workspace.yaml", "-h", "0.0.0.0", "-p", "3000"]
