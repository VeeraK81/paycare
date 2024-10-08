# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install the Python dependencies
RUN pip install -r requirements.txt

# Make a volume mount point for the input/output CSV files
VOLUME ["/app/input_data.csv", "/app/output_data.csv"]


# Run the application (by default, run the main ETL process)
CMD ["python", "etl_process.py"]
