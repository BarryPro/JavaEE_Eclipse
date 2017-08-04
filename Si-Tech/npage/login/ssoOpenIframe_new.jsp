<body>
<iframe src="ssouse.jsp" style="display:none" width="100" height="100"></iframe>

<form name="ssoform" id="ssoform" method="post"
	 action="http://10.110.45.10/csp/kbs/c_displayKnowledgeFirstPage.action">
 
<div style="display: none">
	<OBJECT id="callcause_for_knowledge"
		classid="clsid:88275156-9185-4A51-955E-D57621F2FE3A"
		codebase="/ocx/callcause.cab#version=2,0,0,2" width=20
		height=20 align=center hspace=0 vspace=0>
	</OBJECT>
</div>
</body>

<script type="text/javascript">
/*
window.open('http://10.110.44.170:8081/csp/c_yb/c_displayKnowledgeFirstPage.action','','toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=yes,left=200,top=120');
window.opener=null;
window.open("","_self");
window.close();
*/
window.ssoform.submit();
</script>