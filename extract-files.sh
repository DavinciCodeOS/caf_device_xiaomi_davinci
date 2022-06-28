#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        vendor/lib64/hw/camera.qcom.so | vendor/lib64/libmegface.so | vendor/lib64/libFaceDetectpp-0.5.2.so)
            sed -i "s|libmegface.so|libfacedet.so|g" "${2}"
            sed -i "s|libMegviiFacepp-0.5.2.so|libFaceDetectpp-0.5.2.so|g" "${2}"
            sed -i "s|megviifacepp_0_5_2_model|facedetectpp_0_5_2_model|g" "${2}"
            ;;
        vendor/lib64/camera/components/com.arcsoft.node.capturebokeh.so | vendor/lib64/camera/components/com.arcsoft.node.capturefusion.so | \
        vendor/lib64/camera/components/com.arcsoft.node.deflicker.so | vendor/lib64/camera/components/com.arcsoft.node.distortioncorrection.so | \
        vendor/lib64/camera/components/com.arcsoft.node.hdr.so | vendor/lib64/camera/components/com.arcsoft.node.hdrchecker.so | \
        vendor/lib64/camera/components/com.arcsoft.node.realtimebokeh.so | vendor/lib64/camera/components/com.arcsoft.node.smooth_transition.so | \
        vendor/lib64/camera/components/com.arcsoft.node.superlowlight.so | vendor/lib64/libarcsat.so | vendor/lib64/libarcsoft_beautyshot.so | \
        vendor/lib64/libarcsoft_bodyslim.so | vendor/lib64/libarcsoft_distortion_correction.so | vendor/lib64/libarcsoft_dualcam_image_optical_zoom.so | \
        vendor/lib64/libarcsoft_dualcam_refocus.so | vendor/lib64/libarcsoft_dualcam_refocus_front.so | vendor/lib64/libarcsoft_dualcam_refocus_rear_t.so | \
        vendor/lib64/libarcsoft_dualcam_refocus_rear_w.so | vendor/lib64/libarcsoft_high_dynamic_range.so | vendor/lib64/libarcsoft_low_light_hdr.so | \
        vendor/lib64/libarcsoft_portrait_lighting.so | vendor/lib64/libarcsoft_supernight.so | \
        vendor/lib64/libtriplecam_optical_zoom_control.so | vendor/lib64/libtriplecam_video_optical_zoom.so)
            "${PATCHELF}" --replace-needed "libmpbase.so" "libmpbase_vendor.so" "${2}"
            ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=davinci
export DEVICE_COMMON=sm6150-common
export VENDOR=xiaomi

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
