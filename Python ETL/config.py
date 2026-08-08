from pathlib import Path

# ==========================
# Project Root
# ==========================
PROJECT_ROOT = Path(__file__).resolve().parent.parent

# ==========================
# Dataset Paths
# ==========================
RAW_DATA_PATH = PROJECT_ROOT / "02_Dataset" / "Raw"
CLEAN_DATA_PATH = PROJECT_ROOT / "02_Dataset" / "Cleaned"

# ==========================
# Output Paths
# ==========================
OUTPUT_PATH = PROJECT_ROOT / "03_Python_ETL" / "Output"
LOG_PATH = PROJECT_ROOT / "03_Python_ETL" / "Logs"

# ==========================
# Create folders if missing
# ==========================
OUTPUT_PATH.mkdir(exist_ok=True)
LOG_PATH.mkdir(exist_ok=True)
CLEAN_DATA_PATH.mkdir(exist_ok=True)