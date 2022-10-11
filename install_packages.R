your_platform <- "mac_arm" # Bitte eines der vier eintragen: mac, mac_arm, linux or windows

if (your_platform=="mac"){
  install_type <- "mac.binary"
  options(install.packages.check.source = "no")
} else if (your_platform=="mac_arm"){
    install_type <- "binary"
    options(install.packages.check.source = "yes")
} else if (your_platform=="windows"){
  install_type <- "win.binary"
  options(install.packages.check.source = "no")
} else if (your_platform=="linux"){
  install_type <- "source"
  options(install.packages.check.source = "yes")
} else{
  stop(
    paste0(
      "Für deine verwendetes Betriebssystem musst nur eines der ",
      "folgenden Werte eintragen: 'mac', 'linux' or 'windows', ",
      "aber nicht wie von dir '", your_platform, "'!"))
}

here_installed <- require("here")

if (isFALSE(here_installed)){
  install.packages("here", type = install_type)
} 

here_installed <- require("here")

if (isFALSE(here_installed)){
  cat(paste0(
    "ACHTUNG! Das wichtige Paket 'here' konnte nicht installiert werden!\n",
    "Bitte führe folgenden Befehl aus und mach einen Screenshot von der ",
    "resultierenden Fehlermelung: \n",
    "install.packages('here')\n",
    "Schicke den Screenshot dann bitte per Mail an Claudius Gräbner und ",
    "Axel Dockhorn, damit wir dir optimal weiterhelfen können. Vielen Dank!"))
} else {
  cat("Sehr gut, das here-Paket ist erfolgreich installiert!")
}

required_packages <- c(
  "AER",
  "countrycode",
  "data.table",
  "fitdistrplus",
  "gapminder",
  "ggpubr",
  "ggrepel",
  "haven",
  "ineq",
  "latex2exp",
  "lmtest",
  "MASS",
  "matlib",
  "moments",
  "optimx",
  "rmarkdown",
  "rmutil",
  "R.utils",
  "sandwich",
  "scales",
  "texreg",
  "tidyverse",
  "tinytex",
  "tufte",
  "viridis",
  "WDI"
)

for (i in 1:length(required_packages)){
  package_name <- required_packages[i]
  print(package_name)
  install.packages(package_name, type = install_type)
}

package_status_list <- list()
for (i in 1:length(required_packages)){
  package_name <- required_packages[i]
  print(package_name)
  package_installed <- require(package_name, 
                               character.only = T)
  status_frame <- data.frame(package=package_name, 
                             status=package_installed)
  package_status_list[[i]] <- status_frame
}

paket_log <- do.call("rbind", package_status_list)

log_path <- here::here("Installationslogbuch.txt")
write.table(x = paket_log, file = log_path, row.names = FALSE)

package_status_vector <- paket_log[["status"]]

if (sum(package_status_vector)==length(package_status_vector)){
  print("Super! Alle relevanten Pakete wurden erfolgreich installiert!")
} else{
  cat(paste0(
    "ACHTUNG! Manche Pakete haben einen Fehler verursacht!\n",
    "Bitte schaue in die Datei 'Installationslogbuch.txt'.",  
    "Sie wurde in folgender Datei gespeichert: \n",
    log_path, "\n",
    "Falls in dieser Datei nur bei wenigen Paketen ein 'FALSE' vermerkt ist, ",
    "versuche bitte diese Pakete einzeln zu installieren und mache einen ",
    "Screenshot mit der Fehlermeldung. \nSchicke dann das Logbuch und die ",
    "Screenshots an Claudius Gräbner und Axel Dockhorn, damit wir dir ",
    "optimal weiterhelfen können. Vielen Dank!"))
}
