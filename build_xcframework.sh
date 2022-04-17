#!/bin/bash

CURRENT_PATH="$(pwd)"
SCHEME=GRPCInteractor
ARCHIVE_PATH_IOS="${CURRENT_PATH}/archives/${FINAL_NAME}-iOS"
ARCHIVE_PATH_IOS_SIMULATOR="${CURRENT_PATH}/archives/${FINAL_NAME}-iOS-simulator"
FINAL_NAME=GRPCInteractor

# iOS devices
xcodebuild archive \
    -scheme ${SCHEME} \
    -archivePath "${ARCHIVE_PATH_IOS}.xcarchive" \
    -destination "generic/platform=iOS" \
    -sdk iphoneos \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# iOS simulators
xcodebuild archive \
    -scheme ${SCHEME} \
    -archivePath "${ARCHIVE_PATH_IOS_SIMULATOR}.xcarchive" \
    -destination "generic/platform=iOS Simulator" \
    -sdk iphonesimulator \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
    -framework "${ARCHIVE_PATH_IOS}.xcarchive/Products/Library/Frameworks/${FINAL_NAME}.framework" \
    -framework "${ARCHIVE_PATH_IOS_SIMULATOR}.xcarchive/Products/Library/Frameworks/${FINAL_NAME}.framework" \
    -output "${FINAL_NAME}.xcframework"