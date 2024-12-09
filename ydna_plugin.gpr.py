import gramps.gen.plug.menu as menu
import pandas as pd
import matplotlib.pyplot as plt
from gramps.gui.plug import Gramplet
from gramps.gen.const import GRAMPS_LOCALE as glocale

# Enable localization
_ = glocale.translation.gettext

PLUGIN = {
    "name": "Y-DNA Analyzer",
    "description": "Analyze Y-DNA data using scatter plots in Gramps. "
                   "This plugin allows users to load Y-DNA data from a CSV file and generate "
                   "scatter plots to visualize SNP variants, STR repeats, and haplogroup distributions.",
    "version": "1.1",
    "gramps_target_version": "5.2",
    "status": "Stable",
    "fname": "ydna_plugin.py",
    "authors": ["Your Name or Alias"],  # Optional: Add your name or alias
    "help_url": "https://github.com/your-repository/ydna-analyzer",  # Optional: Provide a URL for documentation
    "category": "Tools",
    "tooltip": "Analyze Y-DNA data with scatter plots.",
}

class YDNAAnalyzer(Gramplet):
    """
    Gramps plugin to analyze Y-DNA data using scatter plots.
    """

    def init(self):
        """Initialize the plugin and register menu options."""
        self.set_tooltip(_("Analyze Y-DNA data using scatter plots"))
        self.set_text(_("Y-DNA Analyzer is ready"))
        self.register_menu_option(_("Load Y-DNA Data"), self.load_data)
        self.register_menu_option(_("Generate Scatter Plot"), self.generate_scatter)

        self.data = None  # Placeholder for loaded data

    def load_data(self):
        """Load Y-DNA data from a CSV file."""
        file_path = self.get_file_path(_("Select Y-DNA CSV File"))
        if not file_path:
            self.set_text(_("No file selected."))
            return

        try:
            # Load the CSV file into a Pandas DataFrame
            self.data = pd.read_csv(file_path)
            # Validate columns
            required_columns = {"SNP", "STR", "Haplogroup"}
            missing_columns = required_columns - set(self.data.columns)
            if missing_columns:
                raise KeyError(f"Missing required columns: {', '.join(missing_columns)}")
            self.set_text(_("Data loaded successfully from {}").format(file_path))
        except FileNotFoundError:
            self.set_text(_("Error: File not found."))
        except KeyError as e:
            self.set_text(str(e))
            self.data = None
        except Exception as e:
            self.set_text(_("An error occurred: {}").format(e))

    def generate_scatter(self):
        """Generate a scatter plot for SNP vs STR."""
        if self.data is None:
            self.set_text(_("No data loaded. Please load Y-DNA data first."))
            return

        try:
            plt.figure(figsize=(10, 6))
            scatter = plt.scatter(
                self.data["SNP"], self.data["STR"],
                c=self.data["Haplogroup"].astype("category").cat.codes,
                cmap="viridis", alpha=0.7, edgecolor="k"
            )
            plt.title(_("SNP vs STR Scatter Plot"))
            plt.xlabel(_("SNP Variants"))
            plt.ylabel(_("STR Repeats"))
            plt.colorbar(scatter, label=_("Haplogroup (Encoded)"))
            plt.grid(True)
            plt.show()
            self.set_text(_("Scatter plot generated successfully."))
        except KeyError as e:
            self.set_text(_("Error: Missing required column - {}").format(e))
        except Exception as e:
            self.set_text(_("An error occurred: {}").format(e))

# Register the plugin in the Gramps Tools menu
menu.register_menu(f"Tools/{PLUGIN['name']}", YDNAAnalyzer)
