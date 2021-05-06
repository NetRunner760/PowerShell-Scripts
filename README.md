# PowerShell-Utilities

These are all scripts I've put together to make myself as efficient as possible in my current role as a Desktop Technician.

My current format imports a corresponding "Master Functions" script that contains all the needed functions to execute the main script. The file path in the main script must match the location of the Master Functions script otherwise it will not work. This does introduce a possible failure point for the script should the Master Functions script be moved or renamed, but does a great job of cleaning up the main script and makes it look simple to the potential non-powershell savvy user. Worse case, delete the import function and copy paste the functions from Master into Main script. ¯\_(ツ)_/¯
