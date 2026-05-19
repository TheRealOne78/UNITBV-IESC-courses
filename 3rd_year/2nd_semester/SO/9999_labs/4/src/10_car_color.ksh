#!/usr/bin/env ksh

PS3="Select a car (enter number): "

select car in "Dacia Spring" "Dacia Logan" "BMW M3" "Ferrari 488" "Toyota Corolla" "Volkswagen Golf" "Quit"; do
    case "${car}" in
        "Dacia Spring")
            echo "Suggested color for ${car}: Gray"
            break ;;
        "Dacia Logan")
            echo "Suggested color for ${car}: Blue"
            break ;;
        "BMW M3")
            echo "Suggested color for ${car}: Alpine White"
            break ;;
        "Ferrari 488")
            echo "Suggested color for ${car}: Rosso Corsa (Red)"
            break ;;
        "Toyota Corolla")
            echo "Suggested color for ${car}: Silver"
            break ;;
        "Volkswagen Golf")
            echo "Suggested color for ${car}: Deep Black Pearl"
            break ;;
        "Quit")
            echo "Goodbye!"
            break ;;
        *)
            echo "Invalid option '${REPLY}'. Please try again." ;;
    esac
done
