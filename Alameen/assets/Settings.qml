import bb.cascades 1.0


Page {
    
    id: settingsPage
    
    signal languageChanged()
    
    property string mLanguageCode
    property string mLangCode
    
    
    property alias mLabelChangeLanguageValue: mLabelChangeLanguageValue.text
    
    
    property string userName
    
    titleBar: TitleBar {
        title:  qsTr("Settings") + Retranslate.onLanguageChanged
    }
    onCreationCompleted: {
        mLanguageCode = _MOL.getValueFor("mLanguageCode", "en")
        if (mLanguageCode != "en") {
            mLangCode = "0"
        } else {
            mLangCode = "1"
        }
    }
    
    Container {
        id: msettinglanguage
        //    background: Color.Transparent
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        background: Color.create("#353333")
        topPadding: 20.0
        bottomPadding: 20.0
        
        onCreationCompleted: {
           
        }
        

        Label {
            id: mLabelAbout
            text: qsTr("Change to Arabic") + Retranslate.onLanguageChanged
            horizontalAlignment: HorizontalAlignment.Center 
            verticalAlignment: VerticalAlignment.Center
            textStyle.color: Color.create("#03879e")
            preferredHeight: 20
            leftPadding: 20
            rightPadding: 20
            maxWidth: 745
            minWidth: 745
            
        
        }
        Label {
            id: mLabelChangeLanguageValue
            text:  qsTr(mLanguageCode != "en" ? "English" : "العربية") + Retranslate.onLanguageChanged
            textStyle.color: Color.White
            textStyle.fontWeight: FontWeight.Bold
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            maxWidth: 745
            minWidth: 745
            leftPadding: 20
            rightPadding: 20
            onTouch: {
                if (event.isUp()) {
                    
                    languageChanged()
                }
            }
        }
    
    }
    onLanguageChanged: {
            
        if (_MOL.getValueFor("mLanguageCode", "en") == "en") {
            _MOL.updateLocale("ar")
            _MOL.saveValueFor("mLanguageCode", "ar")
            mLabelChangeLanguageValue.text = qsTr("English")
        } else {
            _MOL.updateLocale("en-US")
            _MOL.saveValueFor("mLanguageCode", "en")
            mLabelChangeLanguageValue.text = qsTr("العربية")
        }
       
    }
    
}