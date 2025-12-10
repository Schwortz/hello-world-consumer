# Hello World Consumer

A simple Python application that demonstrates how to use the `hello-world-test-private-repo` package from a private devpi repository.

## Prerequisites

1. The devpi server must be running (see `../devpi/`)
2. The `hello-world-test-private-repo` package must be uploaded to the devpi server
3. You need authentication credentials (username and password) to access the private repository

## Installation

### Option 1: Using pip with extra index URL and authentication (recommended)

```bash
pip install --extra-index-url http://consumer:consumer123@localhost:3141/root/public/+simple/ hello-world-test-private-repo
```

**Note:** 
- Using `--extra-index-url` allows pip to fall back to PyPI for build dependencies (like setuptools, wheel) while still checking the private repo for your package.
- The credentials are embedded in the URL: `http://username:password@host/path`
- **Security Warning:** This exposes credentials in command history. Consider using environment variables or a credentials file (see Option 3).

### Option 2: Using pip with index URL (private repo only)

```bash
pip install --index-url http://localhost:3141/root/public/+simple/ hello-world-test-private-repo
```

**Note:** This replaces PyPI entirely, so you'll need to ensure build dependencies are available in your private repo or install them separately.

### Option 3: Using environment variables (more secure)

Set credentials as environment variables:

```bash
export DEVPI_USERNAME=consumer
export DEVPI_PASSWORD=consumer123
pip install --extra-index-url "http://${DEVPI_USERNAME}:${DEVPI_PASSWORD}@localhost:3141/root/public/+simple/" hello-world-test-private-repo
```

### Option 4: Using .netrc file (most secure)

Create or edit `~/.netrc` (Linux/Mac) or `%USERPROFILE%\_netrc` (Windows):

```
machine localhost
login consumer
password consumer123
```

Then use the URL without credentials:
```bash
pip install --extra-index-url http://localhost:3141/root/public/+simple/ hello-world-test-private-repo
```

**Note:** Make sure to set proper permissions on .netrc: `chmod 600 ~/.netrc`

### Option 5: Configure pip to always use the private repo

Create or edit `~/.pip/pip.conf` (Linux/Mac) or `%APPDATA%\pip\pip.ini` (Windows):

```ini
[global]
extra-index-url = http://consumer:consumer123@localhost:3141/root/public/+simple/
```

Then install normally:
```bash
pip install hello-world-test-private-repo
```

**Security Note:** Credentials in pip.conf are stored in plain text. Consider using .netrc instead.

### Option 6: Using requirements.txt

```bash
pip install --extra-index-url http://consumer:consumer123@localhost:3141/root/public/+simple/ -r requirements.txt
```

Or use environment variables:
```bash
export DEVPI_USERNAME=consumer
export DEVPI_PASSWORD=consumer123
pip install --extra-index-url "http://${DEVPI_USERNAME}:${DEVPI_PASSWORD}@localhost:3141/root/public/+simple/" -r requirements.txt
```

## Running the Application

```bash
python3 main.py
```

## Expected Output

```
==================================================
Hello World Consumer Application
==================================================

Default greeting: Hello, World!
Custom greeting: Hello, Python Developer!
Another greeting: Hello, Private Repository!

==================================================
All greetings completed successfully!
==================================================
```

## Development

To set up a development environment:

```bash
# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies from private repo (with authentication)
export DEVPI_USERNAME=consumer
export DEVPI_PASSWORD=consumer123
pip install --extra-index-url "http://${DEVPI_USERNAME}:${DEVPI_PASSWORD}@localhost:3141/root/public/+simple/" -r requirements.txt

# Run the application
python3 main.py
```

## Authentication

The devpi repository requires authentication. Default credentials:
- **Username:** `consumer`
- **Password:** `consumer123`

To change credentials, contact your repository administrator or see the devpi setup documentation.

## Troubleshooting

### Package not found

If you get an error like "Could not find a version that satisfies the requirement", make sure:

1. The devpi server is running: `docker compose -f ../devpi/docker-compose.yml ps`
2. The package is uploaded: Check `http://localhost:3141/root/public/+simple/hello-world-test-private-repo/`
3. You're using the correct index URL with authentication
4. Your credentials are correct

### Authentication failed

If you get a 401 Unauthorized error:

1. Verify your credentials are correct
2. Check that the username and password are properly encoded in the URL
3. Try using environment variables or .netrc file instead of embedding credentials in the URL
4. Make sure the user account exists on the devpi server

### Connection refused

If you get a connection error, verify the devpi server is accessible:

```bash
curl http://localhost:3141/
```

