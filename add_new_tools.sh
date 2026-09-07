#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 ADDING NEW TOOLS FROM INSTAGRAM POST"
echo "============================================================"
echo ""

# 1. Add Openculture as a resource
echo "📚 Adding Openculture resource..."
cat >> ~/my-automator/modules/advanced.sh << 'AUTO_EOF'

# --- 41. OpenCulture Courses ---
openculture() {
    echo "📚 1,700+ FREE Courses from Top Universities"
    echo "https://www.openculture.com/freeonlinecourses"
    termux-open https://www.openculture.com/freeonlinecourses
    read -p "Press Enter to continue..."
}
AUTO_EOF
echo "   ✅ Openculture added"

# 2. Add RunwayML as a creative tool
echo "🎥 Adding RunwayML..."
cat >> ~/my-automator/modules/advanced.sh << 'AUTO_EOF'

# --- 42. RunwayML ---
runwayml() {
    echo "🎥 RunwayML - AI Content Creation"
    echo "https://runwayml.com"
    termux-open https://runwayml.com
    read -p "Press Enter to continue..."
}
AUTO_EOF
echo "   ✅ RunwayML added"

echo ""
echo "✅ New tools added!"
echo ""
echo "📋 Quick Commands:"
echo "  In automator: options 41 (OpenCulture) and 42 (RunwayML)"
