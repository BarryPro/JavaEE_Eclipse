<%
  /*
   * 功能: 跳转商旅中心
　 * 版本: 1.0.0
　 * 日期: 2009/03/12
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>
<html>
	<head>
		<div style="display:none">
		<OBJECT id='Cmci12580' classid="CLSID:88275156-9185-4A51-955E-D57621F2FE3A"
		codebase="/ocx/Cmci12580.cab#version=1,1,1,0"
			  width=20
			  height=20
			  align=center
			  hspace=0
			  vspace=0>
		</OBJECT>
		</div>
		<div style="display:none">
		<OBJECT id='icdCfgObject' classid="CLSID:7F3929A0-C455-43EC-ACF0-8B1AD46873DC"
		codebase="/ocx/localId.cab#version=1,1,0,0"
			  width=20
			  height=20
			  align=center
			  hspace=0
			  vspace=0>
		</OBJECT>
		</div>
		<script language="javaScript">
			onload=function(){
				
				icdCfgObject.openNewIE("http://218.206.87.130/newci/pages/index.html");
				for(var i = 0; i < 100; i++){
					;
				}
				window.opener = null;
				window.close();
			}
		</script>
	</head>
	<body>		
	</body>
</html>
