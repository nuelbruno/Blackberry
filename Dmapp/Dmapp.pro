APP_NAME = Dmapp

CONFIG += qt warn_on cascades10
CONFIG += qt warn_on debug_and_release cascades

LIBS += -lmmrndclient -lbbcascadespickers -lbbpim -lbbmultimedia -lbbsystem -lcamapi -lbbdata -lbbcascadesmaps -lQtLocationSubset -lGLESv1_CM -lbbcascadesmultimedia -lbb -lbbdevice -lbbplatform

include(config.pri)
