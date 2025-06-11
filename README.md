# Atuin Server Home Assistant Addon

Run an Atuin server with external PostgreSQL support in Home Assistant.

## Installation

1. Add this repository to Home Assistant:
https://github.com/amasolov/atuin-homeassistant-addon

2. Install the "Atuin Server" addon
3. Configure your PostgreSQL connection details:
- Database host (IP/hostname of your PostgreSQL server)
- Port (default: 5432)
- Database name
- Username
- Password
4. Start the addon

## Client Configuration

On your devices with Atuin CLI installed:

```bash
atuin server login -u <your-username> -p <your-password> http://homeassistant.local:8888
```

## Requirements

- Existing PostgreSQL server (version 13+ recommended)
- Pre-created database and user with appropriate privileges

*To use this addon**:

Create a PostgreSQL database and user:
```sql
CREATE DATABASE atuin;
CREATE USER atuin WITH ENCRYPTED PASSWORD 'your-strong-password';
GRANT ALL PRIVILEGES ON DATABASE atuin TO atuin;
```
