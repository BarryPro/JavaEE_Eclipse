<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%System.out.println("----------------------------getFile.jsp------------------------------------");  %>

<html>
 <head></head>
 <script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/validate_class.js"></script>
<script language="javascript">

function file_checek()
{
	if(document.all.upfile.value == "")
   	{
     	rdShowMessageDialog("请先选择文件!");
     	return false;
  	}
   if(!validateElement(document.all.upfile)) return false;
   document.fileform.submit(); 
}  

</script>
<body bgcolor='#EEF2F7'>
	<div id="operation">
		<form name="fileform" action="upLoadFile.jsp" method="post" target="frame_sub_1" ENCTYPE="multipart/form-data" >
			<input type="file"  name="upfile"  class="uploadFile" id="upfile" size="30"  maxlength=*  v_upType="txt" style='border-style:solid;border-color:#7F9DB9;border-width:1px;' >
			<input type="button" class="b_text" name="up" onClick="file_checek();" value="上传"/>
		</form>
	</div>	
 </body>																		  
</html>