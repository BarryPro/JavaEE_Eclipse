<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
String hwAccept = request.getParameter("hwAccept")==null ? "1":request.getParameter("hwAccept");
String showBody = request.getParameter("showBody")==null ? "01":request.getParameter("showBody");
System.out.println("== public ==" + hwAccept + "|" + showBody);

%>
<div class="title">
	<div class="text">纳税人资格认证材料</div>
</div>
<table cellspacing="0">
		<tr>
		<td class="blue">录入证件：
			<select id="card_type11">
				<option value='1' >营业执照</option>			
				<option value='2'>税务登记证</option>
				<option value='3'>一般纳税人资格证明</option>
				<option value='4'>银行基本户开户证明</option>
			</select>
		<input type="button" id="readByMultisss1" name="readByMultisss1" class="b_text"   value="扫描证件" onClick="readByMultiss(1)" >
		</td>
	</tr>
</table>



<script language="JavaScript">	
	
	var picpath_n2new = "";
	var picpath_bei2new = "";
	
	function readByMultiss(str)
	{
		//扫描二代身份证
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
		tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//取得系统目录盘符
		var cre_dir = filep1+":\\custID";//创建目录
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
	
	var ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1000);
	
	if(ret_open!=0){
		ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1001);
	}	
	if(ret_open==0){
		var cardType = document.getElementById("card_type11").value ;	


			//多功能设备OCR读取
			var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_<%=hwAccept%>"+str+".jpg");
			
				if(str==1){
					picpath_n2new="";
					picpath_n2new = "c:\\custID\\cert_<%=hwAccept%>1.jpg";
				}else if(str==2){
					picpath_n2new="";
					picpath_n2new = "c:\\custID\\cert_<%=hwAccept%>2.jpg";
				}
								
					rdShowMessageDialog("扫描成功！",2);
					if(str==1){
						$("#firstId").val(picpath_n2new+"|"+picpath_bei2new+"|");
					}else if(str==2){
						$("#secondId").val(picpath_n2new+"|"+picpath_bei2new+"|");
					}else if(str==11) {
						$("#firstId").val(picpath_n2new+"|"+picpath_bei2new+"|");
					}else if(str==22) {
						$("#secondId").val(picpath_n2new+"|"+picpath_bei2new+"|");
					}	


	}else{
					rdShowMessageDialog("打开设备失败");
					return ;
	}
	//关闭设备
	var ret_close=CardReader_CMCC.MutiIdCardCloseDevice();
	if(ret_close!=0){
							rdShowMessageDialog("关闭设备失败");
					return ;
	}
	
}


</script>

<script language=javascript>
	//判断设备类型
	var fso = new ActiveXObject("Scripting.FileSystemObject");
	if(!fso.FileExists("C:/WINDOWS/system32/MutiIdCard.dll")){ 
		//document.getElementById('readByMultisss1').disabled = false;
		document.getElementById('readByMultisss1').disabled = true;	
	}
</script>