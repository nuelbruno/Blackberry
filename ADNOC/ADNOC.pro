APP_NAME = ADNOC

CONFIG += qt warn_on cascades10
CONFIG += qt warn_on debug_and_release cascades
CONFIG += mobility

 LIBS += -lbbplatform -lbbdata -lbbsystem -lbbpim -lcamapi -lQtLocationSubset -lbbcascadesmaps -lGLESv1_CM -lbb -lbbcascadesmultimedia -lbbmultimedia -lbbcascadespickers

QT += xml

TRANSLATIONS += \
    $${TARGET}_ar_EG.ts \
    $${TARGET}_fr.ts \
    $${TARGET}_en.ts     

include(config.pri)

device {
    CONFIG(debug, debug|release) {
        # Device-Debug custom configuration
    }

    CONFIG(release, debug|release) {
        # Device-Release custom configuration
    }
}

simulator {
    CONFIG(debug, debug|release) {
        # Simulator-Debug custom configuration
    }
}