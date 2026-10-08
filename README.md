# Dagster Workspace

Central orchestration service for all data projects in the portfolio.
Runs continuously on Coolify, projects connect to it via gRPC.

## Architecture
- This service: webserver + daemon only
- Each project: its own Docker container, its own assets, exposes port 4000

## Adding a project
1. Deploy the project as a Coolify service (port 4000)
2. Add it to workspace.yaml. `host` is the **service name** in the project's compose:
   Coolify adds it as a network alias on `coolify` (container names get a suffix)
   ```yaml
   - grpc_server:
       host: compose-service-name
       port: 4000
       location_name: project_name
   ```
3. The code server needs the same `DAGSTER_POSTGRES_*` variables as this service:
   runs execute in its container (DefaultRunLauncher) and write to this storage
4. Push to `main`: the Coolify webhook redeploys the webserver and the daemon

## Versions

Dagster packages are pinned in the Dockerfile. Keep them on the same series as the
code servers, and upgrade on purpose (an unpinned rebuild once pulled an incompatible
SQLAlchemy release and took the UI and the daemon down).

## Active projects

| Location | Host (gRPC :4000) | Project |
|---|---|---|
| `velib_lakehouse` | `velib-lakehouse` | Vélib Paris medallion lakehouse pipeline |
| `bluesky_duckdb` | `bluesky-duckdb` | Bluesky Streamhouse, DuckDB branch: Silver/Gold dbt-duckdb on DuckLake (Quix Streams ingestion) |
| `bluesky_spark` | `bluesky-spark` | Bluesky Streamhouse, Spark branch: Silver/Gold dbt-spark on Iceberg through a Spark Thrift server (Spark Structured Streaming ingestion) |
