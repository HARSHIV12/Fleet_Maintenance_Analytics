import pandas as pd

from config import CLEAN_DATA_PATH, OUTPUT_PATH
from utils import load_csv, print_line



PRIMARY_KEYS = {
    "trucks.csv": ["truck_id"],
    "drivers.csv": ["driver_id"],
    "maintenance_records.csv": ["maintenance_id"],
    "fuel_purchases.csv": ["fuel_purchase_id"],
    "trips.csv": ["trip_id"],
    "routes.csv": ["route_id"],
    "truck_utilization_metrics.csv": ["truck_id", "month"],
    "facilities.csv": ["facility_id"]
}



FOREIGN_KEYS = [

    {
        "child": "maintenance_records.csv",
        "child_key": "truck_id",
        "parent": "trucks.csv",
        "parent_key": "truck_id"
    },

    {
        "child": "fuel_purchases.csv",
        "child_key": "truck_id",
        "parent": "trucks.csv",
        "parent_key": "truck_id"
    },

    {
        "child": "fuel_purchases.csv",
        "child_key": "driver_id",
        "parent": "drivers.csv",
        "parent_key": "driver_id"
    },

    {
        "child": "trips.csv",
        "child_key": "truck_id",
        "parent": "trucks.csv",
        "parent_key": "truck_id"
    },

    {
        "child": "trips.csv",
        "child_key": "driver_id",
        "parent": "drivers.csv",
        "parent_key": "driver_id"
    }

]

pk_results = []
fk_results = []

print_line()
print("DATA VALIDATION")
print_line()


print("\nPRIMARY KEY VALIDATION\n")

for file_name, keys in PRIMARY_KEYS.items():

    df = load_csv(CLEAN_DATA_PATH / file_name)

    nulls = df[keys].isnull().sum().sum()

    duplicates = df.duplicated(subset=keys).sum()

    status = "PASS"

    if nulls > 0 or duplicates > 0:
        status = "FAIL"

    print(f"{file_name:<35} {status}")

    pk_results.append({

        "Table": file_name,

        "Primary Key": ", ".join(keys),

        "NULL Values": nulls,

        "Duplicate Keys": duplicates,

        "Status": status

    })



print("\nFOREIGN KEY VALIDATION\n")

for relation in FOREIGN_KEYS:

    child = load_csv(CLEAN_DATA_PATH / relation["child"])

    parent = load_csv(CLEAN_DATA_PATH / relation["parent"])

    invalid = child[
        ~child[relation["child_key"]].isin(
            parent[relation["parent_key"]]
        )
    ]

    invalid_count = len(invalid)

    status = "PASS"

    if invalid_count > 0:
        status = "FAIL"

    print(
        f"{relation['child']} --> {relation['parent']} : {status}"
    )

    fk_results.append({

        "Child Table": relation["child"],

        "Foreign Key": relation["child_key"],

        "Parent Table": relation["parent"],

        "Parent Key": relation["parent_key"],

        "Invalid Records": invalid_count,

        "Status": status

    })



pk_df = pd.DataFrame(pk_results)

fk_df = pd.DataFrame(fk_results)

with pd.ExcelWriter(
    OUTPUT_PATH / "Validation_Report.xlsx"
) as writer:

    pk_df.to_excel(
        writer,
        sheet_name="Primary Keys",
        index=False
    )

    fk_df.to_excel(
        writer,
        sheet_name="Foreign Keys",
        index=False
    )

print_line()
print("VALIDATION REPORT GENERATED")
print("File : Validation_Report.xlsx")
print_line()