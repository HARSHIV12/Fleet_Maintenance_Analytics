import pandas as pd


def load_csv(file_path):
    return pd.read_csv(
        file_path,
        dtype=str,
        keep_default_na=False
    )

def save_csv(df, file_path):
    df.to_csv(
        file_path,
        index=False,
        encoding="utf-8-sig"
    )

def print_line():
    print("=" * 90)


def missing_values(df):
    """
    Returns missing values count
    """
    return df.isnull().sum()


def duplicate_rows(df):
    """
    Returns duplicate row count
    """
    return df.duplicated().sum()


def dataframe_size(df):
    """
    Returns memory usage in MB
    """
    return round(
        df.memory_usage(deep=True).sum() / (1024 * 1024),
        2
    )