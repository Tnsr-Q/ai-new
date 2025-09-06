#!/bin/bash

# Fairlight Copilot-Quarto Dependencies Installation Script
# This script installs all required dependencies for the project

set -e  # Exit on any error

echo "🚀 Installing ai-new Dependencies..."
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect operating system
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    OS="windows"
fi

print_status "Detected OS: $OS"

# Check if running as root (not recommended)
if [[ $EUID -eq 0 ]]; then
    print_warning "Running as root. This may cause permission issues."
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Node.js if not present
install_nodejs() {
    print_status "Checking Node.js installation..."
    
    if command_exists node; then
        NODE_VERSION=$(node --version | cut -d'v' -f2)
        REQUIRED_VERSION="16.0.0"
        
        if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$NODE_VERSION" | sort -V | head -n1)" = "$REQUIRED_VERSION" ]; then
            print_success "Node.js $NODE_VERSION is already installed and meets requirements"
            return 0
        else
            print_warning "Node.js $NODE_VERSION is installed but version >= 16.0.0 is required"
        fi
    fi
    
    print_status "Installing Node.js..."
    
    if [[ "$OS" == "linux" ]]; then
        # Use NodeSource repository for latest Node.js
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt-get install -y nodejs
    elif [[ "$OS" == "macos" ]]; then
        if command_exists brew; then
            brew install node
        else
            print_error "Homebrew not found. Please install Homebrew first or install Node.js manually"
            return 1
        fi
    else
        print_error "Please install Node.js manually from https://nodejs.org/"
        return 1
    fi
    
    print_success "Node.js installed successfully"
}

# Function to install Git if not present
install_git() {
    print_status "Checking Git installation..."
    
    if command_exists git; then
        print_success "Git is already installed"
        return 0
    fi
    
    print_status "Installing Git..."
    
    if [[ "$OS" == "linux" ]]; then
        sudo apt-get update
        sudo apt-get install -y git
    elif [[ "$OS" == "macos" ]]; then
        if command_exists brew; then
            brew install git
        else
            print_error "Homebrew not found. Please install Git manually or install Homebrew first"
            return 1
        fi
    else
        print_error "Please install Git manually from https://git-scm.com/"
        return 1
    fi
    
    print_success "Git installed successfully"
}

# Function to install R
install_r() {
    print_status "Checking R installation..."
    
    if command_exists R; then
        print_success "R is already installed"
        return 0
    fi
    
    print_status "Installing R..."
    
    if [[ "$OS" == "linux" ]]; then
        sudo apt-get update
        sudo apt-get install -y r-base r-base-dev
        
        # Install system dependencies for R packages
        sudo apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev
    elif [[ "$OS" == "macos" ]]; then
        if command_exists brew; then
            brew install r
        else
            print_error "Homebrew not found. Please install R manually or install Homebrew first"
            return 1
        fi
    else
        print_error "Please install R manually from https://cran.r-project.org/"
        return 1
    fi
    
    print_success "R installed successfully"
}

# Function to install Quarto
install_quarto() {
    print_status "Checking Quarto installation..."
    
    if command_exists quarto; then
        print_success "Quarto is already installed"
        return 0
    fi
    
    print_status "Installing Quarto..."
    
    if [[ "$OS" == "linux" ]]; then
        # Download and install Quarto for Linux
        QUARTO_VERSION="1.4.550"  # Update this to latest version as needed
        wget -q "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb"
        sudo dpkg -i "quarto-${QUARTO_VERSION}-linux-amd64.deb"
        rm "quarto-${QUARTO_VERSION}-linux-amd64.deb"
    elif [[ "$OS" == "macos" ]]; then
        if command_exists brew; then
            brew install quarto
        else
            print_error "Homebrew not found. Please install Quarto manually or install Homebrew first"
            return 1
        fi
    else
        print_error "Please install Quarto manually from https://quarto.org/"
        return 1
    fi
    
    print_success "Quarto installed successfully"
}

# Function to install R packages
install_r_packages() {
    print_status "Installing R packages..."
    
    if ! command_exists R; then
        print_error "R is not installed. Cannot install R packages."
        return 1
    fi
    
    # Create user library directory if it doesn't exist
    R_USER_LIB=$(R --slave -e "cat(Sys.getenv('R_LIBS_USER'))")
    if [[ ! -d "$R_USER_LIB" ]]; then
        print_status "Creating R user library directory: $R_USER_LIB"
        mkdir -p "$R_USER_LIB"
    fi
    
    # Create R script for package installation
    R_SCRIPT=$(cat <<'EOF'
# Required R packages for Fairlight Copilot-Quarto
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

cat("Installing R packages...\n")

# Ensure user library exists and is first in .libPaths()
user_lib <- Sys.getenv("R_LIBS_USER")
if (!dir.exists(user_lib)) {
  dir.create(user_lib, recursive = TRUE)
}
.libPaths(c(user_lib, .libPaths()))

cat(paste("Using library:", .libPaths()[1], "\n"))

# Install packages that are not already installed
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(paste("Installing", pkg, "...\n"))
    tryCatch({
      install.packages(pkg, dependencies = TRUE, repos = "https://cran.rstudio.com/", lib = .libPaths()[1])
    }, error = function(e) {
      cat(paste("Error installing", pkg, ":", e$message, "\n"))
    })
  } else {
    cat(paste(pkg, "is already installed\n"))
  }
}

# Verify all packages can be loaded
cat("\nVerifying package installation...\n")
for (pkg in required_packages) {
  if (require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(paste("✓", pkg, "\n"))
  } else {
    cat(paste("✗", pkg, "- FAILED TO LOAD\n"))
  }
}

cat("\nR package installation complete!\n")
EOF
)
    
    echo "$R_SCRIPT" | R --slave
    
    # Note about potential network issues
    if [ $? -ne 0 ]; then
        print_warning "R package installation may have encountered network issues."
        print_status "This is common in restricted environments. Packages can be installed manually later with:"
        print_status "R -e \"install.packages(c('knitr', 'rmarkdown', 'renv', 'httr2', 'jsonlite', 'dplyr', 'ggplot2', 'plotly', 'gt', 'yaml', 'fs'))\""
    fi
    
    print_success "R packages installation completed"
}

# Function to install Node.js dependencies
install_npm_dependencies() {
    print_status "Installing Node.js dependencies..."
    
    if [[ ! -f "package.json" ]]; then
        print_error "package.json not found. Make sure you're in the project root directory."
        return 1
    fi
    
    npm install
    
    print_success "Node.js dependencies installed successfully"
}

# Function to verify installation
verify_installation() {
    print_status "Verifying installation..."
    echo
    
    local all_good=true
    
    # Check Node.js
    if command_exists node; then
        NODE_VERSION=$(node --version)
        print_success "Node.js: $NODE_VERSION"
    else
        print_error "Node.js: Not found"
        all_good=false
    fi
    
    # Check npm
    if command_exists npm; then
        NPM_VERSION=$(npm --version)
        print_success "npm: $NPM_VERSION"
    else
        print_error "npm: Not found"
        all_good=false
    fi
    
    # Check Git
    if command_exists git; then
        GIT_VERSION=$(git --version)
        print_success "Git: $GIT_VERSION"
    else
        print_error "Git: Not found"
        all_good=false
    fi
    
    # Check R
    if command_exists R; then
        R_VERSION=$(R --version | head -n1)
        print_success "R: $R_VERSION"
    else
        print_error "R: Not found"
        all_good=false
    fi
    
    # Check Quarto
    if command_exists quarto; then
        QUARTO_VERSION=$(quarto --version)
        print_success "Quarto: $QUARTO_VERSION"
    else
        print_error "Quarto: Not found"
        all_good=false
    fi
    
    echo
    
    if $all_good; then
        print_success "🎉 All dependencies installed successfully!"
        echo
        print_status "You can now run the following commands:"
        echo "  npm start    - Run the application"
        echo "  npm test     - Run tests"
        echo "  npm run demo - Run AI Tools Tracker demo"
        echo
        print_status "For Quarto projects:"
        echo "  quarto render  - Build projects"
        echo "  quarto preview - Preview projects"
    else
        print_error "❌ Some dependencies failed to install. Please check the errors above."
        return 1
    fi
}

# Main installation function
main() {
    echo
    print_status "Starting dependency installation..."
    echo
    
    # Install system dependencies
    install_nodejs || { print_error "Failed to install Node.js"; exit 1; }
    install_git || { print_error "Failed to install Git"; exit 1; }
    install_r || { print_error "Failed to install R"; exit 1; }
    install_quarto || { print_error "Failed to install Quarto"; exit 1; }
    
    echo
    print_status "Installing package dependencies..."
    echo
    
    # Install package dependencies
    install_r_packages || { print_error "Failed to install R packages"; exit 1; }
    install_npm_dependencies || { print_error "Failed to install Node.js dependencies"; exit 1; }
    
    echo
    verify_installation
}

# Script options
case "${1:-install}" in
    install)
        main
        ;;
    verify)
        verify_installation
        ;;
    nodejs)
        install_nodejs
        ;;
    git)
        install_git
        ;;
    r)
        install_r
        ;;
    quarto)
        install_quarto
        ;;
    r-packages)
        install_r_packages
        ;;
    npm)
        install_npm_dependencies
        ;;
    --help|-h)
        echo "Usage: $0 [command]"
        echo
        echo "Commands:"
        echo "  install     - Install all dependencies (default)"
        echo "  verify      - Verify all dependencies are installed"
        echo "  nodejs      - Install Node.js only"
        echo "  git         - Install Git only"
        echo "  r           - Install R only"
        echo "  quarto      - Install Quarto only"
        echo "  r-packages  - Install R packages only"
        echo "  npm         - Install npm dependencies only"
        echo "  --help, -h  - Show this help message"
        ;;
    *)
        print_error "Unknown command: $1"
        echo "Use '$0 --help' for usage information"
        exit 1
        ;;
esac
