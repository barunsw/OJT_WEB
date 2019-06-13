<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<title>Sample</title>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>	
	    
	<style>
	    html, body {
	        width: 100%;      /*provides the correct work of a full-screen layout*/ 
	        height: 100%;     /*provides the correct work of a full-screen layout*/
	        overflow: hidden; /*hides the default body's space*/
	        margin: 0px;      /*hides the body's scrolls*/
	    }
	</style>
	
	<script src="/resources/plugins/stomp/stomp.min.js"></script>
	<script src="/resources/plugins/sockjs-client/sockjs.min.js"></script>
		
	<script type="text/javascript">
	//<![CDATA[
	var app = {};
	
	dhtmlxEvent(window, 'load', function() {
	    initLayout();
	    initWebsocket();
	    
	    retrieveAddressList();
	    
	    // 웹소켓 생성 이후에 test를 하기 위해, 3초 wait한 후 testWebsocket을 호출한다.
	    setTimeout(testWebsocket, 3000);
	});
	
	function initLayout() {
		app.layout = new dhtmlXLayoutObject(document.body,"2U");
		
		app.layout.cells("a").setText("Contacts");   
		app.layout.cells("b").setText("Contact Details");		
	}
	
	function initWebsocket() {
		// 웹소켓
		var portStr = "";
		if (location.port.length == 0) {
			portStr = ":80";
		}
		else {
			portStr = ":" + location.port;
		}
		
		var protocolStr = "ws";
		if (location.protocol == 'https') {
			protocolStr = "wss";
		}

		var wsUrl = protocolStr + "://" + location.hostname + portStr + "/push";
		
		console.log('wsUrl', wsUrl);
		
		var ws = new WebSocket(wsUrl);
		
		var client = Stomp.over(ws);
		
		//웹소켓 console.log 비활성화
		client.debug = null;
		
		client.connect({}, function(frame) {
			client.subscribe("/topic/event", function(message) {
				console.log("websocket message", message);
				
				var event = JSON.parse(message.body);
				
				if (event.type == "ALARM") {
					console.log("ALARM", event);
				}
			});
		});
	}
	
	function retrieveAddressList() {
		var param = {
		};
		
		$.ajax({
		    url: getContextPath + '/sample',
		    async: true,
		    type: 'GET',
		    data: param, // 전송할 데이터
		    dataType: 'json', // xml, json, script, html
		}).done(function(data) {
			console.log(data);
		});
	}
	
	function testWebsocket() {
		$.ajax({
		    url: getContextPath + '/sample/push-test',
		    async: true,
		    type: 'GET',
		    data: {}, // 전송할 데이터
		    dataType: 'json', // xml, json, script, html
		}).done(function(data) {
			console.log('testWebsocket', data);
		});
	}
	</script>
</head>
<body>
</body>
</html>