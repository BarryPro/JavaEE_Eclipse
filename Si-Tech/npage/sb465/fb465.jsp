
<%
/********************
 version v2.0
 ������ si-tech
 update haoyy@2010-8-20
********************/
%>

<%
	System.out.println("**************  b465-���м���ɫ������Ȩ ***************");
	String opCode = "b465";
	String opName = "���м���ɫ������Ȩ";

	String loginNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	String roleCode="";
	String roleName="";
	String roleTypeCode="";
	String roleTypeName="";
	int num=0;

	//���ʮ��������ϵͳ����Ա�Ľ�ɫ����ͽ�ɫ����
	String sql="select power_code,power_name from spowercode where  length(trim(power_code))=4 and power_code<='0113'";

	//��õ�ǰ��¼���ŵĽ�ɫ���������
	String sql2="select a.power_code, a.power_name, b.roletype_code, b.ROLETYPE_NAME "+
                     " from sPowerCode a, sRoleTypeCode b,dLoginMsg c "+
                     " where c.login_no='"+loginNo+"'"+
                     "   and a.roletype_code=b.roletype_code"+
                     "   and a.power_code=c.power_code"+
                     "   and a.power_code in (select d.power_code from dpowerobjrelation d " +
                     "   where Trim(d.object_id) = Trim(c.group_id))";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@page contentType="text/html;charset=gbk"%>


<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result" scope="end"/>
<%
	String[][] resultList = result;
%>
<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql2%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result2" scope="end"/>
<%
	String[][] resultList2 = result2;
	roleCode = resultList2[0][0];
	roleName= resultList2[0][1];
	roleTypeCode = resultList2[0][2];
	roleTypeName= resultList2[0][3];
%>

<html>
<head>
<title><%=opName%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

<script language=javascript>
//--------ȫ��ѡ��--------------
function allSelect()
{
	var i = 0;
	for(i=0;i<document.all.check.length;i++)
	{
		document.all.check[i].checked=true;
	}
}
//--------ȫ��ȡ��--------------
function noSelect()
{
	var i = 0;
	for(i=0;i<document.all.check.length;i++)
	{
		document.all.check[i].checked=false;
	}
	//document.all.setPdButton.disabled=true;
}
//--------���������ѡ�Ľ�ɫ����--------------
function getRoles()
{
	var roles='';
	var i=0;
	for( i=0;i<document.all.check.length;i++)
	{
		if(document.all.check[i].checked==true){
			if(roles==''){
				roles+=document.all.check[i].value;
			}else{
				roles+=","+document.all.check[i].value;
			}
		}
	}
	return roles;
}
function setPopedom(num)
{
	var roleCode = form1.roleCode.value;
	var roleName = form1.roleName.value;
	var roleTypeCode = form1.roleTypeCode.value;
	var roles='';
	if(num>1){
		roles=getRoles();
	}
	else if(num==1){
		roles=document.all.check.value;
	}
	if(roles==''){
		rdShowMessageDialog("��ѡ��Ҫ�޸ĵĽ�ɫ��",1);
		//alert('��ѡ��Ҫ�޸ĵĽ�ɫ��');
		return false;
	}else{
		var roleName="��ѡ�ĵ��й���Ա";
		var win = window.open('fb465_setpdmain.jsp?roleCode='+roleCode+"&roleName="+roleName+"&roleTypeCode="+roleTypeCode+"&roles="+roles,
			'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}
}


</script>
</head>
<body >

			<form name="form1" method="post" action="">
				<%@ include file="/npage/include/header.jsp" %>

	<input type="hidden" name="roleCode" value="<%=roleCode %>" />
	<input type="hidden" name="roleName" value="<%=roleName %>" />
	<input type="hidden" name="roleTypeCode" value="<%=roleTypeCode %>" />
	<input type="hidden" name="roleTypeName" value="<%=roleTypeName %>" />
	<div class="title">
		<div id="title_zi">ѡ���ɫ</div>
	</div>
			<TABLE  cellspacing=0">
			<TBODY>

        	    <TR>
				    		<TD height = 20 class="blue">ѡ��</TD>
				    		<TD height = 20 class="blue">��ɫ����</TD>
				    		<TD height = 20 class="blue">��ɫ����</TD>

	    	    </TR>
			<%
				if(resultList!=null){
				num=resultList.length;
				for(int i=0;i<resultList.length;i++){
			%>
			<TR>
				    		<TD height = 20 class="blue">
				    			<input type=checkbox name=check value="<%=resultList[i][0]%>" checked />
				    		</TD>
				    		<TD height = 20 class="blue"><%=resultList[i][0]%></TD>
				    		<TD height = 20 class="blue"><%=resultList[i][1]%></TD>

	    	    </TR>
			<%
			}}
			%>
        		<TR>
        		<TD align="center" colspan="3" id="footer">
        			<input  type="button" name="reset"  class="b_foot_long" onclick="allSelect()" value="ȫ��ѡ��">
        			<input  type="button" name="reset"  class="b_foot_long" onclick="noSelect()" value="ȫ��ȡ��">
        			<input  type="button" name="setPdButton"  class="b_foot_long"  onclick="setPopedom(<%=num %>)" value="����Ȩ��" >&nbsp;
        			&nbsp;
							<input  type="button" name="Return"   class="b_foot"  onclick="removeCurrentTab()" value="�ر�">
        		</TD>
        	   </TR>
         </TABLE>
         <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

