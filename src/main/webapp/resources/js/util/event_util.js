function storageAvailable(type) {
    try {
        var storage = window[type],
            x = '__storage_test__';
        storage.setItem(x, x);
        storage.removeItem(x);
        return true;
    }
    catch(e) {
        return e instanceof DOMException && (
            // Firefox를 제외한 모든 브라우저
            e.code === 22 ||
            // Firefox
            e.code === 1014 ||
            // 코드가 존재하지 않을 수도 있기 때문에 테스트 이름 필드도 있습니다.
            // Firefox를 제외한 모든 브라우저
            e.name === 'QuotaExceededError' ||
            // Firefox
            e.name === 'NS_ERROR_DOM_QUOTA_REACHED') &&
            // 이미 저장된 것이있는 경우에만 QuotaExceededError를 확인하십시오.
            storage.length !== 0;
    }
}

function sendEmsEvent(message) {
	localStorage.setItem('ems_event', JSON.stringify(message));
	localStorage.removeItem('ems_event');
}

function addEmsEventListener(handleEmsEvent) {
	$(window).on('storage', function(ev) {
		if (ev.originalEvent.key != 'ems_event') return;
		
		var message = JSON.parse(ev.originalEvent.newValue);
		if (message == null) return;
		
		handleEmsEvent(message);	
	});
}