$ProgressPreference = "SilentlyContinue"
$FirefoxInstallationPath = (Get-Item 'HKLM:\SOFTWARE\Mozilla\Firefox\TaskBarIDs').GetValueNames() | Select-Object -First 1

$AutoconfigDestination = Join-Path $FirefoxInstallationPath 'defaults\pref\autoconfig.js'
Invoke-WebRequest `
    -Uri 'https://raw.githubusercontent.com/ayu2805/browser-policies/main/firefox_autoconfig.js' `
    -OutFile $AutoconfigDestination `
    -ErrorAction Stop

$PreferencesDestination = Join-Path $FirefoxInstallationPath 'firefox_pref.cfg'
Invoke-WebRequest `
    -Uri 'https://raw.githubusercontent.com/ayu2805/browser-policies/main/firefox_preferences.cfg' `
    -OutFile $PreferencesDestination `
    -ErrorAction Stop

$FirefoxPolicyPath = "HKLM:\SOFTWARE\Policies\Mozilla\Firefox"

New-Item -Path $FirefoxPolicyPath -Force | Out-Null

function Set-FirefoxPolicy {
    param (
        [string]$Path = $FirefoxPolicyPath,

        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [object]$Value
    )

    if ($Value -is [string]) {
        $propertyType = 'String'
    }
    elseif ($Value -is [int]) {
        $propertyType = 'DWord'
    }

    New-ItemProperty `
        -Path $Path `
        -Name $Name `
        -PropertyType $propertyType `
        -Value $Value `
        -Force | Out-Null
}

$AIControlsDefault = Join-Path $FirefoxPolicyPath "AIControls\Default"
New-Item -Path $AIControlsDefault -Force | Out-Null
Set-FirefoxPolicy -Path $AIControlsDefault -Name "Locked" -Value 1
Set-FirefoxPolicy -Path $AIControlsDefault -Name "Value" -Value 'blocked'
$AIControlsTranslations = Join-Path $FirefoxPolicyPath "AIControls\Translations"
New-Item -Path $AIControlsTranslations -Force | Out-Null
Set-FirefoxPolicy -Path $AIControlsTranslations -Name "Locked" -Value 1
Set-FirefoxPolicy -Path $AIControlsTranslations -Name "Value" -Value 'available'

$ClearOnShutdown = Join-Path $FirefoxPolicyPath "ClearOnShutdown"
New-Item -Path $ClearOnShutdown -Force | Out-Null
Set-FirefoxPolicy -Path $ClearOnShutdown -Name "BrowsingHistoryAndDownloads" -Value 1
Set-FirefoxPolicy -Path $ClearOnShutdown -Name "Cache" -Value 1
Set-FirefoxPolicy -Path $ClearOnShutdown -Name "CookiesAndStorage" -Value 1
$ClearOnShutdownExceptions = Join-Path $ClearOnShutdown "Exceptions"
New-Item -Path $ClearOnShutdownExceptions -Force | Out-Null
Set-FirefoxPolicy -Path $ClearOnShutdownExceptions -Name "1" -Value "https://accounts.google.com"
Set-FirefoxPolicy -Path $ClearOnShutdownExceptions -Name "2" -Value "https://github.com"
Set-FirefoxPolicy -Path $ClearOnShutdownExceptions -Name "3" -Value "https://sso.crunchyroll.com"
Set-FirefoxPolicy -Path $ClearOnShutdownExceptions -Name "4" -Value "https://web.whatsapp.com"
Set-FirefoxPolicy -Path $ClearOnShutdownExceptions -Name "5" -Value "https://youtube.com"
Set-FirefoxPolicy -Path $ClearOnShutdown -Name "FormData" -Value 1
Set-FirefoxPolicy -Path $ClearOnShutdown -Name "SiteSettings" -Value 1

$Cookies= Join-Path $FirefoxPolicyPath "Cookies"
New-Item -Path $Cookies -Force | Out-Null
Set-FirefoxPolicy -Path $Cookies -Name "Locked" -Value 1
Set-FirefoxPolicy -Path $Cookies -Name "Behavior" -Value "reject-foreign"
Set-FirefoxPolicy -Path $Cookies -Name "BehaviorPrivateBrowsing" -Value "reject-foreign"

Set-FirefoxPolicy -Name "DisableFeedbackCommands" -Value 1
Set-FirefoxPolicy -Name "DisableFirefoxStudies" -Value 1
Set-FirefoxPolicy -Name "DisableMasterPasswordCreation" -Value 1
Set-FirefoxPolicy -Name "DisableProfileImport" -Value 1
Set-FirefoxPolicy -Name "DisableRemoteImprovements" -Value 1
Set-FirefoxPolicy -Name "DisableSetDesktopBackground" -Value 1
Set-FirefoxPolicy -Name "DisableTelemetry" -Value 1

$EnableTrackingProtection = Join-Path $FirefoxPolicyPath "EnableTrackingProtection"
New-Item -Path $EnableTrackingProtection -Force | Out-Null
Set-FirefoxPolicy -Path $EnableTrackingProtection -Name "Category" -Value "strict"
Set-FirefoxPolicy -Path $EnableTrackingProtection -Name "Locked" -Value 1
Set-FirefoxPolicy -Path $EnableTrackingProtection -Name "Value" -Value 1

$uBlockOrigin = Join-Path $FirefoxPolicyPath "ExtensionSettings\uBlock0@raymondhill.net"
New-Item -Path $uBlockOrigin -Force | Out-Null
Set-FirefoxPolicy -Path $uBlockOrigin -Name "installation_mode" -Value "force_installed"
Set-FirefoxPolicy -Path $uBlockOrigin -Name "private_browsing" -Value 1

Set-FirefoxPolicy -Name "NoDefaultBookmarks" -Value 1
Set-FirefoxPolicy -Name "PasswordManagerEnabled" -Value 0

$SearchEngines = Join-Path $FirefoxPolicyPath "SearchEngines"
$SearchEnginesAdd = Join-Path $SearchEngines "Add\1"
New-Item -Path $SearchEnginesAdd -Force | Out-Null
Set-FirefoxPolicy -Path $SearchEnginesAdd -Name "Name" -Value "DuckDuckGo"
Set-FirefoxPolicy -Path $SearchEnginesAdd -Name "URLTemplate" -Value "https://duckduckgo.com/?q={searchTerms}"
Set-FirefoxPolicy -Path $SearchEngines -Name "Default" -Value "DuckDuckGo"
Set-FirefoxPolicy -Path $SearchEngines -Name "PreventInstalls" -Value 1
$SearchEnginesRemove = Join-Path $SearchEngines "Remove"
New-Item -Path $SearchEnginesRemove -Force | Out-Null
Set-FirefoxPolicy -Path $SearchEnginesRemove -Name "1" -Value "Bing"
Set-FirefoxPolicy -Path $SearchEnginesRemove -Name "2" -Value "Perplexity"
Set-FirefoxPolicy -Path $SearchEnginesRemove -Name "3" -Value "Wikipedia (en)"

Set-FirefoxPolicy -Name "SkipTermsOfUse" -Value 1

$UserMessaging = Join-Path $FirefoxPolicyPath "UserMessaging"
New-Item -Path $UserMessaging -Force | Out-Null
Set-FirefoxPolicy -Path $UserMessaging -Name "ExtensionRecommendations" -Value 0
Set-FirefoxPolicy -Path $UserMessaging -Name "FeatureRecommendations" -Value 0
Set-FirefoxPolicy -Path $UserMessaging -Name "FirefoxLabs" -Value 0
Set-FirefoxPolicy -Path $UserMessaging -Name "Locked" -Value 1
Set-FirefoxPolicy -Path $UserMessaging -Name "MoreFromMozilla" -Value 0