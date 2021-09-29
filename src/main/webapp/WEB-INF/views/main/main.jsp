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
</head>
<body>
	<script type="text/javascript">
	var app = {};
	
	dhtmlxEvent(window, "load", function() {
		initLayout();
		initEvent();
		initData();
	}
    	  
	function initLayout() {
        app.layout = new dhtmlXLayoutObject(document.body, "2U");
        
        var menu = app.layout.attachMenu();
        menu.setIconsPath("resources/dhtmlx5/icons/");
        menu.loadStruct("resources/dhtmlx5/data/menu.xml");

        app.toolbar = app.layout.attachToolbar();
        app.toolbar.setIconsPath("resources/dhtmlx5/icons/");
        app.toolbar.loadStruct("resources/dhtmlx5/data/toolbar.xml");

        layout.cells("a").setText("Contacts");

        app.contactsGrid = app.layout.cells("a").attachGrid();
        
        //contactsGrid.attachHeader("#text_filter,#text_filter,#text_filter,#text_filter");
        app.contactsGrid.setHeader("Name,Age,Address");
        app.contactsGrid.setColumnIds("name,age,address");
        app.contactsGrid.setInitWidths("250,250,*");
        app.contactsGrid.setColAlign("left,left,left");
        app.contactsGrid.setColTypes("ro,ro,ro");
        app.contactsGrid.setColSorting("str,str,str");
        app.contactsGrid.init();
        
        app.layout.cells("b").setText("Contact Details");
        app.layout.cells("b").setWidth(500);

        app.contactForm = app.layout.cells("b").attachForm();
        app.contactForm.loadStruct("resources/dhtmlx5/data/form.xml");
	}
	
	function initEvent() {
		app.contactsGrid.attachEvent("onRowSelect",function(id,ind){
        	console.log(id);
        	console.log(ind);
        	
        	var rowId    = app.contactsGrid.getSelectedRowId();
            var rowIndex = app.contactsGrid.getRowIndex(rowId);
            var rowData = app.contactsGrid.getRowData(rowId);
            
            console.log(rowData.NAME)
        	//console.log(layout.cells("row1",1).getValue());
        });
        
		app.toolbar.attachEvent("onClick",function(id){
          if (id == "delContact") {
            var rowId    = app.contactsGrid.getSelectedRowId();
            var rowIndex = app.contactsGrid.getRowIndex(rowId);
			
            console.log(app.toolbar.getItemText(id));
			console.log(rowData);
			
			$.ajax({
				type:"post",
				url:"/delete",
				dataType:'json',
				data:JSON.stringify(rowData),
				contentType: 'application/json',
				success:function(data){
					console.log('data', data);
					if (data == 1) {
						if (rowId != null) {
							app.contactsGrid.deleteRow(rowId);
							
			                if (rowIndex!=(contactsGrid.getRowsNum() -1)) {
			                	app.contactsGrid.selectRow(rowIndex+1, true);
			                } 
			                else {
			                	app.contactsGrid.selectRow(rowIndex-1, true);
			                }
			            } 
						alert("삭제 되었습니다.");
					} 
					else {
						alert("삭제에 실패하였습니다.");
					}
				}
			});
          }
        });

        contactForm.attachEvent("onButtonClick",function(name) {
	        var name		= app.contactForm.getItemValue("Name");
	        var age  		= app.contactForm.getItemValue("Age");
	        var address     = app.contactForm.getItemValue("Address");
	        
	        console.log("Name : " + Name);
	        console.log("Age : " + Age);
	        console.log("Address : " + Address);
	        
	        if (name == "save") {
		        var rowId = app.contactsGrid.uid();
		        var pos = app.contactsGrid.getRowsNum();
				
		        app.contactsGrid.addRow(rowId, [listSize+1,Name, Age, Address],pos);
		        $.ajax({
		        	url:"/insert",
		        	type:"post",
		        	data:{
		        		Name:Name,
		        		Age:Age,
		        		Address:Address
		        	},
		        	success: function(data) {
		        		if (data == 1) {
		        			alert("등록되었습니다");
		        		} 
		        		else {
		        			alert("등록에 실패하였습니다");
		        		}
		        	}
		        }); 
	        } 
	        if (name == "update") {
	        	var rowId = app.contactsGrid.getSelectedRowId();
	        	console.log("rowId"+rowId);
	        	app.contactsGrid.setRowData(rowId,{"Seq":"","Name":Name,"Age":Age,"Address":Address});
	        	$.ajax({
	        		url:"/update",
	        		type:"post",
	        		data:{
	        			Name:Name,
	        			Age:Age,
	        			Address:Address
	        		},
	        		success:function(data){
	        			if (data == 1){
	        				alert("수정되었습니다");
	        			} else {
	        				alert("수정에 실패하였습니다");
	        			}
	        		}
	        	});
	        }
        });
      });
    </script>
</body>
</html>