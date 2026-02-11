This README documents the steps necessary to get the application up and running.

## Ruby version
* **Ruby:** 3.3.5
* **Rails:** 8.1.2

## System dependencies
Before running the app, ensure you have the following installed on your system:
* **PostgreSQL:** 17 (Main Database)
* **Node.js & Yarn:** Managing JavaScript packages
* **Redis:** Using Upstash.
* **Cloudinary:** Media Storage.

## Configuration
1.  **Clone the repository:**
    ```bash
    git clone https://github.com/duongmdnustech/Fotobook.git
    cd Fotobook
    ```

2.  **Environment Variables:**
    Copy the example environment file to create your local configuration:
    ```bash
    cp .env.example .env
    ```

    These are fotobook env file:
    ```bash
    DB_USER=postgres
    DB_PASSWORD=
    DB_HOST=

    DB_PRODUCTION="production database"
    REDIS_URL="redis upstash url"

    CLOUDINARY_CLOUD_NAME=
    CLOUDINARY_API_KEY=
    CLOUDINARY_API_SECRET=

    SECRET_KEY_BASE=
    ```

    Gen secret key and update SECRET_KEY_BASE in the .env:
    ```bash
    rails secret
    ```
    *Update the `.env` file with your specific database credentials and API keys.*

3.  **Install dependencies:**
    ```bash
    bundle install
    yarn install
    yarn build
    ```

## Database creation
Create the local database and run migrations to set up the schema:

```bash
rails db:create
rails db:migrate
```