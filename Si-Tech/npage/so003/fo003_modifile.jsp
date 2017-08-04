<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>文件上传</title>
<%
	String optiondate = new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
	String loginNo = (String)session.getAttribute("workNo"); 
%>	
</head>
<body  style="height:22px;overflow:hidden;padding:0px;margin:0px;">
	<table width="98%" border="0" style="padding:0">
		<tr>
			<td>
				<form name="frmo003_modi" method="post" action="" enctype="multipart/form-data">
					<input type="file" name="filePath" id="filePath" size="35" class="required b_text"/>
					<input type="button" name="fileButton" id="fileButton" class="b_text" value="上传文件" onClick="doFileUpload()"/>
				</form>
			</td>
		</tr>
	</table>
</body>

<script type="text/javascript">
	 //文件上传到web主机上	
			
		function doFileUpload(){
			
	 		var fso,f;
	 		try{  
		        fso =  new  ActiveXObject("Scripting.FileSystemObject");   
		        f = fso.GetFile(document.getElementById("filePath").value);
		       
	        }catch(e){} 
	 		var filepath=$("#filePath").val();
	 		var source_name = filepath.substring(filepath.length,filepath.lastIndexOf("\\")+1);
	 		source_name=escape(source_name);
      var pos = filepath.lastIndexOf(".");
	        if (pos != -1) {
	        	var suf = filepath.substring(pos + 1, filepath.length);
	        	suf=suf.toLowerCase();
	        }
	   var fileName ="<%=loginNo%>_"+"o001_"+"<%=optiondate%>"+"."+suf;
	 	 frmo003_modi.action="fo003_modifileUpload.jsp?fileName="+fileName+"&upOrDeFlag=U"+"&source_name="+source_name;
		 frmo003_modi.submit();
		 unLoading();
		}

	 
</script>
</html>

