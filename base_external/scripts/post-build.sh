#!/bin/bash
# Buildroot post-build script to install GPIO Reader overlay
# This script should be referenced in BR2_ROOTFS_POST_BUILD_SCRIPT

TARGET_DIR=$1
OVERLAY_SOURCE_DIR="$(dirname $0)/../overlays"
OVERLAY_NAME="gpio-rw-overlay"

echo "Installing GPIO-RW Device Tree overlay..."

# Create overlays directory in boot partition
mkdir -p ${TARGET_DIR}/boot/overlays

# Compile and install the overlay
if [ -f "${OVERLAY_SOURCE_DIR}/${OVERLAY_NAME}.dts" ]; then
    # Compile the overlay
    dtc -@ -I dts -O dtb -o ${TARGET_DIR}/../images/rpi-firmware/overlays/${OVERLAY_NAME}.dtbo \
        ${OVERLAY_SOURCE_DIR}/${OVERLAY_NAME}.dts
    
    if [ $? -eq 0 ]; then
        echo "Successfully compiled and installed ${OVERLAY_NAME}.dtbo"
        
        # Add overlay to config.txt if it doesn't exist
        CONFIG_TXT="${TARGET_DIR}/../images/rpi-firmware/config.txt"
        if ! grep -q "dtoverlay=${OVERLAY_NAME}" ${CONFIG_TXT} 2>/dev/null; then
            echo "" >> ${CONFIG_TXT}
            echo "# GPIO-RW overlay" >> ${CONFIG_TXT}
            echo "dtoverlay=${OVERLAY_NAME}" >> ${CONFIG_TXT}
            echo "Added overlay configuration to config.txt"
        fi
    else
        echo "Failed to compile ${OVERLAY_NAME}.dts"
        exit 1
    fi
else
    echo "Warning: ${OVERLAY_NAME}.dts not found"
fi
