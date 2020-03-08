New-Variable -Name "AZURE_URL" -Visibility Public -Value "https://vstsagentpackage.azureedge.net/agent/2.165.0/vsts-agent-win-x64-2.165.0.zip" ; `
$AGENT_NAME = Read-Host -Prompt 'Input your agent name' ; `
Write-Host 'Downloading Agent' ; `
cd $HOME ; iwr -URI $AZURE_URL -Outfile $HOME\agent.zip ; Expand-Archive -LiteralPath $HOME\agent.zip -DestinationPath $HOME\$AGENT_NAME ; `
rm $HOME\agent.zip ; cd $HOME\$AGENT_NAME ; `
.\config.cmd --unattended --url https://dev.azure.com/ExampleCompany --auth pat --token YOUR_PAT_HERE --pool "Example Pool" --agent $AGENT_NAME --acceptTeeEula ; `
Write-Host 'Config done! Running Agent now' ; `
.\run.cmd
