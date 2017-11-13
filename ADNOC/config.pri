# Config.pri file version 2.0. Auto-generated by IDE. Any changes made by user will be lost!
BASEDIR = $$quote($$_PRO_FILE_PWD_)

device {
    CONFIG(debug, debug|release) {
        profile {
            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        } else {
            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }

    }

    CONFIG(release, debug|release) {
        !profile {
            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }
    }
}

simulator {
    CONFIG(debug, debug|release) {
        !profile {
            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }
    }
}

config_pri_assets {
    OTHER_FILES += \
        $$quote($$BASEDIR/assets/FilterSearchLayout.qml) \
        $$quote($$BASEDIR/assets/Landingscreen.qml) \
        $$quote($$BASEDIR/assets/Report_Video.qml) \
        $$quote($$BASEDIR/assets/Report_camera.qml) \
        $$quote($$BASEDIR/assets/Share.qml) \
        $$quote($$BASEDIR/assets/SlideButton.qml) \
        $$quote($$BASEDIR/assets/SlidePaneList.qml) \
        $$quote($$BASEDIR/assets/autoservice.qml) \
        $$quote($$BASEDIR/assets/bubble.qml) \
        $$quote($$BASEDIR/assets/common/CommmonButtonDarkGrey.qml) \
        $$quote($$BASEDIR/assets/common/CommmonButtonGold.qml) \
        $$quote($$BASEDIR/assets/common/CommmonButtonGreen.qml) \
        $$quote($$BASEDIR/assets/common/CommmonButtonGrey.qml) \
        $$quote($$BASEDIR/assets/common/CommmonButtonRed.qml) \
        $$quote($$BASEDIR/assets/common/CommmonButtonUploadDoc.qml) \
        $$quote($$BASEDIR/assets/common/CommonBackground.qml) \
        $$quote($$BASEDIR/assets/common/CommonBottomMenu.qml) \
        $$quote($$BASEDIR/assets/common/CommonButtonWithImageLabel.qml) \
        $$quote($$BASEDIR/assets/common/CommonHomeRow.qml) \
        $$quote($$BASEDIR/assets/common/CommonLabel.qml) \
        $$quote($$BASEDIR/assets/common/CommonListRow.qml) \
        $$quote($$BASEDIR/assets/common/CommonTextArea.qml) \
        $$quote($$BASEDIR/assets/common/CommonTitleBar.qml) \
        $$quote($$BASEDIR/assets/common/EServicesRow.qml) \
        $$quote($$BASEDIR/assets/common/EServicesRowDropDown.qml) \
        $$quote($$BASEDIR/assets/common/GalleryCategoryRow.qml) \
        $$quote($$BASEDIR/assets/common/LoadingDialog.qml) \
        $$quote($$BASEDIR/assets/common/NewsRow.qml) \
        $$quote($$BASEDIR/assets/common/ShowSystemDialog.qml) \
        $$quote($$BASEDIR/assets/common/uploadDocButton.qml) \
        $$quote($$BASEDIR/assets/contactDetails.qml) \
        $$quote($$BASEDIR/assets/contactus.qml) \
        $$quote($$BASEDIR/assets/feedback.qml) \
        $$quote($$BASEDIR/assets/images/Logo.gif) \
        $$quote($$BASEDIR/assets/images/background/bgLanguage-568h@2x.png) \
        $$quote($$BASEDIR/assets/images/background/bgMainMenu@2x.png) \
        $$quote($$BASEDIR/assets/images/background/bgView.png) \
        $$quote($$BASEDIR/assets/images/background/imgWaterMark.png) \
        $$quote($$BASEDIR/assets/images/background/shadow_right.png) \
        $$quote($$BASEDIR/assets/images/bubble.png) \
        $$quote($$BASEDIR/assets/images/common/bgSearchBar.png) \
        $$quote($$BASEDIR/assets/images/common/bgSearchBar@2x.png) \
        $$quote($$BASEDIR/assets/images/common/bgTextField@2x.png) \
        $$quote($$BASEDIR/assets/images/common/btnBack@2x.png) \
        $$quote($$BASEDIR/assets/images/common/button_grey.png) \
        $$quote($$BASEDIR/assets/images/common/home_bottom_bg.png) \
        $$quote($$BASEDIR/assets/images/common/icnDelete@2x.png) \
        $$quote($$BASEDIR/assets/images/common/icnFavourite@2x.png) \
        $$quote($$BASEDIR/assets/images/common/icnFeedback@2x.png) \
        $$quote($$BASEDIR/assets/images/common/icnFilter.png) \
        $$quote($$BASEDIR/assets/images/common/icnPlus.png) \
        $$quote($$BASEDIR/assets/images/common/icnPlus@2x.png) \
        $$quote($$BASEDIR/assets/images/common/icnSearch.png) \
        $$quote($$BASEDIR/assets/images/common/icnSelectedBlue.png) \
        $$quote($$BASEDIR/assets/images/common/icnSelectedBlue@2x.png) \
        $$quote($$BASEDIR/assets/images/common/icnShare@2x.png) \
        $$quote($$BASEDIR/assets/images/common/icnVideoPlay.png) \
        $$quote($$BASEDIR/assets/images/common/icnVideoPlay@2x.png) \
        $$quote($$BASEDIR/assets/images/common/imgLeftPanel.png) \
        $$quote($$BASEDIR/assets/images/common/imgLeftPanel@2x.png) \
        $$quote($$BASEDIR/assets/images/common/imgMapWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/common/imgNews.png) \
        $$quote($$BASEDIR/assets/images/common/imgPhotoAttachment.png) \
        $$quote($$BASEDIR/assets/images/common/imgPhotoAttachment@2x.png) \
        $$quote($$BASEDIR/assets/images/common/imgRemove@2x.png) \
        $$quote($$BASEDIR/assets/images/common/imgVideoAttachment.png) \
        $$quote($$BASEDIR/assets/images/common/imgVideoAttachment@2x.png) \
        $$quote($$BASEDIR/assets/images/icon_bg_top.png) \
        $$quote($$BASEDIR/assets/images/icon_bg_white_small.png) \
        $$quote($$BASEDIR/assets/images/icon_close_white.png) \
        $$quote($$BASEDIR/assets/images/icon_minus.png) \
        $$quote($$BASEDIR/assets/images/icons/icnEmail@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/icnFavourite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgAnnotation@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgAutoService@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgAutoServiceWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgChangeLanguageWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgContactUs@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgContactUsWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgFavouritesWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgHomeWhite.png) \
        $$quote($$BASEDIR/assets/images/icons/imgHomeWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgListWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgMapWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgNews@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgNewsRowBg@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgNewsWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgOasis@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgOasisWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgOffice@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgOfficeWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgRahalCenter@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgRahalCenterWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgSearch.png) \
        $$quote($$BASEDIR/assets/images/icons/imgSearch@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgSearchWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgServiceStation.png) \
        $$quote($$BASEDIR/assets/images/icons/imgServiceStation@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgServiceStationWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgVehicleInspection@2x.png) \
        $$quote($$BASEDIR/assets/images/icons/imgVehicleInspectionWhite@2x.png) \
        $$quote($$BASEDIR/assets/images/imgContactBanner@2x.png) \
        $$quote($$BASEDIR/assets/images/share/bg_copyclip.png) \
        $$quote($$BASEDIR/assets/images/share/bg_email.png) \
        $$quote($$BASEDIR/assets/images/share/bg_fb.png) \
        $$quote($$BASEDIR/assets/images/share/bg_sms.png) \
        $$quote($$BASEDIR/assets/images/share/bg_twit.png) \
        $$quote($$BASEDIR/assets/images/share/email.png) \
        $$quote($$BASEDIR/assets/images/share/icon_copyclip.png) \
        $$quote($$BASEDIR/assets/images/share/icon_email.png) \
        $$quote($$BASEDIR/assets/images/share/icon_email_1.png) \
        $$quote($$BASEDIR/assets/images/share/icon_fb.png) \
        $$quote($$BASEDIR/assets/images/share/icon_sms.png) \
        $$quote($$BASEDIR/assets/images/share/icon_sms_1.png) \
        $$quote($$BASEDIR/assets/images/share/icon_twit.png) \
        $$quote($$BASEDIR/assets/images/share/sms.png) \
        $$quote($$BASEDIR/assets/images/url.png) \
        $$quote($$BASEDIR/assets/main.qml) \
        $$quote($$BASEDIR/assets/mapLocation.qml) \
        $$quote($$BASEDIR/assets/myFavourites.qml) \
        $$quote($$BASEDIR/assets/newsDetailsView.qml) \
        $$quote($$BASEDIR/assets/newsListing.qml) \
        $$quote($$BASEDIR/assets/oasis.qml) \
        $$quote($$BASEDIR/assets/pin.qml) \
        $$quote($$BASEDIR/assets/pin_current.qml) \
        $$quote($$BASEDIR/assets/serviceStation.qml) \
        $$quote($$BASEDIR/assets/sql/ADNOC.sqlite) \
        $$quote($$BASEDIR/assets/stationDetails.qml) \
        $$quote($$BASEDIR/assets/vehicleInsepction.qml)
}

config_pri_source_group1 {
    SOURCES += \
        $$quote($$BASEDIR/src/ADNOC.cpp) \
        $$quote($$BASEDIR/src/ADNOCwebservice.cpp) \
        $$quote($$BASEDIR/src/DatabaseConnectionApi.cpp) \
        $$quote($$BASEDIR/src/MapViewDemo.cpp) \
        $$quote($$BASEDIR/src/StationListData.cpp) \
        $$quote($$BASEDIR/src/StatusEventHandler.cpp) \
        $$quote($$BASEDIR/src/TimerCount.cpp) \
        $$quote($$BASEDIR/src/WebImageView.cpp) \
        $$quote($$BASEDIR/src/applicationui.cpp) \
        $$quote($$BASEDIR/src/main.cpp) \
        $$quote($$BASEDIR/src/qtsoap/qtsoap.cpp)

    HEADERS += \
        $$quote($$BASEDIR/src/ADNOC.hpp) \
        $$quote($$BASEDIR/src/ADNOCwebservice.hpp) \
        $$quote($$BASEDIR/src/DatabaseConnectionApi.h) \
        $$quote($$BASEDIR/src/MapViewDemo.hpp) \
        $$quote($$BASEDIR/src/StationListData.h) \
        $$quote($$BASEDIR/src/StatusEventHandler.h) \
        $$quote($$BASEDIR/src/TimerCount.hpp) \
        $$quote($$BASEDIR/src/WebImageView.h) \
        $$quote($$BASEDIR/src/applicationui.hpp) \
        $$quote($$BASEDIR/src/qtsoap/qtsoap.h)
}

CONFIG += precompile_header

PRECOMPILED_HEADER = $$quote($$BASEDIR/precompiled.h)

lupdate_inclusion {
    SOURCES += \
        $$quote($$BASEDIR/../src/*.c) \
        $$quote($$BASEDIR/../src/*.c++) \
        $$quote($$BASEDIR/../src/*.cc) \
        $$quote($$BASEDIR/../src/*.cpp) \
        $$quote($$BASEDIR/../src/*.cxx) \
        $$quote($$BASEDIR/../src/qtsoap/*.c) \
        $$quote($$BASEDIR/../src/qtsoap/*.c++) \
        $$quote($$BASEDIR/../src/qtsoap/*.cc) \
        $$quote($$BASEDIR/../src/qtsoap/*.cpp) \
        $$quote($$BASEDIR/../src/qtsoap/*.cxx) \
        $$quote($$BASEDIR/../assets/*.qml) \
        $$quote($$BASEDIR/../assets/*.js) \
        $$quote($$BASEDIR/../assets/*.qs) \
        $$quote($$BASEDIR/../assets/common/*.qml) \
        $$quote($$BASEDIR/../assets/common/*.js) \
        $$quote($$BASEDIR/../assets/common/*.qs) \
        $$quote($$BASEDIR/../assets/images/*.qml) \
        $$quote($$BASEDIR/../assets/images/*.js) \
        $$quote($$BASEDIR/../assets/images/*.qs) \
        $$quote($$BASEDIR/../assets/images/background/*.qml) \
        $$quote($$BASEDIR/../assets/images/background/*.js) \
        $$quote($$BASEDIR/../assets/images/background/*.qs) \
        $$quote($$BASEDIR/../assets/images/common/*.qml) \
        $$quote($$BASEDIR/../assets/images/common/*.js) \
        $$quote($$BASEDIR/../assets/images/common/*.qs) \
        $$quote($$BASEDIR/../assets/images/icons/*.qml) \
        $$quote($$BASEDIR/../assets/images/icons/*.js) \
        $$quote($$BASEDIR/../assets/images/icons/*.qs) \
        $$quote($$BASEDIR/../assets/images/share/*.qml) \
        $$quote($$BASEDIR/../assets/images/share/*.js) \
        $$quote($$BASEDIR/../assets/images/share/*.qs) \
        $$quote($$BASEDIR/../assets/sql/*.qml) \
        $$quote($$BASEDIR/../assets/sql/*.js) \
        $$quote($$BASEDIR/../assets/sql/*.qs)

    HEADERS += \
        $$quote($$BASEDIR/../src/*.h) \
        $$quote($$BASEDIR/../src/*.h++) \
        $$quote($$BASEDIR/../src/*.hh) \
        $$quote($$BASEDIR/../src/*.hpp) \
        $$quote($$BASEDIR/../src/*.hxx)
}

TRANSLATIONS = $$quote($${TARGET}_ar.ts) \
    $$quote($${TARGET}.ts)