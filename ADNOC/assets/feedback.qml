import bb.cascades 1.2
import ADNOCwebservice 1.0
import bb.system 1.0
import "common"
import WebImageView 1.0
import bb.cascades.pickers 1.0
import bb.cascades.multimedia 1.0
import bb.multimedia 1.0
import bb.DatabaseConnectionApi.data 1.0

Page {
    
    property int currentTask: -1
    property int intSELECT: 0
    property int intUPDATE: 1
    property int intDELETE: 2
    property int intLOAD: -1
    property string mLanguageBool
    property string mLanguageCode
    
    function stationFeedpass(station, title, method)
    {
        locationDropdown.enabled = true;  
        if(method == "station")
        {
            locationDropdown.enabled = false;  
        }
        var title = station +" "+title; 
        var optV = option.createObject(); //
        optV.text = title;
        optV.value = title; // Needs to be an 'Option' before the DropDown will accept it
        locationDropdown.add(optV);
        locationDropdown.setSelectedOption(optV);
        Qt.locationDropdownvalue = title;
    }
    property string stationCode
    onCreationCompleted: {
        Qt.locationTitle = "";
        Qt.image1upload = '';
        Qt.image2upload = '';
        Qt.image3upload = '';
        Qt.image4upload = '';
        Qt.video1upload = '';
        Qt.videoCount = 0;
        Qt.iamgecouny = 0;
        Qt.DeleteImageCount1 = 0;
        Qt.DeleteImageCount2 = 0;
        Qt.DeleteImageCount3 = 0;
        Qt.DeleteImageCount4 = 0;
        photo1Container.visible = false;
        photo2Container.visible = false;
        photo3Container.visible = false;       
        Qt.locationDropdownvalue = "";
        locationDropdown.enabled = true;  
        
        mLanguageCode = _ADNOC.getValueFor("mLanguageCode", "en");
        Qt.languageset = mLanguageCode;
        mLanguageBool =  (mLanguageCode == "en")? "1" : "2";
        
        if(_ADNOC.isNetworkAvailable())
        {
            aADNOCwebservice.statisticsADNOC('', "Feedback Form", "Get");
        }
        
        
    }
    Container {
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            Container {
                id: mainContainer
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                minHeight: 120
                maxHeight: minHeight
                background: Color.create("#0088CE")
                //topMargin: 30.0
                topPadding: 32.0
                Label {
                    id: mLabelHome
                    text: qsTr("Feedback") + Retranslate.onLanguageChanged
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    //textStyle.fontWeight: FontWeight.Bold
                    textStyle.fontSize: FontSize.Large
                    textStyle.color: Color.create("#FFFFFF")
                }
            }
            Container {
                id: containerMain
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                background: Color.create("#F3F3F3")
                layout: DockLayout {
                }

                LoadingDialog {

                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    active: aADNOCwebservice.active
                }
            }
            ScrollView {
                scrollViewProperties.scrollMode: ScrollMode.Vertical
                id: mScrollViewTab

                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    background: mBackgroundImage.imagePaint
                    preferredWidth: 800
                    //bottomPadding: 0
                    preferredHeight: 1500

                    Container {
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        rightPadding: 60.0
                        leftPadding: 23.0
                        topPadding: 20.0
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }

                        DropDown {
                            topPadding: 20.0
                            topMargin: 20.0
                            id: typeDropdown

                            title: qsTr("Select type") + Retranslate.onLanguageChanged
                            enabled: true
                            Option {
                                value: "Complaint"
                                text: "Complaint"
                            }
                            Option {
                                value: "Inquiry"
                                text: "Inquiry"
                            }
                            Option {
                                value: "Suggestion"
                                text: "Suggestion"
                            }
                            //expanded:
                            //expanded: true
                            onSelectedIndexChanged: {
                                //console.log("SelectedIndex was changed to " + typeDropdown.selectedValue);
                                //getDateLeavedays();
                            }

                            onTouch: {
                                if (event.isUp()) {

                                }
                            }

                        }

                        TextField {
                            id: subjectTxt
                            hintText: qsTr("Subject") + Retranslate.onLanguageChanged
                            //inputMode: TextFieldInputMode.EmailAddress
                        }
                        TextField {
                            id: nameTxt
                            hintText: qsTr("Name") + Retranslate.onLanguageChanged
                            //inputMode: TextFieldInputMode.EmailAddress
                        }
                        TextField {
                            id: emailTxt
                            hintText: qsTr("Email") + Retranslate.onLanguageChanged
                            inputMode: TextFieldInputMode.EmailAddress
                        }
                        TextField {
                            id: mobileTxt
                            hintText: qsTr("Mobile") + Retranslate.onLanguageChanged
                            //inputMode: TextFieldInputMode.EmailAddress
                        }
                        DropDown {
                            id: locationDropdown
                            topPadding: 20.0
                            topMargin: 20.0

                            title: qsTr("Location") + Retranslate.onLanguageChanged
                            enabled: true
                            //expanded:
                            //expanded: true
                            onSelectedIndexChanged: {
                                //console.log("SelectedIndex was changed to " + typeDropdown.selectedValue);
                                //getDateLeavedays();
                            }

                            onTouch: {
                                if (event.isUp()) {
                                    mySheet.open();
                                }
                            }

                        }
                        TextArea {
                            id: descriptionTxt
                            hintText: qsTr("Description") + Retranslate.onLanguageChanged
                            maxHeight: 80
                            minHeight: maxHeight
                        }
                        Container {
                            // topPadding: 10.0
                            topMargin: 10.0
                            bottomMargin: 20.0
                            preferredHeight: 60
                            leftPadding: 215.0
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            background: mImagePaintTextBoxborder.imagePaint
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            ImageView {
                                imageSource: "asset:///images/common/imgPhotoAttachment@2x.png"
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                            }
                            CommonLabel {
                                id: attachPhoto
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                                text: qsTr("Attach Photos") + Retranslate.onLanguageChanged
                                textStyle.color: Color.create("#FFFFFF")
                            }
                            onTouch: {
                                if (event.isUp()) {
                                    if(Qt.iamgecouny == 2){
                                        customAlert.body = qsTr("Max Image upload limit reached") + Retranslate.onLanguageChanged;
                                        customAlert.show(); 
                                    }else{
                                        if (! listDialog.created) {
                                            listDialog.appendItem(qsTr("Using Camera") + Retranslate.onLanguageChanged)
                                            listDialog.appendItem(qsTr("Select from gallery") + Retranslate.onLanguageChanged)
                                            //listDialog.appendItem(qsTr("C") + Retranslate.onLanguageChanged)
                                            listDialog.created = true
                                        }
                                        listDialog.show()
                                    }
                                }
                            }
                        }
                        Container {
                            //background: Color.create("#FFFFFF")
                            id: photoBoxscroll
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            //preferredWidth: 740
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }

                            Container {
                                id: photo1Container
                                objectName: "photo1Container"
                                visible: false
                                topPadding: 0.0
                                leftPadding: 0.0
                                maxHeight: 100
                                minHeight: 100
                                maxWidth: 130
                                minWidth: 130
                                background: Color.create("#FFFFFF")
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Top
                                layout: DockLayout {
                                    //orientation: LayoutOrientation.TopToBottom
                                }
                                ImageView {
                                    id: photoDeleteImg1
                                    //visible: false
                                    
                                    imageSource: "asset:///images/common/imgRemove@2x.png"
                                    horizontalAlignment: HorizontalAlignment.Right
                                    verticalAlignment: VerticalAlignment.Top 
                                    preferredHeight: 30
                                    preferredWidth: 40                             
                                }
                                ImageView {
                                    id: photoImageview1
                                    objectName: "photoImageview1"
                                    //visible: false
                                    //imageSource: "file://accounts/1000/shared/camera/IMG_20140809_080811.jpg"
                                    preferredHeight: 130
                                    preferredWidth: 130

                                }

                            }
                            Container {
                                id: photo2Container
                                objectName: "photo2Container"
                                visible: false
                                topPadding: 10.0
                                leftPadding: 10.0
                                leftMargin: 20.0
                                background: Color.create("#FFFFFF")
                                maxHeight: 100
                                minHeight: 100
                                maxWidth: 130
                                minWidth: 130
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Top
                                layout: DockLayout {
                                    //orientation: LayoutOrientation.TopToBottom
                                }
                                ImageView {
                                    id: photoDeleteImg2
                                    //visible: false
                                    imageSource: "asset:///images/common/imgRemove@2x.png"
                                    horizontalAlignment: HorizontalAlignment.Right
                                    verticalAlignment: VerticalAlignment.Top 
                                    preferredHeight: 30
                                    preferredWidth: 40                             
                                }
                                ImageView {
                                    id: photoImageview2
                                    objectName: "photoImageview2"
                                    //visible: false
                                    //imageSource: "asset:///images/bottom_icons_bg.jpg"
                                    preferredHeight: 130
                                    preferredWidth: 130
                                
                                }
                               
                            }
                        }
                        Container {
                            // topPadding: 10.0
                            topMargin: 10.0
                            bottomMargin: 20.0
                            preferredHeight: 60
                            leftPadding: 225.0
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            background: mImagePaintTextBoxborder.imagePaint
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            ImageView {
                                imageSource: "asset:///images/common/imgVideoAttachment@2x.png"
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                            }
                            CommonLabel {
                                id: attchvideo
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                                text: qsTr("Attach Video") + Retranslate.onLanguageChanged
                                textStyle.color: Color.create("#FFFFFF")
                            }
                            onTouch: {
                                if (event.isUp()) {
                                    if(Qt.videoCount == 1){
                                        customAlert.body = qsTr("Max Video upload limit reached") + Retranslate.onLanguageChanged;
                                        customAlert.show(); 
                                    }else{
                                        if (! listDialogVideo.created) {
                                            listDialogVideo.appendItem(qsTr("Using Camera") + Retranslate.onLanguageChanged)
                                            listDialogVideo.appendItem(qsTr("Select from gallery") + Retranslate.onLanguageChanged)
                                            //listDialog.appendItem(qsTr("C") + Retranslate.onLanguageChanged)
                                            listDialogVideo.created = true
                                        }
                                        listDialogVideo.show()
                                    }
                                }
                            }
                        }
                        Container {
                            id: photo3Container
                            objectName: "photo3Container"
                            visible: false
                            topPadding: 10.0
                            leftPadding: 10.0
                            leftMargin: 20.0
                            background: Color.create("#FFFFFF")
                            maxHeight: 100
                            minHeight: 100
                            maxWidth: 130
                            minWidth: 130
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Top
                            layout: DockLayout {
                                //orientation: LayoutOrientation.TopToBottom
                            }
                            ImageView {
                                id: photoDeleteImg3
                                //visible: false
                                objectName: "photoDeleteImg3"
                                imageSource: "asset:///images/common/imgRemove@2x.png"
                               // horizontalAlignment: HorizontalAlignment.Right
                                verticalAlignment: VerticalAlignment.Top 
                                preferredHeight: 30
                                preferredWidth: 40                             
                            }
                            ImageView {
                                id: photoImageview3
                                objectName: "photoImageview3"
                                //visible: false
                                imageSource: "asset:///images/common/icnVideoPlay@2x.png"
                                preferredHeight: 130
                                preferredWidth: 130
                            
                            }
                        
                        }
                        Container {
                            topMargin: 20.0
                            bottomMargin: 20.0
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }

                            Container {
                                topPadding: 5.0
                                preferredHeight: 60
                                //rightMargin: 30.0
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill
                                background: mImagePaintTextBoxborder.imagePaint
                                layout: StackLayout {
                                    //orientation: LayoutOrientation.LeftToRight
                                }
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 5
                                }
                                CommonLabel {
                                    id: submitButton
                                    horizontalAlignment: HorizontalAlignment.Center
                                    verticalAlignment: VerticalAlignment.Center
                                    text: qsTr("Submit") + Retranslate.onLanguageChanged
                                    textStyle.color: Color.create("#FFFFFF")
                                }
                                onTouch: {
                                    if (event.isUp()) {
                                        
                                        console.log("text fild value"+ subjectTxt.text)
                                        
                                        var typeselection  = typeDropdown.selectedValue;
                                        
                                        var locationDropdown = Qt.locationDropdownvalue;
                                        
                                        if(typeselection == "")
                                        {
                                            customAlert.body = qsTr("Please select the Type") + Retranslate.onLanguageChanged;
                                            customAlert.show();  
                                        }else if(subjectTxt.text == ""){
                                            customAlert.body = qsTr("Please enter subject") + Retranslate.onLanguageChanged;
                                            customAlert.show();  
                                        }else if(nameTxt.text == ""){
                                            customAlert.body = qsTr("Please enter name") + Retranslate.onLanguageChanged;
                                            customAlert.show();  
                                        }
                                        else if(emailTxt.text == ""){
                                            customAlert.body = qsTr("Please enter email") + Retranslate.onLanguageChanged;
                                            customAlert.show();  
                                        }
                                        else if(mobileTxt.text == ""){
                                            customAlert.body = qsTr("Please enter mobile") + Retranslate.onLanguageChanged;
                                            customAlert.show();  
                                        }
                                        else if(locationDropdown == ""){
                                            customAlert.body = qsTr("Please choose location") + Retranslate.onLanguageChanged;
                                            customAlert.show();  
                                        }
                                        else if(descriptionTxt.text == ""){
                                            customAlert.body = qsTr("Please enter description") + Retranslate.onLanguageChanged;
                                            customAlert.show();  
                                        }
                                        else{
                                            aADNOCwebservice.submitFeedbackForm(Qt.image1upload,  Qt.image2upload, Qt.video1upload, nameTxt.text, emailTxt.text, mobileTxt.text, typeselection, locationDropdown, subjectTxt.text, descriptionTxt.text, "1"); 
                                            aADNOCwebservice.dataLoaded.connect(sendStatistics);
                                        }

                                    }
                                }
                                function  sendStatistics()
                                {
                                    if(_ADNOC.isNetworkAvailable())
                                    {
                                        aADNOCwebservice.statisticsADNOC(locationDropdown, "Feedback Submit", "Post");
                                    }
                                    mNavigationPaneMain.pop();
                                }
                            }
                            Container {
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill
                                layout: StackLayout {
                                    //orientation: LayoutOrientation.LeftToRight
                                }
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                            }
                            Container {
                                topPadding: 5.0
                                preferredHeight: 60

                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill
                                background: mImagePaintTextBoxborder.imagePaint
                                layout: StackLayout {
                                    //orientation: LayoutOrientation.LeftToRight
                                }
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 5
                                }
                                CommonLabel {
                                    id: cancelButton
                                    horizontalAlignment: HorizontalAlignment.Center
                                    verticalAlignment: VerticalAlignment.Center
                                    text: qsTr("Cancel") + Retranslate.onLanguageChanged
                                    textStyle.color: Color.create("#FFFFFF")
                                }
                                onTouch: {
                                    if (event.isUp()) {
                                        mNavigationPaneMain.pop();
                                    }
                                }
                            }
                        }
                    } //  content holding container
                }
            }

        } // main top to bottom stack layout
    }

    attachedObjects: [
        ADNOCwebservice {
            id: aADNOCwebservice
        },
        ImagePaintDefinition {
            id: mBackgroundImage
            imageSource: "asset:///images/background/bgView.png"
        },
        ImagePaintDefinition {
            id: mImagePaintTextBoxborder
            imageSource: "asset:///images/common/button_grey.png"
        },
        SystemDialog {
            id: customAlert
            title: qsTr("Alert") + Retranslate.onLanguageChanged
            //body: qsTr("Request saved successfully.") + Retranslate.onLanguageChanged
            cancelButton.label: undefined
            confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
            //buttons: [ok]
            onFinished: {
            
            }
        },
        SystemListDialog {
            property bool created: false
            id: listDialog
            title: qsTr("Upload Options") + Retranslate.onLanguageChanged
            selectionMode: ListSelectionMode.Single

            confirmButton.label: qsTr("Ok") + Retranslate.onLanguageChanged
            cancelButton.label: qsTr("Cancel") + Retranslate.onLanguageChanged
            onFinished: {
                if (listDialog.result == SystemUiResult.ConfirmButtonSelection) {
                    console.log("Selected Value" + listDialog.selectedIndices);
                    if (listDialog.selectedIndices == 0) {
                        var cameraPhoto = reportCamera.createObject();
                        mNavigationPaneMain.push(cameraPhoto);
                        //cameraPhoto.inputData(imageCOUNT);
                    }
                    if (listDialog.selectedIndices == 1) {
                        picker.open();
                    }

                } else if (listDialog.result == SystemUiResult.CancelButtonSelection) {
                    console.log("Selected Value" + listDialog.result);
                    listDialog.cancel();
                    listDialog.clearButtons();
                }
            }
        },
        SystemListDialog {
            property bool created: false
            id: listDialogVideo
            title: qsTr("Upload Options") + Retranslate.onLanguageChanged
            selectionMode: ListSelectionMode.Single

            confirmButton.label: qsTr("Ok") + Retranslate.onLanguageChanged
            cancelButton.label: qsTr("Cancel") + Retranslate.onLanguageChanged
            onFinished: {
                if (listDialog.result == SystemUiResult.ConfirmButtonSelection) {
                    console.log("Selected Value" + listDialog.selectedIndices);
                    if (listDialog.selectedIndices == 0) {
                        var cameraVideo = reportVideo.createObject();
                        mNavigationPaneMain.push(cameraVideo)
                    }
                    if (listDialog.selectedIndices == 1) {
                        pickerVidoe.open();
                    }

                } else if (listDialog.result == SystemUiResult.CancelButtonSelection) {
                    console.log("Selected Value" + listDialog.result);
                    listDialog.cancel();
                    listDialog.clearButtons();
                }
            }
        },
        ComponentDefinition {
            id: reportCamera

            source: "Report_camera.qml"
        },
        ComponentDefinition {
            id: reportVideo
            source: "Report_Video.qml"
        },
        FilePicker {
            id: picker
            type: FileType.Picture
            property string selectedFile

            title: qsTr("Upload Options")

            onFileSelected: {
                var selectedFile = selectedFiles[0]
                Qt.iamgecouny =  Qt.iamgecouny +1;
                if(Qt.iamgecouny == 1)
                {
                    Qt.image1upload = selectedFile;
                }
                else if(Qt.iamgecouny == 2)
                {
                    Qt.image2upload = selectedFile;
                }
                
                console.debug("file selected file upload-------------------------------- :" + selectedFile);
                _ADNOC.manipulatePhoto(selectedFile, Qt.iamgecouny,1);

            }
        },
        FilePicker {
            id: pickerVidoe
            type: FileType.Video
            property string selectedFile

            title: qsTr("Upload Options")

            onFileSelected: {
                var selectedFile = selectedFiles[0]

                var selectedFile = selectedFiles[0]
                Qt.videoCount =  Qt.videoCount +1;
                if(Qt.videoCount == 1)
                {
                    Qt.video1upload = selectedFile;
                }
                
                
                console.debug("file selected file upload-------------------------------- :" + selectedFile);
                _ADNOC.manipulatePhoto(selectedFile, Qt.videoCount,2);

            }
        },
        Sheet {
            id: mySheet
            content: Page {
                onCreationCompleted: {
                    var longitude = _ADNOC.getValueFor("longitude", "")
                    var latitude = _ADNOC.getValueFor("latitude", "")
                    Qt.CurrentLatitude = "25.111917";
                    Qt.CurrentLongitude = "55.385406";
                    //aADNOCwebservice.searchNearByLocation(Qt.CurrentLatitude, Qt.CurrentLongitude, "1", "", "MAP");
                    mLanguageBool =  (Qt.languageset == "en")? "1" : "2";
                    mCustomeDataSource.query = "SELECT * FROM tbl_services WHERE  language_id = '"+mLanguageBool+"' "
                    mCustomeDataSource.load();  
                }

                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    topPadding: 0.0
                    leftPadding: 0.0
                    rightPadding: 0.0
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    }
                    Container {
                        // topPadding: 10.0
                        topMargin: 10.0
                        leftPadding: 20.0
                        preferredHeight: 60
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        background: mImagePaintTextBoxborder.imagePaint
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }

                        CommonLabel {
                            id: hideLocation
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                            text: qsTr("Hide") + Retranslate.onLanguageChanged
                            textStyle.color: Color.create("#FFFFFF")
                        }
                        
                        ImageView {
                            imageSource: "asset:///images/common/btnBack@2x.png"
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        
                        onTouch: {
                            if (event.isUp()) {
                                mySheet.close()
                            }
                        }
                    }
                    Container {

                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        minHeight: 120
                        background: mBgsearchImagePaint.imagePaint
                        maxHeight: minHeight
                        //topMargin: 30.0
                        topPadding: 22.0
                        layout: DockLayout {
                        }
                        Container {
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            topPadding: 0.0
                            leftPadding: 0.0
                            rightPadding: 0.0
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Container {
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 4
                                }
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill
                                leftPadding: 20.0
                                topPadding: 0.0
                                layout: DockLayout {
                                }
                                ImageView {
                                    horizontalAlignment: HorizontalAlignment.Left
                                    imageSource: "asset:///images/common/bgTextField@2x.png"
                                    preferredWidth: 600
                                }
                                TextField {
                                    id: search
                                    backgroundVisible: false
                                    preferredWidth: 560
                                }
                                Container {
                                    rightMargin: 10.0
                                    rightPadding: 10.0
                                    topMargin: 13.0
                                    topPadding: 13.0
                                    horizontalAlignment: HorizontalAlignment.Right
                                    //verticalAlignment: VerticalAlignment.Center
                                    ImageView {
                                        imageSource: "asset:///images/common/icnSearch.png"
                                        preferredHeight: 40
                                        preferredWidth: 40
                                    }
                                    onTouch: {
                                        if (event.isUp()) {
                                            //pinContainer.removeAll();
                                            //aADNOCwebservice.searchDataNearBylocation(search.text, "search");
                                          
                                                if (search.text.replace(new RegExp(" ", 'g'), "").length > 0) {
                                                    currentTask = intSELECT;
                                                    mCustomeDataSource.query = "SELECT * FROM tbl_services where station_code  like \"%" + search.text + "%\" OR title  like \"%" + search.text + "%\""
                                                    mCustomeDataSource.load();
                                                } else {
                                                    currentTask = intLOAD;
                                                    mCustomeDataSource.query = "SELECT * FROM tbl_services"
                                                    mCustomeDataSource.load();
                                                }
                                            
                                        }
                                    }
                                }
                            }
                            Container {
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                                leftPadding: 23.0
                                //horizontalAlignment: HorizontalAlignment.
                                topMargin: 13.0
                                topPadding: 13.0

                                ImageView {
                                    imageSource: "asset:///images/common/icnFilter.png"
                                    preferredWidth: 40
                                    preferredHeight: 40
                                }

                                onTouch: {
                                    if (event.isUp()) {
                                        console.log("filter search popup");
                                        // mContainerMiddle.visible = true;
                                        mDialogCommonList.open();
                                        //aADNOCwebservice.ClearMapdata();
                                        //pinContainer.removeAll();
                                        //_ADNOC.clearPins(mapview);
                                    }
                                }
                            }
                        }

                    }

                    Container {
                        id: listViewContainer
                        layout: AbsoluteLayout {
                        }
                        preferredWidth: 770
                        preferredHeight: 1050
                        //background: Color.create(0.5, 0.5, 0.5)
                        visible: true
                        ListView {
                            id: listView
                            dataModel: groupdata
                            scrollRole: ScrollRole.Default

                            listItemComponents: [

                                ListItemComponent {
                                    type: "item"
                                    CustomListItem {
                                        id: itemRoot
                                        dividerVisible: true
                                        highlightAppearance: HighlightAppearance.Frame
                                        Container {
                                            leftPadding: 30.0
                                            layout: DockLayout {

                                            }
                                            Label {
                                                //topPadding: 5.0
                                                text: ListItemData.station_code + " " + ListItemData.title
                                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                                textStyle.color: Color.create("#000000")

                                            }
                                            Container {
                                                topPadding: 50.0
                                                Label {
                                                    id: kmAway

                                                    textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                                    textStyle.color: Color.create("#000000")
                                                    onCreationCompleted: {
                                                        //parseFloat(distance).toFixed(2);
                                                        kmAway.text = parseFloat(ListItemData.distance).toFixed(2) + qsTr(" Km Away") + Retranslate.onLanguageChanged;
                                                    }
                                                }
                                            }
                                        }
                                    }

                                }

                            ]
                            onTriggered: {
                                var chosenItem = dataModel.data(indexPath);
                                console.debug('qml list out put' + chosenItem.title);
                                var optV = option.createObject(); //
                                optV.text = chosenItem.title;
                                optV.value = chosenItem.title; // Needs to be an 'Option' before the DropDown will accept it
                                locationDropdown.add(optV);
                                locationDropdown.setSelectedOption(optV);
                                Qt.locationDropdownvalue = chosenItem.title;
                                mySheet.close();
                            }

                        }
                    }
                }
            }
            attachedObjects: [
                GroupDataModel {
                    id: groupdata
                    grouping: ItemGrouping.None
                },
                DatabaseConnectionApi {
                    id: mCustomeDataSource
                    source: "sql/ADNOC.sqlite"
                    //query: "SELECT * FROM tbl_favourite"
                    connection: "mCustomeDataSourceInsert"
                    onDataLoaded: {
                        if (currentTask == intSELECT || currentTask == intLOAD) {
                            groupdata.clear();
                            console.log("sql data pass" + JSON.stringify(data));
                            groupdata.insertList(data);
                            //intTotalDataCount = data.length;
                            listView.dataModelChanged(groupdata);
                           
                        
                        }
                        else if (currentTask == intDELETE) {
                        q
                        }
                    
                    }
                }
            ]
        },
        ImagePaintDefinition {
            id: mBgsearchImagePaint
            imageSource: "asset:///images/common/bgSearchBar.png"
        },
        ComponentDefinition {
            id: option
            Option {
            }
        }
    ]
}
