#! /bin/bash

#& START SCRIPT

# part 1: START VARIABLES : variable used in the script.
# part 2: Start Function : function used in the script.
# part 3: Start Exeptions : exeptions for the argumnets (options and paths)
# part 4: Start Geting Print Values : geting value for print_type, print_mode, level and paths from arguments
# part 5: Start Printing : show directories contents as tree.

#& START VARIABLES:
  print_type="m"
  print_mode="s"
  level_to_stop=""
  level=1; # it will start from 1 for simple printing and from 0 for advanced printing.
  curent_path=""
  help_type=""

  index=0
  image_index=0
  paths_collector=()
  images_collector=()


  directory_color="\e[96m"
  directory_color_100="\e[2;96m"
  nr_directory_color="\e[31m"
  link_color="\e[91m"
  file_color="\e[92m"
  file_color_100="\e[2;92m"
  nr_file_color="\e[31m"
  default_color="\e[0;39m"
  transparent_text="\e[90m"
  error_color="\e[31m"
  

  folder_icon="📂";
  link_icon="🔗";
  image_icon="📷";
  video_icon="🎥";
  music_icon="🎵";
  script_icon="💲";
  text_icon="📄";
#& END VARIABLES.

#& Start Function:

  print_where_is_error_in_options() {
    local arg=$1
    arg=${arg,,}
    local inerror_part=""
    local error_part=""
    case $arg in
      -csl*) # print where is error 'invalid level' 
        error_part=${arg##*-csl};
        inerror_part=${arg%${error_part}*}
        [[ -z $error_part ]] && error_part="<number>"
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -cal*) # print where is error 'invalid level' 
        error_part=${arg##*-cal};
        inerror_part=${arg%${error_part}*}
        [[ -z $error_part ]] && error_part="<number>"
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -cl*) # print where is error 'invalid level' 
        error_part=${arg##*-cl};
        inerror_part=${arg%${error_part}*}
        [[ -z $error_part ]] && error_part="<number>"
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -msl*) # print where is error 'invalid level' 
        error_part=${arg##*-msl};
        inerror_part=${arg%${error_part}*}
        [[ -z $error_part ]] && error_part="<number>"
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -mal*) # print where is error 'invalid level' 
        error_part=${arg##*-mal};
        inerror_part=${arg%${error_part}*}
        [[ -z $error_part ]] && error_part="<number>"
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -ml*) # print where is error 'invalid level' 
        error_part=${arg##*-ml};
        inerror_part=${arg%${error_part}*}
        [[ -z $error_part ]] && error_part="<number>"
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -cs*) # print where is error 'have to present level'
        error_part=${arg##*-cs};
        inerror_part=${arg%${error_part}*}
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -ca*) # print where is error 'have to present level'
        error_part=${arg##*-ca};
        inerror_part=${arg%${error_part}*}
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -ms*) # print where is error 'have to present level'
        error_part=${arg##*-ms};
        inerror_part=${arg%${error_part}*}
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -ma*) # print where is error 'have to present level'
        error_part=${arg##*-ma};
        inerror_part=${arg%${error_part}*}
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -c*) # print where is error 'have to present print_mode or level'
        error_part=${arg##*-c};
        inerror_part=${arg%${error_part}*}
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -m*) # print where is error 'have to present print_mode or level'
        error_part=${arg##*-m};
        inerror_part=${arg%${error_part}*}
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -sl*) # print where is error 'invalid level'
        error_part=${arg##*-sl};
        inerror_part=${arg%${error_part}*}
        [[ -z $error_part ]] && error_part="<number>"
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -al*) # print where is error 'invalid level'
        error_part=${arg##*-al};
        inerror_part=${arg%${error_part}*}
        [[ -z $error_part ]] && error_part="<number>"
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -s*) # print where is error 'invalid level'
        error_part=${arg##*-s};
        inerror_part=${arg%${error_part}*}
        [[ -z $error_part ]] && error_part="<number>"
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -a*) # print where is error 'invalid level'
        error_part=${arg##*-a};
        inerror_part=${arg%${error_part}*}
        [[ -z $error_part ]] && error_part="<number>"
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -l*) # print where is error 'invalid level'
        error_part=${arg##*-l};
        inerror_part=${arg%${error_part}*}
        [[ -z $error_part ]] && error_part="<number>"
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
      -*) # print where is error 'have to present print_type, print_mode or level'
        error_part=${arg##*-};
        inerror_part=${arg%${error_part}*}
        [[ -z $error_part ]] && error_part="<print_type>"
        echo -e " WHERE IS ERROR: $inerror_part$error_color$error_part$default_color  $default_color"
        ;;
    esac
  }

  test_respecting_options_syntax() { # test if argument 1 is respect syntax: -[print_type][print_mode:opt][l<level>:opt]
    local arg=$1
    if [[ $arg =~ -[cCmM] ]]; then
      if [[ ! $arg =~ -[cCmM][aAsS]?([lL][1-9][0-9]?)?$  ]]; then # options with print_type
        echo " ERROR: the Syntax Not Respected"
        if [[ $arg =~ -[cCmM][aAsS][lL] ]]; then
          echo " ERROR: Error in level!"
          echo " ERROR: the level have to be number 1 -> 99";
          print_where_is_error_in_options $arg # print where is error 'invalid level'
          echo " For more details about Errors, type this cummend: script_name -he."
      elif [[ $arg =~ -[cCmM][lL] ]]; then
        echo " ERROR: Error in level!"
        echo " ERROR: the level have to be number 1 -> 99";
        print_where_is_error_in_options $arg # print where is error 'invalid level'
        echo " For more details about Errors, type this cummend: script_name -he."
      elif [[ $arg =~ -[cCmM][aAsS] ]]; then
        echo " ERROR: Error in level!";
        echo " ERROR: It have to be 'l'";
        print_where_is_error_in_options $arg # print where is error 'have to present level'
        echo " For more details about Errors, type this cummend: script_name -he."
      elif [[ $arg =~ -[cCmM] ]]; then
          echo " ERROR: Error in print_mode!";
          echo " ERROR: valide print mode are : 'S' and 'A'";
          print_where_is_error_in_options $arg  # print where is error 'have to present print_mode or level'
          echo " For more details about Errors, type this cummend: script_name -he."
        fi
        exit
      fi
    elif [[ $arg =~ -[aAsS] ]]; then
      if [[ ! $arg =~ -[sSaA]([lL][1-9][0-9]?)?$ ]]; then # options without print_type
        echo " ERROR: the Syntax Not Respected"
        if [[ $arg =~ -[sSaA][lL] ]]; then
          echo " ERROR: Error in level!"
          echo " ERROR: the level have to be number 1 -> 99";
          print_where_is_error_in_options $arg # print where is error 'invalid level'
          echo " For more details about Errors, type this cummend: script_name -he."
        elif [[ $arg =~ -[sSaA] ]]; then
          echo " ERROR: Error in level!"
          echo " ERROR: It have to be 'l'";
          print_where_is_error_in_options $arg  # print where is error 'have to present print_mode or level'
          echo " For more details about Errors, type this cummend: script_name -he."
        fi
        exit
      fi
    elif [[ ! $arg =~ -[lL][1-9][0-9]?$ ]]; then # options without print_type and print_mode
      echo " ERROR: the Syntax Not Respected"
      if [[ $arg =~ -[lL] ]]; then
        echo " ERROR: Error in level!"
        echo " ERROR: the level have to be number 1 -> 99";
        print_where_is_error_in_options $arg # print where is error 'invalid level
        echo " For more details about Errors, type this cummend: script_name -he."
      fi
      exit
    fi
  }

  test_paths() {
    if [[ ! -d $1 ]]; then # passed path is not directory.
      echo    " ERROR: Error in Path!"
      echo -e " ERROR: '$error_color$1$default_color' is not a directory!  $default_color"
      echo -e " For more details about Errors, type this cummend: script_name -he."
      exit
    elif [[ ! -r $1 ]]; then # passed path is not readable.
      echo    " ERROR: Error in Path!"
      echo -e " ERROR: '$error_color$1$default_color' is not readable!  $default_color"
      echo -e " For more details about Errors, type this cummend: script_name -he."
      exit
    fi
  }

  print_main_directory_name() {
    path="$1";
    if [[ $path == */ ]]; then
      local directory=${path%*/}
      echo -e "$2${directory##*/}"
    else
      echo -e "$2${path##*/}"
    fi
  }

  simple_print_content() {
    level=$(( $level + 1 ))
    local prefix=$2

    #+ calculate contents number.
    local arr=($( ls "$1" ))
    local items_number=${#arr[*]}
    local item_index=0; # index for items

    for file in $1/*
    do
      item_index=$(( $item_index + 1 ))
      local child_prefix="│   "
      local pointer="├──"

      # echo $items_number :: $item_index
      if [ $item_index -eq $items_number ]; then
        pointer="└──"
        child_prefix="    "
      fi

      local start_with="$transparent_text${prefix}${pointer}$default_color"
      local file_name="${file##*/}"
      if [[ -d "$file" ]]; then
        if [[ -r "$file" ]]; then
          echo -e "$start_with$file_name$default_color"
        else
          echo -e "$start_with$file_name$default_color"
          continue
        fi
        if [[ $level_to_stop =~ [1-9][0-9]? && $(( $level )) > $level_to_stop ]]; then
            continue;
        fi
        simple_print_content "$file" "${prefix}$child_prefix"
      elif [[ -f "$file" ]]; then
        echo -e "$start_with$file_name$default_color"
      fi
    done
    level=$(( $level - 1 ))
  }

  check_file_type() {
    local start_with="$transparent_text$2$file_color"
    if [[ $1 =~ .png || $1 =~ .jpg || $1 =~ .gif ||  $1 =~ .svg ]]; then 
      echo -e "$start_with$image_icon $1 $file_color_100::$image_index:: $default_color";
      image_index=$(( $image_index + 1 ))
      images_collector+=("$3");
    elif [[ $1 =~ .mp4 ]]; then 
      echo -e "$start_with$video_icon $1 $default_color";
    elif [[ $1 =~ .mp3 ]]; then 
      echo -e "$start_with$music_icon $1 $default_color";
    elif [[ $1 =~ .sh || $1 =~ .bash  ]]; then 
      echo -e "$start_with$script_icon $1 $default_color";
    else 
      echo -e "$start_with$text_icon $1 $default_color";
    fi
  }

  advanced_print_content() {
    index=$(( $index + 1 ));
    paths_collector+=("$1")

    level=$(( $level + 1 ))
    local prefix=$2

    #+ calculate contents number.
    local arr=($( ls "$1" ))
    local items_number=${#arr[*]}
    local item_index=0; # index for items

    path="$1/"
    for file in $path*
    do
      item_index=$(( $item_index + 1 ))
      local child_prefix="│   "
      local pointer="├───"

      if [ $item_index -eq $items_number ]; then
        pointer="└───"
        child_prefix="    "
      fi
      local start_with="$transparent_text${prefix}${pointer}"
      local file_name="${file##*/}"
      if [[ -d "$file" ]]; then
        if [[ -r "$file" ]]; then
          [[ -L "$file" ]] && echo -e "$start_with$link_color$link_icon $file_name$default_color" # define symbollinks
          [[ -L "$file" ]] || echo -e "$start_with$directory_color$folder_icon $file_name  $directory_color_100::$index:: $default_color" # define readable directoreis 
        else
          echo -e "$start_with$nr_directory_color$folder_icon $file_name $transparent_text $default_color" # define non readable directoreis 
          continue
        fi
        if [[ $level_to_stop =~ [1-9][0-9]? && $(( $level )) > $level_to_stop ]]; then # test levels
          # go to next sibling if level is not requerd.  
          continue;
        fi
        advanced_print_content "$file" "${prefix}$child_prefix"
      elif [[ -f "$file" ]]; then
        if [[ ! -r "$file" ]]; then # the file is not readable
          echo -e "$start_with$nr_file_color$text_icon$file_name $default_color";
          continue
        fi
        [[ "$file_name" != '*' ]] && check_file_type "$file_name" "${prefix}${pointer}" "$file"
      fi
    done
    level=$(( $level - 1 ))
  }

  get_go_to_path() { # get_go_to_path option
    echo
    read -p "get [1] or go to [2] or out [0]: " choise
    [[ $choise == 1 || $choise == 2 ]] || return
    while [[ true ]]; 
      do
        read -p "enter index : " target_directory
        if [[ $target_directory =~ [0-9][0-9]?[0-9]? && ${#paths_collector[*]} -le $target_directory ]]; then # exeption for input.
          [[ $target_directory -gt 999 ]] && echo -e " \e[31mWe accepte '999' as max index!\e[0m"; # max value is 999.
          [[ $target_directory -gt 999 ]] || echo -e " \e[31mThe target is not exist! try again!\e[0m"; # input is not a number.
          continue
        fi
        [[ $choise == 1 ]] && echo "${paths_collector[target_directory]}" # print path
        if [[ $choise == 2 ]]; then 
          if [[ -r ${paths_collector[target_directory]} ]]; then
            # if we use the script with normal method (./showtree.sh ...) $0 will equal the script_name ( ./showtree.sh ), but if we use dot '.' before script_name (. ./showtree.sh ...) $0 will equal 'bash' and in this case we can change current directory
            [[ $0 == *bash ]] && cd "${paths_collector[target_directory]}" # change corrent directory.
            [[ $0 == *bash ]] || printf " We can't change directory in parent bash.\n Try add dot '.' before the commande.\n For example: << \e[96m. ./tree.sh -ca \e[0m>>"
          else  # file is not readable.
            echo " This file is not readable!"
            echo " Here is its path:"
            echo "    ${paths_collector[target_directory]}"
          fi
        fi
        break
    done
  }

  display_images() { # despaly_images option
    echo
    echo " Displaying images:"
    while [[ true ]]; 
      do
        read -p "enter index : " target_image
        if [[ $target_image =~ [0-9][0-9]?[0-9]? && ${#paths_collector[*]} -le $target_image ]]; then  #exepions for input.
          [[ $target_image -gt 999 ]] && echo -e "\e[31m We accepte '999' as max index!\e[0m"; # max value is 999.
          [[ $target_image -gt 999 ]] || echo -e "\e[31m The target is not exist! try again!\e[0m"; # input is not a number.
          continue
        fi
        [[ $target_image == [qQ] ]] && break # stop desplay_images option.
        fim "${paths_collector[$target_image]}" # display images
    done
  }

  paths_or_images() { # choose between get_go_to_path or despaly_images
    echo
    if [[ ${#images_collector[@]} == 0 ]]; then # if no image exist in contents so show get_go_to_path option
        get_go_to_path
      else
        echo " Press 'p' to get paths or change you place,"
        echo " and 'i' to display images,"
        echo " or 'q' to out:"
        while [[ true ]]; do
        read choise
          if [[ ! $choise =~ [pP] && ! $choise =~ [iI] && ! $choise =~ [qQ] ]]; then
            echo " Invalide char!"
            continue
          fi
            [[  $choise =~ [pP] ]] && get_go_to_path # show get_go_to_path option
            [[  $choise =~ [iI] ]] && display_images # show despaly_images option
            break
        done
    fi
  }

  syntax_menu() {
    echo "<< press enter to read more >>"
    echo -e "\e[3;32m<<<< SYNTAXES: >>>>\e[0m"
    echo -e " This scipt will help you to print all content of your directories."
    echo -e " You can simply use this script by following this syntax:"
    echo -e "     \e[0;96mscript_name -[options] [paths...]\e[0m."
    echo -e " \e[4;33mOptions syntax\e[0m: \e[0;95m-[print_type][print_mode][level]\e[0m."
    echo -e "      $transparent_text├──\e[94m[print_type]\e[0m: It defines which type of printing."
    echo -e "      $transparent_text│                 \e[0mIt takes two values:"
    echo -e "      $transparent_text│                   \e[0m<\e[92mC\e[0m>: print current directory."
    echo -e "      $transparent_text│                      => In this case all other arguments"
    echo -e "      $transparent_text│                         will be ignored.\e[0m"
    echo -e "      $transparent_text│                   \e[0m<\e[92mM\e[0m>: print multiple directories."
    echo -e "      $transparent_text├──\e[94m[print_mode]\e[0m: It defines which mode of printing."
    echo -e "      $transparent_text│                 \e[0mIt takes two values:"
    echo -e "      $transparent_text│                   \e[0m<\e[92mS\e[0m>: print with simple mode."
    echo -e "      $transparent_text│                   \e[0m<\e[92mA\e[0m>: print with advanced mode."
    echo -e "      $transparent_text└──\e[94m[level].....\e[0m: it defines level to stop at."
    echo -e "                        it's composed from two parts: \e[34ml<n>\e[0m"
    echo -e "                          <\e[92mL\e[0m>: it is necessary."
    echo -e "                          <\e[92mN\e[0m>: number from 1 to 99."
    read
    echo -e " \e[4;33mHelp Option syntax\e[0m: \e[0;95m-h[opt]\e[0m."
    echo -e "                        $transparent_text├──\e[0m<\e[92mA\e[0m>: To print all details about script."
    echo -e "                        $transparent_text├──\e[0m<\e[92mS\e[0m>: To print Syntaxes explains."
    echo -e "                        $transparent_text├──\e[0m<\e[92mE\e[0m>: To print Errors explains."
    echo -e "                        $transparent_text└──\e[0m<\e[92mT\e[0m>: To start tutorial."
    echo -e "                        $transparent_text => In this case all other arguments will"
    echo -e "                             be ignored.\e[0m"
    echo -e " Example1: script_name -mal3 path1 path2\e[0m"
    echo -e "        ─> for print content of \e[4;39mmultiple\e[0m paths (path1, path2)"
    echo -e "           with \e[4;39madvanced\e[0m mode and stop at \e[4;39mlevel 3\e[0m"
    echo -e " Example2: script_name -he\e[0m"
    echo -e "        ─> for show \e[4;39mhelp_menu\e[0m, just \e[4;39mErrors part\e[0m."
    read
    echo -e " \e[4;33mGet or Go to Path\e[0m option :"
    echo -e "   By this option you can get an path of one of directories in "
    echo -e "   tree by entring its index, you will find this index after "
    echo -e "   every readable directory."
    echo -e "   You can also change your current directory to it!"
    echo -e "   To do that you have to add dot '.' before the commande:"
    echo -e "          \e[0;96m. script_name -[options] [paths...]\e[0m"
    read
    echo -e " \e[4;33mDesplaying images\e[0m option :"
    echo -e "   By this option you can desplay images if they are in your "
    echo -e "   directories."
    read
    echo -e "   \e[31m--------- This script will not work correctly"
    echo -e "   with spaces! --------------------------------\e[0m"
    read
  }

  error_menu() {
    echo -e "\e[3;32m<<<< ERRORS: >>>>\e[0m"
    echo    "  You will get ERRORS in case the Syntax Not Respected or paths are"
    echo -e " not available directory ( \e[4;39mnot exist\e[0m || \e[4;39mnot readable\e[0m )."
    echo -e "  Explain Errors:"
    echo -e "      $transparent_text├───\e[0m'\e[31mSyntax Not Respected\e[0m':"
    echo -e "      $transparent_text│     ├────\e[0m<<\e[1;31mError in print_type!\e[0m>> :"
    echo -e "      $transparent_text│     │    \e[0m    In this case the errors is in the first option"
    echo -e "      $transparent_text│     │    \e[0m   (print_type). The errors shown becouse the print"
    echo -e "      $transparent_text│     │    \e[0m   type entred is not correct."
    echo -e "      $transparent_text│     │    \e[0m    Print type take tow value: 'M' && 'C'."
    echo -e "      $transparent_text│     ├────\e[0m<<\e[1;31mError in print_mode!\e[0m>> :"
    echo -e "      $transparent_text│     │    \e[0m    In this case the errors is in the second option"
    echo -e "      $transparent_text│     │    \e[0m   (print_mode). the errors shown becouse the print"
    echo -e "      $transparent_text│     │    \e[0m   mode entred is not correct."
    echo -e "      $transparent_text│     │    \e[0m    Print mode take tow value: 'S' && 'A'."
    echo -e "      $transparent_text│     └────\e[0m<<\e[1;31mError in level!\e[0m>> :"
    echo -e "      $transparent_text│          \e[0m     In this case the errors is in the third option"
    echo -e "      $transparent_text│          \e[0m    (level). the errors shown becouse the level entred "
    echo -e "      $transparent_text│          \e[0m    is not correct."
    echo -e "      $transparent_text│          \e[0m     Level compose on tow part : char 'L' to represent"
    echo -e "      $transparent_text│          \e[0m     The level and number to specify the level."
    echo -e "      $transparent_text└───\e[0m'\e[31mError in Path!\e[0m':"
    echo -e "            $transparent_text├────\e[0m<<\e[1;31m'path/example' is not a directory!\e[0m>> :"
    echo -e "            $transparent_text│    \e[0m    In this case the errors is in the paths."
    echo -e "            $transparent_text│    \e[0m    This errors shown becouse the path entred is not"
    echo -e "            $transparent_text│    \e[0m    exist or is not valid directory."
    echo -e "            $transparent_text├────\e[0m<<\e[1;31m'path/example' is not a readable!\e[0m>> :"
    echo -e "            $transparent_text│    \e[0m    In this case the errors is in the paths."
    echo -e "            $transparent_text│    \e[0m    This errors shown becouse the path entred is not"
    echo -e "            $transparent_text│    \e[0m    readable."
    echo -e "            $transparent_text└────\e[0m<<\e[1;31mNo Directory Passed!\e[0m>> :"
    echo    "                     This errors shown when option print_type is <M>"
    echo    "                     multiple. In this case it is necessary to entre"
    echo    "                     paths."
    read
  }

  tutorial_menu() {
    echo "<< press enter to read more >>"
    echo " Welcome to tree_script_tutorial!"
    echo " In these tutorial you will learn how to use this script perfectly."
    echo -e "\e[2;39mpress enter to continue...\e[0m"
    read
    echo -e " Firstly: \e[4;33mdealing with Syntaxes\e[0m."
    echo    "   -> print contents:"
    echo    "        to print contents of current directory in simple mode, you"
    echo -e "        can enter this \e[4;39mcommandes\e[0m:"
    echo -e "                          $transparent_text├───\e[96m<script_name> \e[90m without arguments\e[0m."
    echo -e "                          $transparent_text├───\e[96m<script_name> -c\e[0m."
    echo -e "                          $transparent_text└───\e[96m<script_name> -s\e[90m without paths\e[0m."
    read
    echo    "        to print contents of current directory in advanced mode, you "
    echo -e "        can enter this \e[4;39mcommandes\e[0m:"
    echo -e "                          $transparent_text├───\e[96m<script_name> -ca\e[0m."
    echo -e "                          $transparent_text└───\e[96m<script_name> -a\e[90m without paths\e[0m."
    read
    echo    "        to print contents of current directory in simple mode and "
    echo -e "        stop in level 4, you can enter this \e[4;39mcommandes\e[0m:"
    echo -e "                          $transparent_text├───\e[96m<script_name> -csl3\e[0m."
    echo -e "                          $transparent_text├───\e[96m<script_name> -sl3\e[90m without paths\e[0m."
    echo -e "                          $transparent_text└───\e[96m<script_name> -l3\e[90m without paths\e[0m."
    read
    echo    "        to print contents of current directory in advanced mode and "
    echo -e "        stop in level 4, you can enter this \e[4;39mcommandes\e[0m:"
    echo -e "                          $transparent_text├───\e[96m<script_name> -cal3\e[0m."
    echo -e "                          $transparent_text└───\e[96m<script_name> -al3\e[90m without paths\e[0m."
    read
    echo    "        to print contents of multiple directories in simple mode, you"
    echo -e "        can enter this \e[4;39mcommandes\e[0m:"
    echo -e "                          $transparent_text├───\e[96m<script_name> -m <paths1> <paths2>\e[0m."
    echo -e "                          $transparent_text├───\e[96m<script_name> -ms <paths1> <paths2>\e[0m."
    echo -e "                          $transparent_text├───\e[96m<script_name> -s <paths1> <paths2>\e[0m."
    echo -e "                          $transparent_text└───\e[96m<script_name> <paths1> <paths2>\e[0m."
    read
    echo    "        to print contents of multiple directories in advanced mode,"
    echo -e "        you can enter this \e[4;39mcommandes\e[0m:"
    echo -e "                          $transparent_text├───\e[96m<script_name> -ma <paths1> <paths2>\e[0m."
    echo -e "                          $transparent_text└───\e[96m<script_name> -a <paths1> <paths2>\e[0m."
    read
    echo    "        to print contents of multiple directories in simple mode,and"
    echo -e "        stop in level 4, you can enter this \e[4;39mcommandes\e[0m:"
    echo -e "                          $transparent_text├───\e[96m<script_name> -msl4 <paths1> <paths2>\e[0m."
    echo -e "                          $transparent_text├───\e[96m<script_name> -sl4 <paths1> <paths2>\e[0m."
    echo -e "                          $transparent_text└───\e[96m<script_name> -l4 <paths1> <paths2>\e[0m."
    read
    echo    "        to print contents of multiple directories in advanced mode,"
    echo -e "        and stop in level 4, you can enter this \e[4;39mcommandes\e[0m:"
    echo -e "                          $transparent_text├───\e[96m<script_name> -mal4 <paths1> <paths2>\e[0m."
    echo -e "                          $transparent_text└───\e[96m<script_name> -al4 <paths1> <paths2>\e[0m."
    read
    echo
    echo    "   -> help syntaxes:"
    echo -e "        to show help menu use this \e[4;39mcommandes\e[0m:"
    echo -e "                          $transparent_text├───\e[96m<script_name> -h\e[0m."
    echo -e "                          $transparent_text│    => to show all details.\e[0m"
    echo -e "                          $transparent_text├───\e[96m<script_name> -ha\e[0m."
    echo -e "                          $transparent_text│    => to show all details.\e[0m"
    echo -e "                          $transparent_text├───\e[96m<script_name> -hs\e[0m."
    echo -e "                          $transparent_text│    => to show info about syntaxes.\e[0m"
    echo -e "                          $transparent_text├───\e[96m<script_name> -he\e[0m."
    echo -e "                          $transparent_text│    => to show info about errors.\e[0m"
    echo -e "                          $transparent_text└───\e[96m<script_name> -ht\e[0m."
    echo -e "                          $transparent_text     => to start tutorial.(this tutorial)\e[0m"
    read
    echo -e " Secondly: \e[4;33mdealing with Errors\e[0m."
    echo    "   We will explain errors by using this example:"
    echo    "          -------------------------------------------------"
    echo -e "          | ERROR: the Syntax Not Respected.              |"
    echo -e "          | ERROR: Error in level!                        |"                       
    echo -e "          | ERROR: the level have to be number 1 -> 99    |"
    echo -e "          | WHERE IS ERROR: -msl\e[31m<number>\e[0m                  |"
    echo    "          -------------------------------------------------"
    echo    "   1st line: tell you Error type."
    echo    "   2nd line: tell you what is source the error."
    echo    "   3rd line: tell you wesh condition couses error."
    echo    "   4rd line: tell you where is Error in your commande, or what you "
    echo    "             need to complate it."
    read
  }

  help_menu() {
    syntax_menu
    error_menu
  }

#& End Function

#& Start Exeptions:
  #+ exeptions for options
  case $1 in
    -[cC]* )
      test_respecting_options_syntax $1
      ;;
    -[mM]* )
      test_respecting_options_syntax $1
      ;;
    -[sSaA]* )
      test_respecting_options_syntax $1
      ;;
    -[lL]* )
      test_respecting_options_syntax $1
      ;;
    -[hH]* )
      ;;
    -*)
      echo " Syntax Not Respected"
      echo " ERROR: Error in print_type!"
      echo " available print_type are : 'C', 'M'"
      print_where_is_error_in_options $1
      ;;
  esac

  #+  exeptions for directories
  [[ $1 == -* ]] && i=2
  [[ $1 == -* ]] || i=1
  if [[ $1 =~ -[mM] ]]; then  # check if there is no path passed where are requerd
    if [[ -z $2 ]]; then
      echo " ERROR: Error in Path!"
      echo " ERROR: no directory passed!"
      echo -e " For more details about Errors, type this cummend: script_name -he."
      exit
    fi
  fi
  for (( i; $i<=$#; i++ )); do # verify the input paths 
    test_paths "${!i}"
  done

#& End Exeptions.

#& Start Geting Print Values:

  if [[ $1 =~ -[cC] ]]; then
    print_type='c';
    curent_path=$( pwd );
    if [[ $1 =~ -[cC][aA] ]]; then
      print_mode='a'
      if [[ $1 =~ -[cC][aA][lL] ]]; then
        arg=$1
        arg=${arg,,}
        level_to_stop=${arg##*-cal}
      fi
    elif [[ $1 =~ -[cC][sS] ]]; then
      print_mode='s'
      if [[ $1 =~ -[cC][sS][lL] ]]; then
        arg=$1
        arg=${arg,,}
        level_to_stop=${arg##*-csl}
      fi
    elif [[ $1 =~ -[cC][lL] ]]; then
      print_mode='s'
      arg=$1
      arg=${arg,,}
      level_to_stop=${arg##*-cl}
    fi
  elif [[ $1 =~ -[mM] ]]; then
    print_type='m'
    if [[ $1 =~ -[mM][aA] ]]; then
      print_mode='a'
      if [[ $1 =~ -[mM][aA][lL] ]]; then
        arg=$1
        arg=${arg,,}
        level_to_stop=${arg##*-mal}
      fi
    elif [[ $1 =~ -[mM][sS] ]]; then
      print_mode='s'
      if [[ $1 =~ -[mM][sS][lL] ]]; then
        arg=$1
        arg=${arg,,}
        level_to_stop=${arg##*-msl}
      fi
    elif [[ $1 =~ -[mM][lL] ]]; then
      print_mode='s'
      arg=$1
      arg=${arg,,}
      level_to_stop=${arg##*-ml}
    fi
  elif [[ $1 =~ -[sSaA] ]]; then
    print_type='m'
    [[ -z $2 ]] && print_type='c' # print current directory if no path passed!
    if [[ $1 =~ [aA] ]]; then
      print_mode='a'
      if [[ $1 =~ -[aA][lL] ]]; then
        arg=$1
        arg=${arg,,}
        level_to_stop=${arg##*-al}
      fi
    elif [[ $1 =~ -[sS] ]]; then
      print_mode='s'
      if [[ $1 =~ -[sS][lL] ]]; then
        arg=$1
        arg=${arg,,}
        level_to_stop=${arg##*-sl}
      fi
    fi
  elif [[ $1 =~ -[lL] ]]; then
    print_type='m'
    [[ -z $2 ]] && print_type='c' # print current directory if no path passed!
    print_mode='s'
    arg=$1
    arg=${arg,,}
    level_to_stop=${arg##*-l}
  elif [[ $1 =~ -[hH] ]]; then
    print_type='h'
    help_type='a'
    [[ $1 =~ -[hH][sS] ]] && help_type='s'
    [[ $1 =~ -[hH][eE] ]] && help_type='e'
    [[ $1 =~ -[hH][aA] ]] && help_type='a'
    [[ $1 =~ -[hH][tT] ]] && help_type='t'
  else # no options passed.
    print_type='m'
    print_mode='s'
    if [[ $# == 0 ]]; then
      print_type='c'
    fi
  fi

#& End Geting Values.

#& Start Printing:
  echo -e "\e[1;44m                      Start Tree secript.                         \e[0m"
  echo
  if [[ $print_type == c ]]; then # print current directory contents.
    if [[ $print_mode == s ]]; then # print with simple mode
      curent_path=$( pwd );
      print_main_directory_name "$curent_path"
      simple_print_content "$curent_path" "" $level_to_stop
    else # print with advanced mode
      curent_path=$( pwd );
      print_main_directory_name "$curent_path" "$directory_color$folder_icon"
      advanced_print_content "$curent_path" "" $level_to_stop
      paths_or_images
    fi
  elif [[ $print_type == m ]]; then # print multiple directories contents.
    if [[ $print_mode == s ]]; then # print theme with simple mode
      [[ $1 == -* ]] && i=2 # paths start from argument 2
      [[ $1 == -* ]] || i=1 # paths start from argument 1
      for (( i; i<=$#; i++ )); do
        directory_path=${!i};
        print_main_directory_name "$directory_path"
        simple_print_content "$directory_path" "" $level_to_stop
        echo -e "$transparent_text────────────────────────────────────$default_color"
      done
    else # print theme with advence mode
      [[ $1 == -* ]] && i=2 # paths start from argument 2
      [[ $1 == -* ]] || i=1 # paths start from argument 1
      for (( i; i<=$#; i++ )); do
        directory_path=${!i};
        print_main_directory_name "$directory_path" "$directory_color$folder_icon"
        advanced_print_content "$directory_path" "" $level_to_stop
        echo -e "$transparent_text────────────────────────────────────$default_color"
      done
      paths_or_images
    fi
  elif [[  $print_type == h ]]; then
    [[ $help_type == 'a' ]] && help_menu
    [[ $help_type == 's' ]] && syntax_menu
    [[ $help_type == 'e' ]] && error_menu
    [[ $help_type == 't' ]] && tutorial_menu
  fi
  echo
  echo -e "\e[1;44m                       End Tree secript.                          \e[0m"
#& End Printing.