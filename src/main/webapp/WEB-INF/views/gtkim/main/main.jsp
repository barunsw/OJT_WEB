<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact Manager</title>

<script src="resources/dhtmlx5/dhtmlx.js" type="text/javascript"></script>
<link rel="STYLESHEET" type="text/css" href="resources/dhtmlx5/dhtmlx.css">

</head>
<style>
html, body {
	width: 100%;
	height: 100%;
	overflow: hidden;
	margin: 0px;
}
</style>
<body>
	<script type="text/javascript">
		dhtmlxEvent(
				window,
				"load",
				function() {
					var layout = new dhtmlXLayoutObject(document.body, "2U");

					layout.cells("a").setText("Contacts");
					layout.cells("b").setText("Contact Details");
					layout.cells("b").setWidth(500);

					var menu = layout.attachMenu();
					menu.setIconsPath("data/gtkim/icons/");
					menu.loadStruct("data/gtkim/menu.xml")

					var toolbar = layout.attachToolbar();
					toolbar.setIconsPath("data/gtkim/icons/");
					toolbar.loadStruct("data/gtkim/toolbar.xml");

					// Cell a에 그리드를 붙이기 init()을 해줘야됨
					var contactsGrid = layout.cells("a").attachGrid();
					contactsGrid.setHeader("Name,Age,Address");
					contactsGrid.setColumnIds("name,age,Address");
					contactsGrid.setInitWidths("250,250,*");
					contactsGrid.setColAlign("left,left,left");
					contactsGrid.setColTypes("ro,ro,ro");
					contactsGrid.setColSorting("str,int,str");
					contactsGrid
							.attachHeader("#text_filter,#text_filter,#text_filter");

					contactsGrid.init();

					// Cell b에 폼을 붙이기 
					var contactForm = layout.cells("b").attachForm();
					contactForm.loadStruct("data/gtkim/form.xml");
					contactForm.bind(contactsGrid);

					contactForm.attachEvent("onButtonClick", function() { 
						//attaches a handler function to the "onButtonClick" event
						var data = contactForm.getFormData();
						console.log(data);

						data = eval(data);
						console.log(data.email);
						contactsGrid.addRow(1, [ data.fname, data.lname,
								data.email ]);
					});

				});
	</script>
</body>
</html>