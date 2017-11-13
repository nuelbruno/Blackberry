/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
// ***********************************************************************************************************
//  SPALSH SCREEN PAGE TO LOAD ON START OF THE APP
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import my.timer 1.0

Container {
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    background: mImagePaintSplash.imagePaint
    bottomPadding: 50.0
    onCreationCompleted: {
        mTimer.start()
    }
    layout: DockLayout {

    }
    Label {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Bottom
        text: mAllStrings.mTapToContinue
        textStyle.fontSize: FontSize.XLarge
        textStyle.color: Color.White
        textStyle.textAlign: TextAlign.Center
    }
    onTouch: {
        if (event.isUp()) {
            mTimer.stop()
            mDialogSplash.close()
        }
    }
    attachedObjects: [
        ImagePaintDefinition {
            id: mImagePaintSplash
            imageSource: "asset:///images/splash/splash.png"
        },
        QTimer {
            id: mTimer
            interval: 5000
            //            singleShot: true
            onTimeout: {
                mTimer.stop()
                console.debug("onTimeout")
                mDialogSplash.close()

            }
        }
    ]
}
