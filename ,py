import pandas as pd
import matplotlib.pyplot as plt

def load_data(file_path):
    """
    Load Y-DNA data from a CSV file.
    :param file_path: Path to the CSV file
    :return: Pandas DataFrame with loaded data or None if an error occurs
    """
    try:
        data = pd.read_csv(file_path)
        # Validate columns
        required_columns = {"SNP", "STR", "Haplogroup"}
        missing_columns = required_columns - set(data.columns)
        if missing_columns:
            raise KeyError(f"Missing required columns: {', '.join(missing_columns)}")
        print(f"Data loaded successfully from {file_path}")
        return data
    except FileNotFoundError:
        print(f"Error: File not found at {file_path}")
        return None
    except KeyError as e:
        print(f"Error: {e}")
        return None
    except Exception as e:
        print(f"An error occurred: {e}")
        return None

def generate_scatter(data):
    """
    Create a scatter plot for SNP vs STR data.
    :param data: Pandas DataFrame containing SNP, STR, and Haplogroup columns
    """
    if data is None:
        print("No data to plot. Please load data first.")
        return

    try:
        plt.figure(figsize=(10, 6))
        scatter = plt.scatter(
            data["SNP"], data["STR"],
            c=data["Haplogroup"].astype("category").cat.codes,
            cmap="viridis", alpha=0.7, edgecolor="k"
        )
        plt.title("SNP vs STR Scatter Plot")
        plt.xlabel("SNP Variants")
        plt.ylabel("STR Repeats")
        plt.colorbar(scatter, label="Haplogroup (Encoded)")
        plt.grid(True)
        plt.show()
        print("Scatter plot generated successfully.")
    except KeyError as e:
        print(f"Error: Missing required column - {e}")
    except Exception as e:
        print(f"An error occurred: {e}")

def main():
    """
    Main function to run the Y-DNA Analyzer as a standalone tool.
    """
    print("Welcome to the Y-DNA Analyzer!")
    file_path = input("Enter the path to your Y-DNA CSV file: ").strip()
    
    # Load data
    data = load_data(file_path)
    if data is None:
        print("Exiting due to data loading error.")
        return

    # Generate scatter plot
    generate_scatter(data)
    print("Analysis complete!")

if __name__ == "__main__":
    main()
