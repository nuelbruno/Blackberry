/* Copyright (c) 2012 Research In Motion Limited.
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
#include "StatusEventHandler.h"
#include <bps/bps.h>
#include <bps/netstatus.h>
#include <bps/locale.h>

StatusEventHandler::StatusEventHandler() {
    subscribe(netstatus_get_domain());
    subscribe(locale_get_domain());

    bps_initialize();

    netstatus_request_events(0);
    locale_request_events(0);
}

StatusEventHandler::~StatusEventHandler() {
    bps_shutdown();
}

void StatusEventHandler::event(bps_event_t *event) {
    bool status = false;
    const char* language = "";
    const char* country = "";
    const char* locale = "";
    const char* interface = "";
    const char* type = "none";

    netstatus_interface_details_t *details;

    if (bps_event_get_domain(event) == netstatus_get_domain()) {
    	if (NETSTATUS_INFO == bps_event_get_code(event)) {
    		status = netstatus_event_get_availability(event);
    		interface = netstatus_event_get_default_interface(event);
    		int success = netstatus_get_interface_details(interface, &details);

    		if (success == BPS_SUCCESS) {
    		    switch (netstatus_interface_get_type(details)) {

    		    case NETSTATUS_INTERFACE_TYPE_UNKNOWN:
    		        type = "Unknown";
    		        break;

    		    case NETSTATUS_INTERFACE_TYPE_WIRED:
    		        type = "Wired";
    		        break;

    		    case NETSTATUS_INTERFACE_TYPE_WIFI:
    		        type = "Wi-Fi";
    		        break;

    		    case NETSTATUS_INTERFACE_TYPE_BLUETOOTH_DUN:
    		        type = "Bluetooth";
    		        break;

    		    case NETSTATUS_INTERFACE_TYPE_USB:
    		        type = "USB";
    		        break;

    		    case NETSTATUS_INTERFACE_TYPE_VPN:
    		        type = "VPN";
    		        break;

    		    case NETSTATUS_INTERFACE_TYPE_BB:
    		        type = "BB";
    		        break;

    		    case NETSTATUS_INTERFACE_TYPE_CELLULAR:
    		        type = "Cellular";
    		        break;
    		}
    		netstatus_free_interface_details(&details);
    	}
    	emit networkStatusUpdated(status, type);
    	} else if (bps_event_get_domain(event) == locale_get_domain()) {
    	    if (LOCALE_INFO == bps_event_get_code(event)) {
    	        language = locale_event_get_language(event);
    	        country = locale_event_get_country(event);
    	        locale = locale_event_get_locale(event);
    	        emit localeUpdated(language, country, locale);
    	    }
    	}
    }
}
