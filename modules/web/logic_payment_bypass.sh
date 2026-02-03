#!/bin/bash
# HackTricks Ref: payment-bypass.md
# Module: Payment Bypass & Price Manipulation

echo -e "${C6}[WEB ATTACK: LOGIC_PAYMENT_BYPASS]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/payment-methods-etc"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Payment Bypass Vector:${NC}"
echo "1) Price Manipulation (Client-side tampering)"
echo "2) Quantity Manipulation (Negative/Large values)"
echo "3) Coupon/Discount Code Reuse"
echo "4) Currency Switching Bypass"
echo "5) Response Manipulation (Success Spoofing)"
echo "0) Exit"

read -p "Selection: " pay_opt

case $pay_opt in
    1)
        echo -e "\n${C2}[*] Price Manipulation:${NC}"
        echo "Intercept the request (Burp Suite) when adding to cart or checking out:"
        echo " - Change 'price=100' to 'price=0.01'"
        echo " - Change 'amount=500' to 'amount=1' in hidden form fields."
        ;;
    2)
        echo -e "\n${C2}[*] Quantity Manipulation:${NC}"
        echo "Try to bypass total calculation using negative numbers:"
        echo " - Item A (100$): quantity=1"
        echo " - Item B (10$):  quantity=-5"
        echo "If the server adds them: 100 + (-50) = 50$ total."
        ;;
    3)
        echo -e "\n${C2}[*] Coupon/Discount Abuse:${NC}"
        echo " - Apply the same coupon multiple times in different tabs."
        echo " - Try to apply a '100% OFF' coupon intended for testing."
        echo " - Predictable codes: WELCOME10, SUMMER2024, TEST_FREE."
        ;;
    4)
        echo -e "\n${C2}[*] Currency Switching:${NC}"
        echo "If the site supports multiple currencies:"
        echo " - Change 'currency=USD' to 'currency=VND' (Vietnamese Dong)"
        echo " - If the numerical value (100) stays the same, you pay 100 VND (~0.004 USD)."
        ;;
    5)
        echo -e "\n${C2}[*] Response Manipulation:${NC}"
        echo "Intercept the response from the payment gateway:"
        echo " - Change 'status=failed' to 'status=success'"
        echo " - Change 'authorized=false' to 'authorized=true'"
        echo "Works if the backend relies solely on the client-side response."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
