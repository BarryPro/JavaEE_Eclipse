<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2015-10-9 15:58:34------------------
 ���ں��˷���ҵ��ҵ�����Ƽ�����������չ����ĺ�
 -------------------------��̨��Ա��xiahk--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  
	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>
 
//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}

function doCfm(){
	
        /*ִ���ϴ��ļ��������ϴ��ļ�����÷���*/
				if($("#uploadFile").val() == ""){
					rdShowMessageDialog("��ѡ�����������ļ���");
					$("#uploadFile").focus();
					return false;
				}
        
        var formFile=document.all.uploadFile.value.lastIndexOf(".");
				var beginNum=Number(formFile)+1;
				var endNum=document.all.uploadFile.value.length;
				formFile=document.all.uploadFile.value.substring(beginNum,endNum);
				formFile=formFile.toLowerCase(); 
				if(formFile!="txt"){
					rdShowMessageDialog("�ϴ��ļ���ʽֻ����txt��������ѡ���ļ���",1);
					document.all.uploadFile.focus();
					return false;
				}
				else
					{
				    document.msgFORM.action="fm325_2.jsp?opCode=<%=opCode%>&opName=<%=opName%>&upload_type="+$("#upload_type").val();
				    document.msgFORM.submit();
					}
}
 
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action=""  method="POST" ENCTYPE="multipart/form-data"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>

<input type="hidden" id="opCode"  name="opCode" value="<%=opCode%>"  />
<input type="hidden" id="opName"  name="opName" value="<%=opName%>"  />

<table cellSpacing="0">
								<tr>
						 				<td class="blue">��������</td>
						 				<td>
						 					<select id="upload_type">
						 							<option value="a">����</option>
						 							<option value="d">ȡ��</option>
						 					</select>
						 				</td>
								</tr>
								
								<tr>
									<td class="blue">�����ļ�</td>
									<td  >
										<input type="file" id="uploadFile" name="uploadFile" v_must="1"  
											style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />&nbsp;<font color="red">*</font>
									</td>
								</tr>
								<tr>
									<td class="blue">
										�ļ���ʽ˵��
									</td>
					        <td>
					            �ϴ��ļ��ı���ʽΪ<br>
											��������|��������<br>
											ʾ������<br>
											13800388300|13800388300<br>

					            <b><br><font class="orange">ע�⣺
					            <br>&nbsp;&nbsp; ��ʽ�е�ÿһ�����������ڿո�,��ÿ�����ݶ���Ҫ�س����С�
					            <br>&nbsp;&nbsp; �ϴ��ļ���ʽΪtxt�ļ�������಻����100����</font>
					            </b> 
					        </td>
	   					 	</tr>
	
</table>
 
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="doCfm()"           />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>