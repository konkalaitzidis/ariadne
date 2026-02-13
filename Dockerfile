FROM continuumio/miniconda3

WORKDIR /app

# 1. Copy the environment file
COPY environment.yml .

# 2. Create the conda environment (No local pip install yet)
RUN conda env create -f environment.yml && conda clean -afy

# 3. NOW copy the rest of your project (including setup.py)
COPY . .

# 4. Use the specific conda python to install your project
SHELL ["conda", "run", "-n", "ariadne", "/bin/bash", "-c"]
RUN pip install -e .

# 5. Default command
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "ariadne", "python", "scripts/train.py"]