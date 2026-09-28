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
# Pinned: an unpinned rebuild on 2026-09-28 pulled SQLAlchemy 2.1, whose default
# PostgreSQL driver is psycopg 3 (not installed): webserver and daemon crash-looped.
# Keep dagster on the series of the code servers (bluesky-streamhouse: 1.13.24)
RUN pip install --no-cache-dir \
    dagster==1.13.24 \
    dagster-webserver==1.13.24 \
    dagster-postgres==0.29.24 \
    "sqlalchemy>=2.0,<2.1"

# workspace.yaml lists the gRPC code servers (one per project)
COPY workspace.yaml .
# dagster.yaml configures storage backend (PostgreSQL)
COPY dagster.yaml $DAGSTER_HOME/dagster.yaml

EXPOSE 3000

CMD ["dagster-webserver", "-w", "workspace.yaml", "-h", "0.0.0.0", "-p", "3000"]
