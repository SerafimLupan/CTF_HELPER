#!/bin/bash
# CTF_HELPER - Audio Steganography Module
# Focus: Spectrograms, LSB, DTMF, and FSK/Modem decoding

source ./ctf_helper.sh

echo -e "${C6}[MODULE: AUDIO STEGANOGRAPHY]${NC}"
echo -e "Detecting hidden data in frequency and time domains\n"

echo "1) Generate Spectrogram (sox)"
echo "2) Decode FSK/Modem Tones (minimodem)"
echo "3) Decode DTMF (Telephone Keypad Tones)"
echo "4) WAV LSB Extraction (WavSteg)"
echo "5) Audio Triage (ffmpeg/file metadata)"
echo "0) Back to Stego Menu"

echo -en "\n${C3}audio_helper > ${NC}"
read audio_opt

case $audio_opt in
    1)
        # HackTricks: "Inspect a spectrogram early"
        read -p "Target Audio File: " target
        echo -e "${C2}[*] Generating spectrogram with sox...${NC}"
        sox "$target" -n spectrogram -o spectrogram.png
        echo -e "${C3}[+] Saved to spectrogram.png. Open it to look for hidden text/flags.${NC}"
        ;;
    2)
        # HackTricks: "Try common bauds until printable text appears"
        read -p "Target Audio File: " target
        echo -e "${C2}[*] Brute-forcing common baud rates with minimodem...${NC}"
        for baud in 45 110 300 1200 2400; do
            echo -e "${C1}--- Testing Baud: $baud ---${NC}"
            minimodem --rx "$baud" -f "$target" --limit 10
        done
        ;;
    3)
        # HackTricks: "DTMF encodes characters as pairs of fixed frequencies"
        echo -e "${C2}[*] DTMF Detection:${NC}"
        echo " - Logic: Listen for telephone dialing sounds."
        echo " - Recommended Tool: 'dtmf-detect' or online decoders."
        echo " - Link: https://unframework.github.io/dtmf-detect/"
        ;;
    4)
        # HackTricks: "WavSteg: 1 bit per sample (or more)"
        read -p "Target WAV File: " target
        read -p "Bit depth (default 1): " b_depth
        echo -e "${C2}[*] Extracting LSB data...${NC}"
        # Using a python-based WavSteg logic
        python3 -c "
import wave, sys
w = wave.open(sys.argv[1], 'rb')
res = [bin(s)[-int(sys.argv[2]):] for s in list(w.readframes(w.getnframes()))]
print('First 50 bits:', ''.join(res)[:50])" "$target" "${b_depth:-1}"
        ;;
    5)
        # HackTricks: "Confirm codec details and anomalies"
        read -p "Target Audio File: " target
        ffmpeg -v info -i "$target" -f null -
        exiftool "$target"
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/stego/audio.sh
