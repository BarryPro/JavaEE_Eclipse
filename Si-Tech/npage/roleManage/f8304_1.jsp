<%
/********************
 version v2.0
������: si-tech
********************/
%>

<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  



%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%		
	String opCode = "8304";
	String opName = "������Ȩ";
  String password = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
	String work_group_id = (String)session.getAttribute("workGroupId");
%>
<%
	String rowpowersql="select total_date from sroleopcode where region_code='"+regionCode+"' and op_type='4'";
	System.out.println("rowpowersql====="+rowpowersql);
%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1">
		<wtc:sql><%=rowpowersql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end"/>
<%
	String[][] rowpowerStr = result1;
	String agtloginsql=" select count(*) from  dChnGroupMsg a,sChnClassmsg b "+
				" where a.group_id='"+work_group_id+"' and a.is_active='Y' "+
				 " and a.class_code=b.class_code and b.class_code='2'";
	System.out.println("agtloginsql====="+agtloginsql);
%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2">
		<wtc:sql><%=agtloginsql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end"/>
<%
  String[][] agtloginStr = result2;
  if(Integer.parseInt(agtloginStr[0][0])>0){
  %>
  	<script language="JavaScript">
			alert("ֻ����Ӫҵ����ʹ�ñ����ܣ�");
			window.close();
		</script>
<%
}
	
	String opcodesql="select a.op_code,b.function_name from sroleopcode a,sfunccode b where a.op_code=b.function_code "+
          " and a.region_code='"+regionCode+"' and a.op_type='0'";
	System.out.println("opcodesql====="+opcodesql);
%>
	<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3">
		<wtc:sql><%=opcodesql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result3" scope="end"/>
<%
  String[][] opcodeStr = result3;
  String loginsql="select a.login_no,a.login_name from dloginmsg a,srolelogintown b where b.group_id='"+work_group_id+"' and a.login_no=b.login_no and b.op_code='9618'";
  System.out.println("loginsql====="+loginsql);
%>
	<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4">
		<wtc:sql><%=loginsql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result4" scope="end"/>
<%
  String[][] loginStr = result4;
%>

<head>
<title>������Ȩ</title>

<script language=javascript>

	function doProcess(packet){
	
	}
</script>
<script language="JavaScript">
<!--

function printCommit(){
	if(!check(frm))
  {
    return false;
  }
	var chooseVal = $("#checkFile").val();
  var fileNumberObj = $("#fileNumber");
	var fileNameObj = $("#fileName");
	if("1" == chooseVal){
		if(0 == fileNumberObj.val().trim().len()){
			showTip(fileNumberObj[0],"�������ļ����");
			return false;
		}
		if(0 == fileNameObj.val().trim().len()){
			showTip(fileNameObj[0],"�������ļ�����");
			return false;
		}
	}else{
		fileNumberObj.val("");
		fileNameObj.val("");
	}
  if(document.all.sopcode.value==""){
  		rdShowMessageDialog("��ѡ����Ȩҵ��");
		return;
  }
  if(document.all.login_no.value==""){
		rdShowMessageDialog("��ѡ��Ӫҵ������");
		return;
  }
  if(document.all.oldPass.value==""){
		rdShowMessageDialog("���������룡");
		return;
  }
 document.frm.action="f8304_2.jsp";
 frm.submit();
	
}
 
function checkFileChg(){
	var chooseVal = $("#checkFile").val();
	if("1" == chooseVal){
		$("#fileObj").show();
	}else{
		$("#fileObj").hide();
	}
}
//-->
</script>

</head>


<body>
<form name="frm" method="post">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">������Ȩ</div>
	</div>
	<table cellspacing="0">
		<tr> 
			<td class="blue">��Ȩҵ��</td>
			<td colspan="3"> 
				<SELECT id="sopcode" name="sopcode" v_must=1   v_name="��Ȩҵ��">  
					<%for(int i = 0 ; i < opcodeStr.length ; i ++){%>
					<option value="<%=opcodeStr[i][0]%>"><%=opcodeStr[i][1]%></option>
					<%}%>
				</select> 
				<font color="#FF0000">*</font>
			</td>
		</tr>
		
		<tr id="cs_cs"> 
			<td class="blue">��Ȩ����</td>
			<td colspan="3"> 
				<input type="text" name="op_count" readonly value="1">
				<font color="#FF0000">*</font>
			</td>
		</tr>	
		<tr id="zy_no"> 
			<td class="blue">Ӫҵ������</td>
			<td > 
				<SELECT id="login_no" name="login_no" v_must=1   v_name="����">  
					<%for(int i = 0 ; i < loginStr.length ; i ++){%>
					<option value="<%=loginStr[i][0]%>"><%=loginStr[i][1]%></option>
					<%}%>
				</select> 
				<font color="#FF0000">*</font>
			</td>
			<td class="blue">����</td>
			<td >
				<input class=button  id=Text2 type=password size=12 name=oldPass maxlength=6> 	
				<font color="#FF0000">*</font>	    
			</td>
		</tr>
    <tr>
			<td class="blue" >��Ȩԭ��</td>
			<td colspan="3">
				<input type="text" name="grantReason" id="grantReason" maxlength="255" 
					size="100" v_must="1" v_type="string" onblur="checkElement(this)" />
				<font color="#FF0000">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue" >�Ƿ���������ļ�</td>
			<td colspan="3">
				<select name="checkFile" id="checkFile" onchange="checkFileChg()">
					<option value="1">��</option>
					<option value="0">��</option>
				</select>
				<font color="#FF0000">*</font>
			</td>
		</tr>
		<tr id="fileObj">
			<td class="blue" >�ļ����</td>
			<td>
				<input type="text" name="fileNumber" id="fileNumber" maxlength="50" />
				<font color="#FF0000">*</font>
			</td>
			<td class="blue" >�ļ�����</td>
			<td>
				<input type="text" name="fileName" id="fileName" maxlength="100" />
				<font color="#FF0000">*</font>
			</td>
		</tr>
          
          <tr> 
            <td colspan="4"> 
            	<div align="center"> 
                <input name="confirm" type="button" class="b_foot" index="2" value="�ύ" onClick="printCommit()"  >
                &nbsp; 
                <input name="confirm" type="button" class="b_foot" index="2" value="ɾ��" onClick="deleteCommit()"  >
								&nbsp;
                <input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="�ر�">
                &nbsp; 
              </div>
            </td>
          </tr>
        </table>
		<input type="hidden" name="nopass" value="<%=password%>">
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>