

import pandas as pd
import time

from config import RAW_DATA_PATH, CLEAN_DATA_PATH
from utils import load_csv, save_csv, print_line


PROJECT_FILES = [
    "trucks.csv",
    "drivers.csv",
    "maintenance_records.csv",
    "fuel_purchases.csv",
    "trips.csv",
    "routes.csv",
    "truck_utilization_metrics.csv",
    "facilities.csv"
]



DATE_COLUMNS = {
    "trucks.csv": [
        "acquisition_date"
    ],

    "drivers.csv": [
        "hire_date",
        "termination_date",
        "date_of_birth"
    ],

    "maintenance_records.csv": [
        "maintenance_date"
    ],

    "fuel_purchases.csv": [
        "purchase_date"
    ],

    "trips.csv": [
        "dispatch_date"
    ]
}


def clean_column_names(df):
    """
    Standardize column names
    """
    df.columns = (
        df.columns
        .str.strip()
        .str.lower()
        .str.replace(" ", "_")
    )
    return df


def trim_text_columns(df):
    """
    Remove leading/trailing spaces
    """

    object_cols = df.select_dtypes(include="object").columns

    for col in object_cols:

        df[col] = df[col].str.strip()

    return df
def convert_dates(df, filename):
    """
    Convert all project date columns to YYYY-MM-DD
    """

    if filename not in DATE_COLUMNS:
        return df

    for col in DATE_COLUMNS[filename]:

        if col not in df.columns:
            continue


        df[col] = df[col].replace("", pd.NA)


        df[col] = pd.to_datetime(
            df[col],
            errors="coerce"
        )


        df[col] = df[col].dt.strftime("%Y-%m-%d")


        df[col] = df[col].fillna("")

    return df
def remove_duplicate_rows(df):

    before = len(df)

    df = df.drop_duplicates()

    removed = before - len(df)

    return df, removed


def validate_numeric_columns(df):

    numeric_cols = df.select_dtypes(include=["int64", "float64"]).columns

    for col in numeric_cols:

        if "cost" in col.lower():

            df.loc[df[col] < 0, col] = pd.NA

    return df



start = time.time()

summary = []

print_line()
print("FLEET MAINTENANCE ANALYTICS")
print("DATA CLEANING MODULE")
print_line()

for i, file in enumerate(PROJECT_FILES, start=1):

    print(f"\n[{i}/{len(PROJECT_FILES)}] Processing {file}")

    df = load_csv(RAW_DATA_PATH / file)

    original_rows = len(df)

    df = clean_column_names(df)

    df = trim_text_columns(df)

    df = convert_dates(df, file)

  

    df, duplicates_removed = remove_duplicate_rows(df)

    df = validate_numeric_columns(df)

    save_csv(df, CLEAN_DATA_PATH / file)

    summary.append({

        "File": file,

        "Original Rows": original_rows,

        "Final Rows": len(df),

        "Duplicates Removed": duplicates_removed

    })

summary_df = pd.DataFrame(summary)

summary_file = CLEAN_DATA_PATH / "Cleaning_Summary.xlsx"

summary_df.to_excel(
    summary_file,
    index=False
)

print_line()

print(summary_df)

print_line()

print(f"Cleaning Summary Saved : {summary_file}")

print(f"Execution Time : {round(time.time()-start,2)} seconds")

print("DATA CLEANING COMPLETED SUCCESSFULLY")

print_line()