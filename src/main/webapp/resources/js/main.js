/**
 * main.js
 */

var app = {};

dhtmlxEvent(window, "load", function() {
	initLayout();
	initEvent();
	initData();
})

function initLayout() {

	// layout형태를 2U로 설정.
	app.layout = new dhtmlXLayoutObject(document.body,"2U");

	// cell "a"의 이름 지정.
	app.layout.cells("a").setText("Contects");

	// cell "b"의 이름 지정.
	app.layout.cells("b").setText("Contect Details");
	app.layout.cells("b").setWidth(400);

	// menu layout 첨부.
	var menu = app.layout.attachMenu();
	menu.loadStruct("/resources/dhtmlx5/data/menu.xml");

	// toolbar layout 첨부.
	app.toolbar = app.layout.attachToolbar();
	app.toolbar.setIconsPath("/resources/dhtmlx5/icons/");
    app.toolbar.loadStruct("/resources/dhtmlx5/data/toolbar.xml");

	// cell "a"에 grid 포함.
	app.contactsGrid = app.layout.cells("a").attachGrid();

	/* filter 설정 추가 */

	app.contactsGrid.setHeader("Name,Age,Address");   //sets the headers of columns
	app.contactsGrid.setColumnIds("name,age,address");//sets the columns' ids
	app.contactsGrid.setInitWidths("200,200,*");      //sets the initial widths of columns
	app.contactsGrid.setColAlign("left,left,left");   //sets the alignment of columns
	app.contactsGrid.setColTypes("ro,ro,ro");         //sets the types of columns
	app.contactsGrid.setColSorting("str,str,str");    //sets the sorti
	app.contactsGrid.init();

    // cell "b" form 추가.
    app.contactForm = app.layout.cells("b").attachForm();
    app.contactForm.loadStruct("/resources/dhtmlx5/data/form.xml");    
}

function initData() {

	$.ajax({
		type : 'get',
		url : '/list',
		dataType : 'json',
		success : function(response) { 
			var count = 0;
/*
			personList = { rows : [ {"id": "", "data": ""} ] };

			for (var i = 0; i < response.length ; i++) {
				personList.rows[i] = {
										"id":i+1, 
										"data": [response[i].name, response[i].age, response[i].address]
									 };			
			}

			app.contactsGrid.parse(personList, 'json');
		*/
		app.contactsGrid.parse(response, 'js');
		},
		error : function() {
			alert('initData error');
		}
	});
}

function initEvent() {

	// row를 선택했을 경우.
	app.contactsGrid.attachEvent("onRowSelect", function() {

		var rowId = app.contactsGrid.getSelectedRowId();
		var rowIndex = app.contactsGrid.getRowIndex(rowId);
        var rowData = app.contactsGrid.getRowData(rowId);

	    console.log("rowId" + rowId);

		// row를 선택하면 form에 값 설정.
	    app.contactForm.setItemValue("Name", rowData.name);
	   	app.contactForm.setItemValue("Age", rowData.age);
	    app.contactForm.setItemValue("Address", rowData.address);	
	});

	// form에서 save 버튼을 눌렀을 경우.
	// 누른 버튼의 name은 save, update.
	app.contactForm.attachEvent("onButtonClick", function(clickName) {

		var name 	= app.contactForm.getItemValue("Name");
		var age  	= app.contactForm.getItemValue("Age");
		var address = app.contactForm.getItemValue("Address");		

		console.log("name : " + name);
		console.log("age : " + age);
		console.log("address : " + address);	

		// save 버튼을 눌렀을 경우.
		if (clickName == "save") {
			console.log("save click");

			var rowId = app.contactsGrid.uid();
			var pos = app.contactsGrid.getRowsNum();

			$.ajax({
				url : "/save",
				type : "post",
				data : {
					Name:name,
					Age:age,
					Address:address
				},
				success : function(data) {
					app.contactsGrid.addRow(rowId, [name, age, address], pos);
					alert("save success");
				},
				error : function() {
					alert("save error");
				}
			});
		}

		// update 버튼을 눌렀을 경우.
		if (clickName == "update") {
			console.log("update click");

			var rowId = app.contactsGrid.getSelectedRowId();

			$.ajax({
				url : "/update",
				type : "post",
				data : {
					Name:name,
					Age:age,
					Address:address
				},
				success : function(data) {
					app.contactsGrid.setRowData(rowId, {"name":name, "age":age, "address":address});
					alert("update success");
				},
				error : function() {
					alert("update error");
				}
			});
		}
	});

	app.toolbar.attachEvent("onClick", function(id) {

		if(id == "delContact") {
			var rowId    = app.contactsGrid.getSelectedRowId();
            var rowIndex = app.contactsGrid.getRowIndex(rowId);
            var rowData = app.contactsGrid.getRowData(rowId);

            console.log(rowId);
            console.log(rowIndex);
            console.log(rowData);

            app.contactForm.setItemValue("Name", "");
	   		app.contactForm.setItemValue("Age", "");
	    	app.contactForm.setItemValue("Address", "");

            $.ajax ({
            	url : "/delete",
            	type : "post",
            	data : {
            		Name:rowData.name,
            		Age:rowData.age,
            		Address:rowData.address
            	},
            	success : function(data) {
					if (rowId != null) {
						app.contactsGrid.deleteRow(rowId);

						if (rowIndex != (contactsGrid.getRowsNum() - 1)) {
			                app.contactsGrid.selectRow(rowIndex + 1, true);
						}
						else {
							app.contactsGrid.selectRow(rowIndex - 1, true);
						}
					}
					alert("delete success");
            	},
            	error : function() {
            		alert("delete error");
            	}
            });
		}
	});
}