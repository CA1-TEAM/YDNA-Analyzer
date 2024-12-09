YDNA-Analyzer
Overview
The YDNA-Analyzer is a standalone Python tool for analyzing Y-DNA data. It allows users to visualize Y-DNA patterns through scatter plots, providing insights into genealogical connections, haplogroup trends, and DNA relationships.

Features
Scatter Plots: Visualize SNP vs. STR data with color-coded haplogroups.
Standalone Tool: Does not require Gramps or any other software dependencies.
Easy to Use: Load Y-DNA data from a CSV file and analyze it with simple commands.
Installation
To use the YDNA-Analyzer, follow these steps:

Download the Tool:

Visit the YDNA-Analyzer GitHub repository.
Click the green Code button and select Download ZIP.
Extract the Files:

Unzip the downloaded file to access the tool files.
Install Dependencies:

Open a terminal or command prompt.
Navigate to the extracted folder and install the required Python libraries:
pip install pandas matplotlib
Usage
Follow these steps to analyze your Y-DNA data:

Prepare Your Data:

Create a CSV file containing your Y-DNA data with the following structure:
SNP,STR,Haplogroup
12,20,A
15,23,B
17,22,A
14,25,C
16,21,B
Run the Tool:

Open a terminal or command prompt.
Navigate to the directory containing the ydna_analyzer.py file.
Run the script:
python ydna_analyzer.py
Provide the Path to Your CSV File:

When prompted, enter the path to your Y-DNA CSV file.
Example:
Enter the path to your Y-DNA CSV file: test_data.csv
View the Results:

A scatter plot will be generated, showing SNP (x-axis) vs. STR (y-axis) with haplogroups color-coded.
Requirements
Python 3.6 or Later: Ensure Python is installed on your system. Download it from python.org.
Dependencies:
pandas: For data manipulation.
matplotlib: For data visualization.
Contributing
Contributions are welcome! To contribute:

Fork the repository on GitHub.
Create a new branch for your feature or bug fix.
Commit your changes with clear messages.
Submit a pull request with a detailed description of your changes.
License
This project is licensed under the MIT License. See the LICENSE file for more details.

Support
If you encounter any issues or have questions, please open an issue on the GitHub repository.

YDNA-Analyzer is designed to make Y-DNA analysis easier and more accessible for genealogical researchers. Whether you’re uncovering ancestral connections or analyzing DNA patterns, this tool provides powerful features to support your journey.
