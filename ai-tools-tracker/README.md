# 🤖 AI Tools Tracker

[![Deploy Dashboard](https://github.com/Tnsr-Q/ai-new/actions/workflows/deploy.yml/badge.svg)](https://github.com/Tnsr-Q/ai-new/actions/workflows/deploy.yml)

A stunning **Cyberpunk Neon-themed** dashboard that tracks the hottest AI repositories on GitHub, automatically updated daily.

## 🚀 Features

- **🌟 Top 50 AI Repositories**: Displays the most starred AI/ML repositories from GitHub
- **🎨 Cyberpunk Neon Theme**: Dark background with neon colors, custom fonts, and glowing effects
- **⚡ Auto-Updated**: Refreshes daily at 8:00 AM ET via GitHub Actions
- **🔄 Live Data**: Fetches real-time data from GitHub API
- **📱 Responsive**: Works on desktop, tablet, and mobile devices
- **🔗 Direct Links**: Easy access to repositories and their READMEs
- **⭐ Star Counts**: Real-time star counts with formatted numbers

## 🎯 Live Dashboard

Visit the live dashboard: **[https://tnsr-q.github.io/ai-new/ai-tools-tracker/](https://tnsr-q.github.io/ai-new/ai-tools-tracker/)**

## 🛠️ Technology Stack

- **[Quarto](https://quarto.org/)**: Static site generator and dashboard framework
- **[R](https://www.r-project.org/)**: Data processing and GitHub API integration
  - `httr2`: HTTP client for GitHub API
  - `jsonlite`: JSON parsing
  - `dplyr`: Data manipulation
  - `purrr`: Functional programming utilities
- **[renv](https://rstudio.github.io/renv/)**: Reproducible R environment
- **Custom SCSS**: Cyberpunk Neon styling with:
  - [Orbitron](https://fonts.google.com/specimen/Orbitron): Futuristic headings
  - [Source Code Pro](https://fonts.google.com/specimen/Source+Code+Pro): Monospace code font
  - Neon glow effects and animations
- **GitHub Actions**: Automated daily deployment
- **GitHub Pages**: Static hosting

## 🎨 Theme Colors

- **Background**: Deep black with gradient overlays
- **Primary**: Neon Pink (#ff00ff)
- **Secondary**: Electric Purple (#8b00ff)
- **Accent**: Terminal Green (#00ff41)
- **Info**: Neon Blue (#00ffff)
- **Warning**: Neon Orange (#ff6600)

## 🔧 Local Development

### Prerequisites

- R (>= 4.3.0)
- Quarto (>= 1.4.0)
- Git

### Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Tnsr-Q/ai-new.git
   cd ai-new/ai-tools-tracker
   ```

2. **Install R dependencies**:
   ```r
   # In R console
   install.packages("renv")
   renv::restore()
   ```

3. **Render the dashboard**:
   ```bash
   quarto render
   ```

4. **Preview locally**:
   ```bash
   quarto preview
   ```

## 🚀 Deployment

The dashboard automatically deploys via GitHub Actions:

1. **Trigger**: Daily at 8:00 AM ET or on push to main branch
2. **Process**: 
   - Fetches latest AI repositories from GitHub API
   - Renders Quarto dashboard
   - Deploys to GitHub Pages
3. **URL**: `https://<username>.github.io/ai-new/ai-tools-tracker/`

### Manual Deployment

To trigger a manual deployment:

1. Go to **Actions** tab in GitHub
2. Select **Deploy AI Tools Tracker** workflow
3. Click **Run workflow**

## 📊 Data Source

- **GitHub API**: `https://api.github.com/search/repositories`
- **Query**: AI, machine learning, deep learning repositories
- **Sorting**: By star count (descending)
- **Languages**: Python, JavaScript, TypeScript, C++, Scala
- **Update Frequency**: Daily at 8:00 AM ET

## 🎭 Design Features

- **Animated Grid Background**: Moving circuit-like grid pattern
- **Neon Glow Effects**: Text and borders with glowing shadows
- **Hover Animations**: Interactive card effects
- **Responsive Layout**: Bootstrap-based responsive design
- **Custom Scrollbars**: Cyberpunk-themed scrollbar styling
- **Loading Fallbacks**: Graceful handling of API failures

## 📁 Project Structure

```
ai-tools-tracker/
├── .github/workflows/
│   └── deploy.yml          # GitHub Actions workflow
├── images/
│   └── neon-ai.svg         # Dashboard logo
├── _quarto.yml             # Quarto configuration
├── custom.scss             # Cyberpunk theme styles
├── index.qmd               # Main dashboard file
├── renv.lock               # R dependency lockfile
├── .gitignore              # Git ignore rules
└── README.md               # This file
```

## 🔄 Automation

The dashboard includes a complete CI/CD pipeline:

- **Scheduled Updates**: Cron job runs daily at 12:00 UTC (8:00 AM ET)
- **GitHub Actions**: Automated rendering and deployment
- **renv Integration**: Reproducible R environment
- **Error Handling**: Fallback data in case of API issues
- **Performance**: Optimized for fast loading and rendering

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally with `quarto render`
5. Submit a pull request

## 📄 License

MIT License - see LICENSE file for details.

## 🙏 Acknowledgments

- **GitHub API**: For providing repository data
- **Quarto Team**: For the amazing dashboard framework
- **R Community**: For excellent HTTP and data manipulation packages
- **Google Fonts**: For Orbitron and Source Code Pro fonts

---

<div align="center">

**🤖 Built with AI-powered automation • ⚡ Deployed via GitHub Actions • 🌟 Powered by GitHub API**

</div>