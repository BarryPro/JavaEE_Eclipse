<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>文件上传</title>
<%	
	String optiondate = new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
	String login_no = (String)session.getAttribute("workNo"); 
%>	
</head>
<body  style="height:22px;overflow:hidden;padding:0px;margin:0px;">
	<table width="98%" border="0" style="padding:0">
		<tr>
			<td>
				<form name="frmio001" method="post" action="" enctype="multipart/form-data">
					<input type="file" name="filePath" id="filePath" size="35" v_must="1" class="required b_text"/>
					<input type="button" name="fileButton" id="filePathButton" class="b_text" value="上传文件" onClick="doFileUpload()"/>
				</form>
			</td>
		</tr>
	</table>
</body>

<script type="text/javascript">
	 //文件上传到web主机上	
			
		function doFileUpload(){
			 if(document.frmio001.filePath.value==""){
    		rdShowMessageDialog("请选择要上传的附件",0);
    		return;
    		}
	 		var fso,f;
	 		try{  
		        fso =  new  ActiveXObject("Scripting.FileSystemObject");   
		        f = fso.GetFile(document.getElementById("filePath").value);

	        }catch(e){} 
	 		var filepath=$("#filePath").val();
	 		var source_name = filepath.substring(filepath.length,filepath.lastIndexOf("\\")+1);
	 		var source_name_temp = source_name.substring(source_name.length,source_name.lastIndexOf(".")+1);
	 		if(source_name_temp!="png" && source_name_temp!="bmp" && source_name_temp!="jpg"
	 				&& source_name_temp!="jpeg" && source_name_temp!="gif"){
	 			rdShowMessageDialog("请上传图片格式的文件(*.png,*.bmp,*.jpg,*.jpeg,*.gif)",0);
	 			return;
	 		}
	 		source_name=escape(source_name);
      var pos = filepath.lastIndexOf(".");
	        if (pos != -1) {
	        	var suf = filepath.substring(pos + 1, filepath.length);
	        	suf=suf.toLowerCase();
	        }
	        
	 	 var fileName ="<%=login_no%>_"+"o001_"+"<%=optiondate%>"+"."+suf;
	 	 frmio001.action="fo001_fileUpload.jsp?fileName="+fileName+"&upOrDeFlag=U"+"&source_name="+source_name;
		 frmio001.submit();
		 unLoading();
		}

	 
</script>
</html>

