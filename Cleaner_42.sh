#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

#banner
echo -e	"\n"
echo -e	" 		█▀▀ █▀▀ █░░ █▀▀ ▄▀█ █▄░█ "
echo -e	" 		█▄▄ █▄▄ █▄▄ ██▄ █▀█ █░▀█ "
echo -en "\n    	    	   By: "
echo -e "\033[33mOMBHD\033[0m [𝒐𝒃𝒐𝒖𝒚𝒌𝒐𝒖]\n"

sleep 2

#update
if [ "$1" == "update" ];
then
	tmp_dir=".issent_wakha_daguis_t9ddart_ghina_ard_trmit_orra_tskert_zond_ism_yad_ikan_repo_gh_desktop_nk_achko_awldi_4ayad_yogguer_l'encrypting_n_2^10000_ghayad_aras_tinin_t''a.*\l7i?t_agmano_mohmad"
	if ! git clone --quiet https://github.com/ombhd/Cleaner_42.git "$HOME"/"$tmp_dir" &>/dev/null;
	then
		sleep 0.5
		echo -e "\033[31m\n           -- Couldn't update CCLEAN! :( --\033[0m"
		echo -e "\033[33m\n   -- Maybe you need to change your bad habits XD --\n\033[0m"
		exit 1
	fi
	sleep 1
	if [ "" == "$(diff "$HOME"/Cleaner_42.sh "$HOME"/"$tmp_dir"/Cleaner_42.sh)" ];
	then
		echo -e "\033[33m\n -- You already have the latest version of cclean --\n\033[0m"
		/bin/rm -rf "$HOME"/"${tmp_dir:?}"
		exit 0
	fi
	cp -f "$HOME"/"$tmp_dir"/Cleaner_42.sh "$HOME" &>/dev/null
	/bin/rm -rf "$HOME"/"${tmp_dir:?}" &>/dev/null
	echo -e "\033[33m\n -- cclean has been updated successfully --\n\033[0m"
	exit 0
fi
#calculating the current available storage
Storage=$(df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
if [ "$Storage" == "0BB" ];
then
	Storage="0B"
fi
echo -e "\033[33m\n -- Available Storage Before Cleaning : || $Storage || --\033[0m"

echo -e "\033[31m\n -- Cleaning ...\n\033[0m "


should_log=0
if [[ "$1" == "-p" || "$1" == "--print" ]]; then
	should_log=1
fi

# function clean_glob {
# 	# don't do anything if argument count is zero (unmatched glob).
# 	if [ -z "$1" ]; then
# 		return 0
# 	fi

# 	if [ $should_log -eq 1 ]; then
# 		for arg in "$@"; do
# 			du -sh "$arg" 2>/dev/null
# 		done
# 	fi

# 	/bin/rm -rf "$@" &>/dev/null

# 	return 0
# }

#says yes to safety prompts
function clean_glob {
    for f in "$@"
    do
        if [ -e "$f" ]; then
            # Explicitly asking for confirmation
            echo "Are you sure you want to remove $f? [y/N]"
            read -r answer
            if [[ "$answer" == [Yy] ]]; then
                rm -rf "$f" || echo "Failed to remove $f"
            else
                echo "Skipped $f"
            fi
        else
            echo "File or directory $f does not exist."
        fi
    done
}

function clean {
    # to avoid printing empty lines
    # or unnecessarily calling /bin/rm
    # we resolve unmatched globs as empty strings.
    shopt -s nullglob

    echo -ne "\033[38;5;208m"

    # Function to clean glob with error handling
    function clean_glob {
        for f in "$@"
        do
            rm -rf "$f" 2>/dev/null || echo "Failed to remove $f"
        done
    }

    # General Caches and Trash
    clean_glob "$HOME"/.cache/*
    clean_glob "$HOME"/.local/share/Trash/*

    # Application Caches
    # Slack
    clean_glob "$HOME"/.config/Slack/Cache/*
    clean_glob "$HOME"/.config/Slack/Service\ Worker/CacheStorage/*

    # VSCode
    clean_glob "$HOME"/.config/Code/Cache/*
    clean_glob "$HOME"/.config/Code/CachedData/*
    clean_glob "$HOME"/.config/Code/Crashpad/completed/*
    clean_glob "$HOME"/.config/Code/User/workspaceStorage/*
	clean_glob "$HOME"/.vscode/extensions/bianxianyang.htmlplay-0.0.10/node_modules/* #10.22.24 for onward
	clean_glob "$HOME"/.vscode/extensions/ritwickdey.liveserver-5.7.9/node_modules/*
	clean_glob "$HOME"/.vscode/extensions/ms-vscode.cpptools-1.22.9-linux-x64/*
	clean_glob "$HOME"/.vscode/extensions/github.copilot-1.239.0/*
	clean_glob "$HOME"/.vscode/extensions/github.copilot-1.241.0/dist/*
	clean_glob "$HOME"/.vscode/extensions/ms-python.vscode-pylance-2024.10.1/dist/*

    # Discord
    clean_glob "$HOME"/.config/discord/Cache/*
    clean_glob "$HOME"/.config/discord/Code\ Cache/js*
    clean_glob "$HOME"/.config/discord/Crashpad/completed/*

    # Chrome
    clean_glob "$HOME"/.config/google-chrome/Default/Cache/*
    clean_glob "$HOME"/.config/google-chrome/Default/Service\ Worker/CacheStorage/*
    clean_glob "$HOME"/.config/google-chrome/Profile\ [0-9]/Cache/*
    clean_glob "$HOME"/.config/google-chrome/Profile\ [0-9]/Service\ Worker/CacheStorage/*
	clean_glob "$HOME"/.config/google-chrome/Default/extensions_crx_cache/*
	clean_glob "$HOME"/.config/google-chrome/Default/extensions_crx_cache/*

    # Chromium
    clean_glob "$HOME"/.config/chromium/Default/Cache/*
    clean_glob "$HOME"/.config/chromium/Default/Service\ Worker/CacheStorage/*
    clean_glob "$HOME"/.config/chromium/Profile\ [0-9]/Cache/*
    clean_glob "$HOME"/.config/chromium/Profile\ [0-9]/Service\ Worker/CacheStorage/*

    # tmp downloaded files with browsers
    clean_glob "$HOME"/.config/google-chrome/Default/File\ System
    clean_glob "$HOME"/.config/google-chrome/Profile\ [0-9]/File\ System
    clean_glob "$HOME"/.config/chromium/Default/File\ System
    clean_glob "$HOME"/.config/chromium/Profile\ [0-9]/File\ System

	# Mozilla - Remove WhatsApp Web cache for specific profiles
	clean_glob "$HOME"/.mozilla/firefox/dii18zp2.default-release-3/storage/default/https+++web.whatsapp.com/*
	clean_glob "$HOME"/.mozilla/firefox/tcmqlfx0.default-release-2/storage/default/https+++web.whatsapp.com/*
	clean_glob "$HOME"/.mozilla/firefox/gn4ny2l3.default-release-1/storage/default/https+++web.whatsapp.com/*
	clean_glob "$HOME"/.mozilla/firefox/*.default-release/cache2/*
	clean_glob "$HOME"/.mozilla/firefox/tcmqlfx0.default-release-2/cache2/*
	clean_glob "$HOME"/.mozilla/firefox/gn4ny2l3.default-release-1/cache2/*
	clean_glob "$HOME"/.mozilla/firefox/dii18zp2.default-release-3/cache2/*


    echo -ne "\033[0m"
}

clean


# function clean {
# 	# to avoid printing empty lines
# 	# or unnecessarily calling /bin/rm
# 	# we resolve unmatched globs as empty strings.
# 	shopt -s nullglob

# 	echo -ne "\033[38;5;208m"

# 	#42 Caches
# 	clean_glob "$HOME"/Library/*.42*
# 	clean_glob "$HOME"/*.42*
# 	clean_glob "$HOME"/.zcompdump*
# 	clean_glob "$HOME"/.cocoapods.42_cache_bak*

# 	#Trash
# 	clean_glob "$HOME"/.Trash/*

# 	#General Caches files
# 	#giving access rights on Homebrew caches, so the script can delete them
# 	/bin/chmod -R 777 "$HOME"/Library/Caches/Homebrew &>/dev/null
# 	clean_glob "$HOME"/Library/Caches/*
# 	clean_glob "$HOME"/Library/Application\ Support/Caches/*

# 	#Slack, VSCode, Discord and Chrome Caches
# 	clean_glob "$HOME"/Library/Application\ Support/Slack/Service\ Worker/CacheStorage/*
# 	clean_glob "$HOME"/Library/Application\ Support/Slack/Cache/*
# 	clean_glob "$HOME"/Library/Application\ Support/discord/Cache/*
# 	clean_glob "$HOME"/Library/Application\ Support/discord/Code\ Cache/js*
# 	clean_glob "$HOME"/Library/Application\ Support/discord/Crashpad/completed/*
# 	clean_glob "$HOME"/Library/Application\ Support/Code/Cache/*
# 	clean_glob "$HOME"/Library/Application\ Support/Code/CachedData/*
# 	clean_glob "$HOME"/Library/Application\ Support/Code/Crashpad/completed/*
# 	clean_glob "$HOME"/Library/Application\ Support/Code/User/workspaceStorage/*
# 	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Service\ Worker/CacheStorage/*
# 	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage/*
# 	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Application\ Cache/*
# 	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Default/Application\ Cache/*
# 	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Crashpad/completed/*

# 	#.DS_Store files
# 	clean_glob "$HOME"/Desktop/**/*/.DS_Store

# 	#tmp downloaded files with browsers
# 	clean_glob "$HOME"/Library/Application\ Support/Chromium/Default/File\ System
# 	clean_glob "$HOME"/Library/Application\ Support/Chromium/Profile\ [0-9]/File\ System
# 	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Default/File\ System
# 	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/File\ System

# 	#things related to pool (piscine)
# 	clean_glob "$HOME"/Desktop/Piscine\ Rules\ *.mp4
# 	clean_glob "$HOME"/Desktop/PLAY_ME.webloc

# 	echo -ne "\033[0m"
# }
# clean

if [ $should_log -eq 1 ]; then
	echo
fi

#calculating the new available storage after cleaning
Storage=$(df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
if [ "$Storage" == "0BB" ];
then
	Storage="0B"
fi
sleep 1
echo -e "\033[32m -- Available Storage After Cleaning : || $Storage || --\n\033[0m"

echo -e	"\n	       report any issues to me in:"
echo -e	"		   GitHub   ~> \033[4;1;34mombhd\033[0m"
echo -e	"	   	   42 Slack ~> \033[4;1;34mobouykou\033[0m\n"

#installer
