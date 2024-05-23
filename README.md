#   IDM Startup Trial Reset

###   Startup Trial Reset

---

 - This script uses the trial reset method every time you start your computer.

 - This method may require an Internet connection at the time of trial reset.

 - IDM updates can be installed directly as the trial reset initiates on every boot.

 - In case IDM nags you about registering, which it shouldn't, just run the `IAS.cmd` file in your Startup folder. It is recommended to keep that file pinned to your start menu for easier access.

<br>

####   OS requirement: Windows 7, 8, 8.1, 10 & 11

<br>

##   How to use it?

###   PowerShell (Windows 10/11)

---

Right-click on the windows start menu and run PowerShell as an Admin. It won't work with normal PowerShell.

Copy-paste the following code and press enter:

    iwr -useb https://naeembolchhi.github.io/IDM-Startup-Trial-Reset/startup.ps1 | iex

The script will automatically reset IDM trial and place the trial reset script in your Startup folder.

<br>

###   Manually Copying (Windows 7/8/8.1)

---

Download the file with ".cmd" extension from this repo.

Move this file to your Startup folder. Search online if you can't find your Startup folder.

Run the file once.

That's all.

<br>

###   Troubleshooting

---

   - If any other activator was used to activate IDM previously then make sure to properly uninstall it with that same activator (if there is an option), this is especially important if any registry/firewall block method was used.
     
     - If you're unable to properly remove the older IDM from everywhere (including registry), try using Revo Uninstaller Pro to scan and delete file and registry remnants.

   - Uninstall the IDM from the control panel.

   - Make sure the latest original IDM setup is used for the installation.
     
   - Download IDM: https://www.internetdownloadmanager.com/download.html

   - Now install the IDM and use the script again.
   
   - If failed then,

     - Disable the windows firewall with the script option, this helps in case of leftover entries of previously used activator (some file patch method also creates firewall entries).

     - Some security programs may block this script, this is false-positive, as long as you downloaded the file from the original post (mentioned below on this page), temporary suspend Antivirus real-time protection, or exclude the downloaded file/extracted folder from scanning.

     - If you are still facing any problems, please create an issue on this repo.

<br>

###   Credits

---

| **Dev** | **Contribution** |
|---|---|
| Dukun Cabul | Original researcher of this IDM trial reset and activation logic, made an Autoit tool for these methods, [IDM-AIO_2020_Final](https://nsaneforums.com/topic/371047-discussion-internet-download-manager-fixes/page/8/#comment-1632062) |
| AveYo aka BAU | [reg_own lean and mean snippet](https://pastebin.com/XTPt0JSC) |
| abbodi1406 | Help in coding |
| WindowsAddict | IAS Author |
| NaeemBolchhi | Minor fork to perpetually reset the 30-day trial period |
