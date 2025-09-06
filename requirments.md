
## System Requirements

### 1. Node.js (>= 16.0.0)
Required for running the main application and tools.

**Installation:**
```bash
# Using Node Version Manager (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 16
nvm use 16

# Or download from https://nodejs.org/
```

### 2. Git
Required for version control functionality in GitHub integration tools.

**Installation:**
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install git

# macOS (with Homebrew)
brew install git

# Windows
# Download from https://git-scm.com/download/win
```

### 3. Quarto
Required for rendering dashboards and websites. This is the primary external dependency.

**Installation:**
```bash
# macOS (with Homebrew)
brew install quarto

# Ubuntu/Debian
curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb
sudo gdebi quarto-linux-amd64.deb

# Windows
# Download installer from https://quarto.org/docs/get-started/

# Or using conda
conda install -c conda-forge quarto
```

### 4. R (>= 4.0.0)
Required for R-based data processing, visualization, and renv package management.

**Installation:**
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install r-base r-base-dev

# macOS (with Homebrew)
brew install r

# Windows
# Download from https://cran.r-project.org/bin/windows/base/

# Or using conda
conda install -c conda-forge r-base
```

## R Package Dependencies

The following R packages are used throughout the project:

### Core R Packages
```r
# Essential for Quarto
install.packages("knitr")
install.packages("rmarkdown")

# Package management
install.packages("renv")

# HTTP and API access
install.packages("httr2")

# Data manipulation and parsing
install.packages("jsonlite")
install.packages("dplyr")
install.packages("readr")

# Visualization
install.packages("ggplot2")
install.packages("plotly")

# Table creation
install.packages("gt")

# Additional utilities
install.packages("yaml")
install.packages("fs")
```

### Install All R Packages at Once
```r
# Run this in R console or RScript
required_packages <- c(
  "knitr",        # Essential for Quarto R integration
  "rmarkdown",    # Essential for Quarto R integration  
  "renv",
  "httr2", 
  "jsonlite",
  "dplyr",
  "readr",
  "ggplot2",
  "plotly",
  "gt",
  "yaml",
  "fs"
)

install.packages(required_packages)
```

## Node.js Dependencies

Node.js dependencies are managed via `package.json`:

```bash
# Install all Node.js dependencies
npm install
```

## Verification Commands

After installation, verify all dependencies are working:

```bash
# Check Node.js
node --version  # Should be >= 16.0.0

# Check npm
npm --version

# Check Git
git --version

# Check Quarto
quarto --version

# Check R
R --version

# Check R packages (run in R console)
R -e "library(renv); library(httr2); library(jsonlite); library(dplyr); library(ggplot2); library(plotly); library(gt); cat('All R packages loaded successfully\n')"
```

## Optional Dependencies

### For Development
- **TypeScript** (included in devDependencies)
- **ESLint** (included in devDependencies)
- **Jest** (included in devDependencies)

### For Enhanced Experience
- **VS Code** with Quarto extension
- **RStudio** for R development
- **GitHub CLI** for enhanced GitHub integration

## Platform-Specific Notes

### Ubuntu/Debian
```bash
# Install system dependencies for R packages
sudo apt-get install libcurl4-openssl-dev libssl-dev libxml2-dev
```

### macOS
```bash
# Install Xcode command line tools (if not already installed)
xcode-select --install
```

### Windows
- Ensure Rtools is installed for R package compilation
- Use Git Bash or WSL for better shell experience

## Docker Alternative

For a containerized environment, see `install-dependencies.sh` for a complete setup script.

## Troubleshooting

### Common Issues

1. **Quarto not found**: Ensure Quarto is in your PATH
2. **R packages fail to install**: Install system dependencies listed above
3. **Permission errors**: Use `sudo` on Linux/macOS or run as Administrator on Windows
4. **Node.js version conflicts**: Use nvm to manage Node.js versions

### Getting Help

- Quarto documentation: https://quarto.org/docs/
- R documentation: https://www.r-project.org/
- Node.js documentation: https://nodejs.org/docs/
