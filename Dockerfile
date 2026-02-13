FROM continuumio/miniconda3

WORKDIR /app

# Copy dependency file
COPY environment.yml .

# Create the environment
RUN conda env create -f environment.yml && conda clean -afy

# Copy the rest of the project
COPY . .

# Ensure the environment is used for all subsequent commands
SHELL ["conda", "run", "-n", "ariadne", "/bin/bash", "-c"]

# Install the ariadne package in editable mode
RUN pip install -e .

# Run the training script by default
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "ariadne", "python", "scripts/train.py"]