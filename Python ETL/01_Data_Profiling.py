from pathlib import Path
import pandas as pd

from config import RAW_DATA_PATH, OUTPUT_PATH
from utils import (
    load_csv,
    duplicate_rows,
    dataframe_size,
    print_line,
)

profile_summary = []

print_line()
print("DATA PROFILING REPORT")
print_line()

csv_files = sorted(RAW_DATA_PATH.glob("*.csv"))

for file in csv_files:

    print(f"\nProcessing : {file.name}")

    df = load_csv(file)

    rows = df.shape[0]
    cols = df.shape[1]

    duplicates = duplicate_rows(df)

    missing = df.isnull().sum().sum()

    size = dataframe_size(df)

    print(f"Rows              : {rows}")
    print(f"Columns           : {cols}")
    print(f"Missing Values    : {missing}")
    print(f"Duplicate Rows    : {duplicates}")
    print(f"Memory Usage(MB)  : {size}")

    profile_summary.append({
        "File Name": file.name,
        "Rows": rows,
        "Columns": cols,
        "Missing Values": missing,
        "Duplicate Rows": duplicates,
        "Memory(MB)": size
    })

summary_df = pd.DataFrame(profile_summary)

print_line()
print("SUMMARY")
print_line()

print(summary_df)

output_file = OUTPUT_PATH / "Data_Profile_Summary.xlsx"

summary_df.to_excel(
    output_file,
    index=False
)

print(f"\nReport saved to:\n{output_file}")

print("\nReport Generated Successfully.")