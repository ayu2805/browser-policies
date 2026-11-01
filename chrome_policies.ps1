$ChromePolicyPath = "HKLM:\SOFTWARE\Policies\Google\Chrome"

New-Item -Path $ChromePolicyPath -Force | Out-Null

function Set-ChromeDword {
    param (
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [int]$Value
    )

    New-ItemProperty `
        -Path $ChromePolicyPath `
        -Name $Name `
        -PropertyType DWord `
        -Value $Value `
        -Force | Out-Null
}

function Set-ChromeString {
    param (
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Value
    )

    New-ItemProperty `
        -Path $ChromePolicyPath `
        -Name $Name `
        -PropertyType String `
        -Value $Value `
        -Force | Out-Null
}

Set-ChromeDword -Name "AIModeSettings" -Value 1
Set-ChromeDword -Name "AutofillGenAiSettings" -Value 2

$autofillSettings = ConvertTo-Json @(
    @{
        blocked_types = @("all")
        url_pattern  = "*"
    }
) -Compress
Set-ChromeString -Name "AutofillSettings" -Value $autofillSettings

Set-ChromeDword -Name "BackgroundModeEnabled" -Value 0
Set-ChromeDword -Name "BlockThirdPartyCookies" -Value 1
Set-ChromeDword -Name "ChromeSuggestionsSettings" -Value 1

$clearBrowsingDataOnExitList = ConvertTo-Json @(
    "browsing_history",
    "download_history",
    "cached_images_and_files",
    "password_signin",
    "autofill",
    "site_settings",
    "hosted_app_data"
) -Compress
Set-ChromeString -Name "ClearBrowsingDataOnExitList" -Value $clearBrowsingDataOnExitList

$cookiesAllowedForUrls = ConvertTo-Json @(
    "accounts.google.com",
    "github.com",
    "sso.crunchyroll.com",
    "web.whatsapp.com"
) -Compress
Set-ChromeString -Name "CookiesAllowedForUrls" -Value $cookiesAllowedForUrls

Set-ChromeDword -Name "CreateThemesSettings" -Value 2
Set-ChromeDword -Name "DefaultAutomaticDownloadsSetting" -Value 1
Set-ChromeDword -Name "DefaultCookiesSetting" -Value 4
Set-ChromeDword -Name "DefaultGeolocationSetting" -Value 2
Set-ChromeDword -Name "DefaultIdleDetectionSetting" -Value 2
Set-ChromeDword -Name "DefaultNotificationsSetting" -Value 2
Set-ChromeDword -Name "DefaultSearchProviderEnabled" -Value 1
Set-ChromeString -Name "DefaultSearchProviderName" -Value "DuckDuckGo",
Set-ChromeString -Name "DefaultSearchProviderSearchURL" -Value "https://duckduckgo.com/?q={searchTerms}"
Set-ChromeDword -Name "DevToolsGenAiSettings" -Value 2
Set-ChromeString -Name "DnsOverHttpsMode" -Value "secure"
Set-ChromeString -Name "DnsOverHttpsTemplates" -Value "https://cloudflare-dns.com/dns-query"
Set-ChromeDword -Name "GeminiActOnWebSettings" -Value 1
Set-ChromeDword -Name "GeminiSettings" -Value 1
Set-ChromeDword -Name "GeminiSparkSettings" -Value 1
Set-ChromeDword -Name "GenAILocalFoundationalModelSettings" -Value 1
Set-ChromeDword -Name "HelpMeWriteSettings" -Value 2
Set-ChromeDword -Name "HighEfficiencyModeEnabled" -Value 0
Set-ChromeDword -Name "HistorySearchSettings" -Value 2
Set-ChromeString -Name "HomepageLocation" -Value "chrome://new-tab-page"
Set-ChromeString -Name "HttpsOnlyMode" -Value "force_balanced_enabled"
Set-ChromeDword -Name "NTPCardsVisible" -Value 0
Set-ChromeString -Name "NewTabPageLocation" -Value "chrome://new-tab-page"
Set-ChromeDword -Name "PasswordLeakDetectionEnabled" -Value 0
Set-ChromeDword -Name "PasswordManagerEnabled" -Value 0
Set-ChromeDword -Name "PaymentMethodQueryEnabled" -Value 0
Set-ChromeDword -Name "PromotionsEnabled" -Value 0
Set-ChromeDword -Name "RestoreOnStartup" -Value 5
Set-ChromeDword -Name "SafeBrowsingProtectionLevel" -Value 0
Set-ChromeDword -Name "SearchContentSharingSettings" -Value 1
Set-ChromeDword -Name "SearchSuggestEnabled" -Value 0
Set-ChromeDword -Name "SmartTabSharingSettings" -Value 1

$syncTypesList = ConvertTo-Json @(
    "apps",
    "autofill",
    "bookmarks",
    "extensions",
    "preferences",
    "passwords",
    "payments",
    "productComparison",
    "readingList",
    "tabs",
    "themes",
    "typedUrls",
    "wifiConfigurations"
) -Compress
Set-ChromeString -Name "SyncTypesListDisabled" -Value $syncTypesList

Set-ChromeDword -Name "TabCompareSettings" -Value 2
Set-ChromeDword -Name "ThirdPartyAiChatSettings" -Value 1
Set-ChromeDword -Name "TryOnYouSettings" -Value 2
Set-ChromeDword -Name "VoiceTypingSettings" -Value 2

Write-Host "Chrome policies have been applied successfully." -ForegroundColor Green
Write-Host "Restart Chrome, then check chrome://policy." -ForegroundColor Yellow
