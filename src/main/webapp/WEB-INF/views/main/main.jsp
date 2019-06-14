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
      dhtmlxEvent(window, "load", function(){
    	function ajax(type,url,data){
    		
    	}
        var layout = new dhtmlXLayoutObject(document.body, "2U");
        var rowData;
        var contactsGrid = layout.cells("a").attachGrid();
      	var Name, Age, Address;
      	var rowId;
      	var rowIndex;
        contactsGrid.attachHeader("#text_filter,#text_filter,#text_filter,#text_filter");

        contactsGrid.setHeader("Seq,Name, Age, Address");
        contactsGrid.setColumnIds("Seq,Name,Age,Address");
        contactsGrid.setInitWidths("250,250,*");
        contactsGrid.setColAlign("left,left,left,left");
        contactsGrid.setColTypes("ro,ro,ro,ro");
        contactsGrid.setColSorting("str,str,str,str");
        contactsGrid.init();
        contactsGrid.attachEvent("onRowSelect",function(id,ind){
        	console.log(id);
        	console.log(ind);
        	rowId    = contactsGrid.getSelectedRowId();
            rowIndex = contactsGrid.getRowIndex(rowId);
            rowData = contactsGrid.getRowData(rowId);
            console.log(rowData.NAME)
           
        	//console.log(layout.cells("row1",1).getValue());
        });
        var listSize = ${list.size()};
  
     	<c:forEach items="${list}" var="list" varStatus="status">
	        rowId = contactsGrid.uid();
	        pos = contactsGrid.getRowsNum();
	        contactsGrid.addRow(rowId, ["${status.count}","${list.name}", "${list.age}", "${list.address}"],pos);
     	</c:forEach>

        layout.cells("a").setText("Contacts");
        layout.cells("b").setText("Contact Details");
        layout.cells("b").setWidth(500);

        var menu = layout.attachMenu();
        menu.setIconsPath("resources/dhtmlx5/icons/");
        menu.loadStruct("resources/dhtmlx5/data/menu.xml");

        var toolbar = layout.attachToolbar();
        toolbar.setIconsPath("resources/dhtmlx5/icons/");
        toolbar.loadStruct("resources/dhtmlx5/data/toolbar.xml");

        var contactForm = layout.cells("b").attachForm();
        contactForm.loadStruct("resources/dhtmlx5/data/form.xml");

        toolbar.attachEvent("onClick",function(id){
          if (id == "delContact") {
            rowId    = contactsGrid.getSelectedRowId();
            rowIndex = contactsGrid.getRowIndex(rowId);
			console.log(toolbar.getItemText(id));
			console.log(rowData);
			$.ajax({
				type:"post",
				url:"/delete",
				dataType:'json',
				data:JSON.stringify(rowData),
				contentType: 'application/json',
				success:function(data){
					if (data == 1){
						if(rowId!=null){
			              contactsGrid.deleteRow(rowId);
			                if(rowIndex!=(contactsGrid.getRowsNum() -1)) {
			                  contactsGrid.selectRow(rowIndex+1, true);
			                } else {
			                  contactsGrid.selectRow(rowIndex-1, true);
			                }
			            } 
						alert("삭제 되었습니다.");
					} else {
						alert("삭제에 실패하였습니다.");
					}
				}
			});
			
          }
        });

        contactForm.attachEvent("onButtonClick",function(name){
        Name		= contactForm.getItemValue("Name");
        Age  		= contactForm.getItemValue("Age");
        Address     = contactForm.getItemValue("Address");
        console.log("Name : " + Name);
        console.log("Age : " + Age);
        console.log("Address : " + Address);
        if (name == "save") {
	        rowId = contactsGrid.uid();
	        pos = contactsGrid.getRowsNum();
			
	        contactsGrid.addRow(rowId, [listSize+1,Name, Age, Address],pos);
	        $.ajax({
	        	url:"/insert",
	        	type:"post",
	        	data:{
	        		Name:Name,
	        		Age:Age,
	        		Address:Address
	        	},
	        	success:function(data){
	        		if (data == 1){
	        			alert("등록되었습니다");
	        		} else {
	        			alert("등록에 실패하였습니다");
	        		}
	        	}
	        }); 
        } 
        if (name == "update") {
        	var rowId = contactsGrid.getSelectedRowId();
        	console.log("rowId"+rowId);
        	contactsGrid.setRowData(rowId,{"Seq":"","Name":Name,"Age":Age,"Address":Address});
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