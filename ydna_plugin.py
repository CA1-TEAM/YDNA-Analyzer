import gramps.gen.plug.menu as menu
import pandas as pd
import matplotlib.pyplot as plt
from gramps.gui.plug import Gramplet

class YDNAAnalyzer(Gramplet):
    """
    Gramps plugin to analyze Y-DNA data using scatter plots.
    """

    def init(self):
        """Initialize the plugin and register menu options."""
        self.set_tooltip("Analyze Y-DNA data using scatter plots")
        self.set_text("Y-DNA Analyzer is ready")
        self.register_menu_option("Load Y-DNA Data", self.load_data)
        self.register_menu_option("Generate Scatter Plot", self.generate_scatter)

        self.data = None  # Placeholder for loaded data

    def load_data(self):
        """Load Y-DNA data from a CSV file."""
        file_path = self.get_file_path("Select Y-DNA CSV File")
        if not file_path:
            self.set_text("No file selected.")
            return

        try:
            # Load the CSV file into a Pandas DataFrame
            self.data = pd.read_csv(file_path)
            self.set_text(f"Data loaded successfully from {file_path}")
        except FileNotFoundError:
            self.set_text("Error: File not found.")
        except Exception as e:
            self.set_text(f"An error occurred: {e}")

    def generate_scatter(self):
        """Generate a scatter plot for SNP vs STR."""
        if self.data is None:
            self.set_text("No data loaded. Please load Y-DNA data first.")
            return

        try:
            plt.figure(figsize=(10, 6))
            scatter = plt.scatter(
                self.data["SNP"], self.data["STR"],
                c=self.data["Haplogroup"].astype("category").cat.codes,
                cmap="viridis", alpha=0.7, edgecolor="k"
            )
            plt.title("SNP vs STR Scatter Plot")
            plt.xlabel("SNP Variants")
            plt.ylabel("STR Repeats")
            plt.colorbar(scatter, label="Haplogroup (Encoded)")
            plt.grid(True)
            plt.show()
            self.set_text("Scatter plot generated successfully.")
        except KeyError as e:
            self.set_text(f"Error: Missing required column - {e}")
        except Exception as e:
            self.set_text(f"An error occurred: {e}")

# Register the plugin in the Gramps Tools menu
menu.register_menu("Tools/Y-DNA Analyzer", YDNAAnalyzer)

