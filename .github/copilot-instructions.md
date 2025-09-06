
You are an autonomous Quarto-dashboard DevOps agent.
Your ONLY outputs are the JSON-RPC-style tool calls below—no prose, no warnings, no markdown.
Execute the following plan step-by-step; wait for my “OK” after each tool result before continuing.
GOAL: create a fully-hosted, self-updating “AI-Tools-Tracker” dashboard that
•  lists the newest 50 trending AI repos on GitHub (updated daily at 08:00 ET)
•  lets the user pick any repo from a dropdown to embed its README as an iframe
•  uses an AI-generated “Cyberpunk Neon” theme
•  lives at https://<username>.github.io/ai-tools-tracker/
•  is reproducible (renv) and CI-refreshes automatically
Step-by-step instructions (insert real values when you reach them):
1.  quarto_create_project_with_renv_and_git
project_directory_name: “ai-tools-tracker”, create_git_repo: true, use_renv: true
2.  r_package_renv_install_package
package_name: “httr2”
3.  r_package_renv_install_package
package_name: “jsonlite”
4.  r_package_renv_install_package
package_name: “dplyr”
5.  r_package_renv_snapshot
6.  openai_generate_theme_recommendations
api_key: “${OPENAI_API_KEY}”, user_theme_input: “Cyberpunk Neon with dark blues, hot pinks and terminal green”, output_format: “JSON”
7.  quarto_generate_custom_scss
target_folder: “ai-tools-tracker”, font_family: <font from step-6>, primary_color: <primary>, secondary_color: <secondary>, accent_color: <accent>
8.  quarto_define_dashboard_format
qmd_file_path: “ai-tools-tracker/index.qmd”, format_type: “dashboard”
9.  quarto_define_dashboard_layout
qmd_file_path: “ai-tools-tracker/index.qmd”, orientation: “columns”, layout_structure: {“columns":[{"width":12,"rows":[{"height":1},{"height":4}]}]}
10.  quarto_add_dashboard_logo
qmd_file_path: “ai-tools-tracker/index.qmd”, logo_image_path: “images/neon-ai.png”
11.  openai_generate_image
api_key: “${OPENAI_API_KEY}”, prompt: “futuristic neon brain circuit logo on dark background, 512x512”, output_file_path: “ai-tools-tracker/images/neon-ai.png”
12.  Create inside ai-tools-tracker/ the chunk file fetch_github.R with contents
library(httr2)
library(jsonlite)
library(dplyr)
res <- request("https://api.github.com/search/repositories") %>%
  req_url_query(q = "AI language:python", sort = "updated", per_page = 50) %>%
  req_perform() %>%
  resp_body_json()
ai_repos <- res$items %>% select(full_name, html_url, description, stargazers_count)
ojs_define(ai_repos)

13.  quarto_define_ojs_chunk
ojs_code_content: '
viewof repo_select = Inputs.select(ai_repos.map(d => d.full_name), {label: "Pick a repo", unique: true})
const readme_url = https://raw.githubusercontent.com/${repo_select}/main/README.md
'
chunk_options: “echo: false”
14.  Append to index.qmd (after the OJS chunk) the markdown:
## README Preview
<iframe src="${readme_url}" width="100%" height="600px" style="border:none;"></iframe>

15.  quarto_configure_site_yml
quarto_yml_path: “ai-tools-tracker/_quarto.yml”, project_type: “website”, output_dir: “_site”, navigation_type: “navbar”, pages_list: [“index.qmd”], theme_config: “[cosmo, custom.scss]”
16.  quarto_create_gitignore
target_folder: “ai-tools-tracker”, gitignore_content: “.Rproj.user\n.Rhistory\n.RData\n.Ruserdata\nRenviron\n.quarto/\n_site/\n*Files/\nrenv/library/\n.DS_Store”
17.  github_create_repository
repository_name: “ai-tools-tracker”, visibility: “public”
18.  git_push_project
local_project_path: “ai-tools-tracker”, github_repo_url: “https://github.com/<YOUR_GITHUB_USERNAME>/ai-tools-tracker.git”
19.  github_actions_create_secret
repository_name: “ai-tools-tracker”, secret_name: “OPENAI_API_KEY”, secret_value: “<paste your key>”
20.  github_actions_configure_publishing_workflow
workflow_file_path: “ai-tools-tracker/.github/workflows/publish.yml” (let the tool generate default content)
21.  chatgpt_generate_cron_expression
natural_language_time_description: “every day at 8 AM”, time_zone: “Eastern Daylight Time”
22.  github_actions_schedule_workflow
workflow_yml_path: “ai-tools-tracker/.github/workflows/publish.yml”, cron_expression: <result from 21>
23.  github_create_gh_pages_branch
repository_name: “ai-tools-tracker”
24.  github_pages_configure_deployment_source
repository_name: “ai-tools-tracker”, branch_name: “gh-pages”
25.  quarto_render_local
qmd_file_path: “ai-tools-tracker/index.qmd”

user your MCP's 
{
  "mcpServers": {
    "quarto-webr": {
      "type": "sse",
      "url": "https://gitmcp.io/coatless/quarto-webr",
      "tools": ["*"]
    },
    "quarto-actions": {
      "type": "sse",
      "url": "https://gitmcp.io/quarto-dev/quarto-actions",
      "tools": ["*"]
    },
    "quarto-web": {
      "type": "sse", 
      "url": "https://gitmcp.io/quarto-dev/quarto-web",
      "tools": ["*"]
    },
    "copilot-quarto": {
      "type": "sse",
      "url": "https://gitmcp.io/Tnsr-Q/copilot-quarto",
      "tools": ["*"]
    }
  }
}
