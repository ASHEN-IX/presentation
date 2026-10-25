# Copies the pitch assets next to index.html so the deck works fully offline.
$S = "C:\Users\amina\AppData\Local\Temp\claude\d--SAAS-Challenge\4e9e2126-ed29-4c8b-b209-f955b01707a3\scratchpad"
$P = "D:\SAAS Challenge\pitch\assets"
$R = "D:\SAAS Challenge\demo-raw"
$F = "$S\pylib\imageio_ffmpeg\binaries\ffmpeg-win-x86_64-v7.1.exe"

New-Item -ItemType Directory -Force "$P\fonts" | Out-Null
Copy-Item "$S\video\fonts\*.ttf" "$P\fonts\"
Copy-Item "$S\brand\logo-full.png", "$S\brand\logo-mark.png", "$S\brand\fankouch-thinking.webp", "$S\brand\fankouch-exploring.webp" $P
Copy-Item "D:\SAAS Challenge\demo-final\missionlab-demo-fankouch-90s.mp4" "$P\demo.mp4"

# Real product frames taken from the gameplay recordings
$shots = @(
  @("04-red-storm.webm", 30, "habitat"),
  @("04-red-storm.webm", 95, "redstorm"),
  @("10-pressure-drop-full.webm", 198, "pressure"),
  @("07-silent-air.webm", 120, "silentair"),
  @("09-teacher.webm", 6, "teacher")
)
foreach ($s in $shots) {
  & $F -hide_banner -loglevel error -y -ss $s[1] -i "$R\$($s[0])" -frames:v 1 -q:v 3 "$P\$($s[2]).jpg"
}
Get-ChildItem $P -Recurse | Select-Object Name, Length
