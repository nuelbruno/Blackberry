import bb.cascades 1.0

Container {

    onCreationCompleted: {

//		mainBackground.imageSource = "asset:///images/mol_main_bg.png"
	
    }
    
    verticalAlignment: VerticalAlignment.Fill
    horizontalAlignment: HorizontalAlignment.Fill
//    background: mainBackground.imagePaint
    background: Color.White
    
    attachedObjects: [
        ImagePaintDefinition {
            id: mainBackground
//            imageSource: "asset:///images/rta_main_bg.png"
        }
    ]

}
