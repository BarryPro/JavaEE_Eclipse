<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
String hwAccept = request.getParameter("hwAccept")==null ? "1":request.getParameter("hwAccept");
String showBody = request.getParameter("showBody")==null ? "01":request.getParameter("showBody");
System.out.println("== public ==" + hwAccept + "|" + showBody);

%>
<div class="title">
	<div class="text">��˰���ʸ���֤����</div>
</div>
<table cellspacing="0">
		<tr>
		<td class="blue">¼��֤����
			<select id="card_type11">
				<option value='1' >Ӫҵִ��</option>			
				<option value='2'>˰��Ǽ�֤</option>
				<option value='3'>һ����˰���ʸ�֤��</option>
				<option value='4'>���л���������֤��</option>
			</select>
		<input type="button" id="readByMultisss1" name="readByMultisss1" class="b_text"   value="ɨ��֤��" onClick="readByMultiss(1)" >
		</td>
	</tr>
</table>



<script language="JavaScript">	
	
	var picpath_n2new = "";
	var picpath_bei2new = "";
	
	function readByMultiss(str)
	{
		//ɨ��������֤
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";//����Ŀ¼
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
	
	var ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1000);
	
	if(ret_open!=0){
		ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1001);
	}	
	if(ret_open==0){
		var cardType = document.getElementById("card_type11").value ;	


			//�๦���豸OCR��ȡ
			var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_<%=hwAccept%>"+str+".jpg");
			
				if(str==1){
					picpath_n2new="";
					picpath_n2new = "c:\\custID\\cert_<%=hwAccept%>1.jpg";
				}else if(str==2){
					picpath_n2new="";
					picpath_n2new = "c:\\custID\\cert_<%=hwAccept%>2.jpg";
				}
								
					rdShowMessageDialog("ɨ��ɹ���",2);
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
					rdShowMessageDialog("���豸ʧ��");
					return ;
	}
	//�ر��豸
	var ret_close=CardReader_CMCC.MutiIdCardCloseDevice();
	if(ret_close!=0){
							rdShowMessageDialog("�ر��豸ʧ��");
					return ;
	}
	
}


</script>

<script language=javascript>
	//�ж��豸����
	var fso = new ActiveXObject("Scripting.FileSystemObject");
	if(!fso.FileExists("C:/WINDOWS/system32/MutiIdCard.dll")){ 
		//document.getElementById('readByMultisss1').disabled = false;
		document.getElementById('readByMultisss1').disabled = true;	
	}
</script>