FROM fishtownanalytics/dbt:1.0.0

# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True
ENV PORT 8080
ENV APP_HOME /app
ENV DBT_PROFILES_DIR $APP_HOME
ENV DBT_PROJECT_DIR $APP_HOME
ENV FLASK_SERVICE_DIR $APP_HOME

# Expose port
EXPOSE $PORT

# Copy local code to the container image.
WORKDIR $APP_HOME
COPY . ./

# Check if DBT runs correctly
WORKDIR $DBT_PROJECT_DIR
RUN dbt deps

# Install tested(!) production dependencies.
WORKDIR $FLASK_SERVICE_DIR
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
# Timeout is set to 0 to disable the timeouts of the workers to allow Cloud Run to handle instance scaling.
ENTRYPOINT exec python -m gunicorn \
    --bind :$PORT \
    --workers 2 \
    --threads 8 \
    --timeout 0 \
    server:app