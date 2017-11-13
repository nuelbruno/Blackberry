// ***********************************************************************************************************
//  DIRECTION NAVIGATION PANE
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
NavigationPane {
    id: mNavigationPaneMain
    function receiveValue(passedBackValue, isfromhere) {
        mDirections.receiveValue(passedBackValue, isfromhere);
    }
    Directions {
        id: mDirections
    }
}
