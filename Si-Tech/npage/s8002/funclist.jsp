<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
������: si-tech
update:anln@2009-02-25 ҳ�����,�޸���ʽ
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.ParseException"%>
<%
	
	String opCode = "8002";
	String opName = "���Ź���";
	String regionCode=(String)session.getAttribute("regCode");
	String loginNo = (String)session.getAttribute("workNo");	
	
	String roleCode = request.getParameter("roleCode");	//��ɫ����
	String roleName = request.getParameter("roleName");	//��ɫ����
	String loginNo1 = request.getParameter("loginNo1");	//�½����޸ĵĹ��Ŵ���		
	String popeDomCodeIn = request.getParameter("popeDomCode");	//Ȩ�޴���
	String popeDomNameIn = request.getParameter("popeDomName");	//Ȩ�޴���

	System.out.println("popeDomCodeIn="+popeDomCodeIn);
	
	if(popeDomNameIn==null)
	popeDomNameIn="ȫ��Ȩ��";
	
	String op_name = "����Ȩ�޹���";
	String note = "�������޸Ĺ���<b>("+loginNo1+")</b>��<b>"+popeDomNameIn+"</b>�µ�Ȩ����Ϣ";

	//�������
	String	checkFlag    [][]= new String[][]{};	//���ñ�־��0��ѡ�� 1ѡ�� 2������ѡ��
	String	rolePdom     [][]= new String[][]{};    //Ȩ�޴���
	String	rolePdomName [][]= new String[][]{};    //Ȩ������
	String	rolePdomType [][]= new String[][]{};    //��ϵ����
	String	beginTime    [][]= new String[][]{};    //��ʼʱ��
	String	endTime      [][]= new String[][]{};    //����ʱ��
	String	authWorkNo   [][]= new String[][]{};    //��Ȩ����
	String	authTime     [][]= new String[][]{};    //��Ȩʱ��
	String	groupId      [][]= new String[][]{};    //��Ȩ����
	String	operCode     [][]= new String[][]{};    //��������

	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	//ArrayList acceptList = new ArrayList();
		
	String paramsIn[] = new String[10];
	
	paramsIn[0] = loginNo;
	paramsIn[1] = loginNo1;
	paramsIn[2] = "8002";
	paramsIn[3] = "1";      //�޸Ĳ�ѯ
	paramsIn[4] = "0";      //����Ȩ�޴���
	paramsIn[5] = ""; 
	paramsIn[6] = ""; 
	paramsIn[7] = ""; 
	paramsIn[8] = ""; 
	paramsIn[9] = popeDomCodeIn; 
	
	//acceptList = callView.callFXService("sSetLoginRole", paramsIn,"9","region",regionCode);
%>
	<wtc:service name="sSetLoginRole" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="10" >
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>			
		<wtc:param value="<%=paramsIn[5]%>"/>
		<wtc:param value="<%=paramsIn[6]%>"/>
		<wtc:param value="<%=paramsIn[7]%>"/>
		<wtc:param value="<%=paramsIn[8]%>"/>
		<wtc:param value="<%=paramsIn[9]%>"/>	
	</wtc:service>	
	<wtc:array id="checkFlag1" start="0" length="1" scope="end"/>
	<wtc:array id="rolePdom1" start="1" length="1" scope="end"/>
	<wtc:array id="rolePdomName1" start="2" length="1" scope="end"/>
	<wtc:array id="rolePdomType1" start="3" length="1" scope="end"/>
	<wtc:array id="beginTime1" start="4" length="1" scope="end"/>
	<wtc:array id="endTime1" start="5" length="1" scope="end"/>
	<wtc:array id="authWorkNo1" start="6" length="1" scope="end"/>
	<wtc:array id="authTime1" start="7" length="1" scope="end"/>
	<wtc:array id="groupId1" start="8" length="1" scope="end"/>
	<wtc:array id="operCode1" start="9" length="1" scope="end"/>
<%	
	String errCode = retCode1;
	String errMsg =retMsg1;
	if(!errCode.equals("000000"))
	{
	%>
		  <script language='jscript'>
		     rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
		     parent.window.close();
		     //document.location="blank.html";
		  </script> 
	  
	<%
	}
	if(errCode.equals("000000"))
	{
		checkFlag  	 = checkFlag1;
		rolePdom	 = rolePdom1;
		rolePdomName = rolePdomName1;
		rolePdomType = rolePdomType1;
		beginTime    = beginTime1;
		endTime    	 = endTime1;
		authWorkNo   = authWorkNo1;
		authTime     = authTime1;
		groupId      = groupId1;
		operCode    = operCode1;
		
		for(int j = 0; j < rolePdomType.length; j++)
		{
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+rolePdomType[j][0]);
			/* ��ʼ����ʱ��Ϊ yyyyMMddHHmmss ʱ��ת��ʱ���ʽ */
			try {
			SimpleDateFormat v_dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
		  beginTime[j][0] = dateFormat2.format(v_dateFormat.parse(beginTime[j][0]));
		  endTime[j][0] = dateFormat2.format(v_dateFormat.parse(endTime[j][0]));
		  System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>"+beginTime[j][0]+"---"+beginTime[j][0]);
		  }catch(ParseException e){
		  	e.printStackTrace();
		  }
		}
	}
%>
<head>
<title><%=op_name%></title>
<script language=javascript>

function chg_check(index)
{
	if(document.all.check.length==undefined)
	{
		if(document.all.check.checked==true)
		{
			document.all.new_check.value="Y";
		}
		else
		{
			document.all.new_check.value="N";
		}
	}
	else
	{
		if(document.all.check[index].checked==true)
		{
			document.all.new_check[index].value="Y";
		}
		else
		{
			document.all.new_check[index].value="N";
		}
	}
}
//--------ȫѡ--------------
function allSelect()
{
	var i = 0;
	
	//һ�ж�û��
	if(document.all.check==undefined)
	{
		rdShowMessageDialog("��Ŀ¼��û��Ȩ��,�޷�ȫ��ѡ�У�");
		return;
	}
	//ֻ��һ��
	if(document.all.check.length==undefined)
	{
		document.all.check.checked=true;
		document.all.new_check.value="Y";	
	}
	for(i=0;i<document.all.check.length;i++)
	{
		document.all.check[i].checked=true;	
		document.all.new_check[i].value="Y";
	}
}

//----------ȫ��ȥ��--------
function noSelect()
{
	var i = 0;
	
	//һ�ж�û��		
	if(document.all.check==undefined)
	{
		rdShowMessageDialog("��Ŀ¼��û��Ȩ��,�޷�ȫ��ȡ����");
		return;
	}
	
	//ֻ��һ��
	if(document.all.check.length==undefined)
	{
		document.all.check.checked=false;	
		document.all.new_check.value="N";
	}	
	
	for(i=0;i<document.all.check.length;i++)
	{
		document.all.check[i].checked=false;
		document.all.new_check[i].value="N";
	}
}	

function doSubmit()
{
	rdShowMessageDialog("ֻ���ջ�ͬ��Ȩ�������������������Ȩ�޴��룡");
	
	if(form1.beginTime.length!=undefined )
	{
		for(var i =0;i<form1.beginTime.length;i++)
		{
			if(!forDate(document.form1.beginTime[i]) || !forDate(document.form1.endTime[i])){
			return false;
			}
		}
	}
	
	if(document.all.check==undefined)
	{
		rdShowMessageDialog("��Ŀ¼��û��Ȩ��,�޷��ύ��");
		return;
	}
	form1.action="f8058_powerCfm.jsp?loginNo1="+"<%=loginNo1%>"+"&roleCode="+"<%=roleCode%>"+"&parPopeDomCode="+"<%=popeDomCodeIn%>"+"&roleName="+"<%=roleName%>";
	form1.submit();
}

</script>
</head>
<body>
<FORM METHOD=POST ACTION="" name="form1">
<%@ include file="/npage/include/header.jsp" %>   
	<div class="title">
		<div id="title_zi"><%=note%></div>
	</div>

				<table  cellspacing="0" >	
					<tr>
						<th nowrap>ѡ��</th>						
						<th  nowrap >��������</th>
						<th  nowrap >Ȩ������</th>
						<th  nowrap >��ϵ����</th>
						<th  nowrap >��ʼʱ��</th>
						<th  nowrap >����ʱ��</th>
						<th  nowrap >��Ȩ����</th>
						<th  nowrap >��Ȩʱ��</th>
						<th  nowrap >��Ȩ����</th>
						<th  nowrap >Ȩ�޴���</th>
					</tr>
			<%
			String tbclass = "";
			for(int i = 0; i < checkFlag.length; i++)
			{
			tbclass = (i%2==0)?"Grey":"";
			%>
			<tr>
						<td class="<%=tbclass%>" nowrap>
					<%
						if(checkFlag[i][0].trim().equals("2"))
						{
						%>
							<input type="checkbox" name="check" value="<%=i%>" checked disabled >
							<input type="hidden" name="check" value="<%=i%>" checked >
						<%
						}
						else
						{
						%>
							<input type="checkbox" name="check" value="<%=i%>" onclick="chg_check(<%=i%>)"
								<%if(checkFlag[i][0].trim().equals("Y")){out.println("checked");}%>>
						<%}%>
						</td>
						<td class="<%=tbclass%>" nowrap ><%=operCode[i][0]%> 
						</td>
						<td class="<%=tbclass%>" nowrap ><%=rolePdomName[i][0]%>
						</td>
						<td class="<%=tbclass%>" nowrap >
							<select name="rolePdomType" >
							<%
														
							if(rolePdomType[i][0].trim().equals("0"))
							{
								%>
								<option value="0" selected >����</option>
								<% //vf1="selected";
							}
							else if(rolePdomType[i][0].trim().equals("1"))
							{
								%>
								<option value="1" selected >����</option>
								<% //vf2="selected";
							}
							%>								
							</select>
						</td>
						<td class="<%=tbclass%>" nowrap >
							<input type="text"  v_type="date" v_format="yyyyMMdd HH:mm:ss" v_must="1" maxlength="17" size="17" name="beginTime" value="<%=beginTime[i][0]%>">
						</td>
						<td class="<%=tbclass%>" nowrap >
							<input type="text"  v_type="date" v_must="1" maxlength="17" size="17" name="endTime" v_format="yyyyMMdd HH:mm:ss"	 value="<%=endTime[i][0]%>">
							<input type=hidden name="old_check"   value="<%=checkFlag[i][0]%>" >
							<input type=hidden name="new_check"   value="<%=checkFlag[i][0]%>" >
							<input type=hidden name="rolePdom"    value="<%=rolePdom[i][0]%>" >
							<input type=hidden name="oldPdomType" value="<%=rolePdomType[i][0]%>">
						</td>
						<td class="<%=tbclass%>" nowrap ><%=authWorkNo[i][0]%></td>
						<td class="<%=tbclass%>" nowrap ><%=authTime[i][0]%></td>
						<td class="<%=tbclass%>" nowrap ><%=groupId[i][0]%></td>	
						<td class="<%=tbclass%>" nowrap ><%=rolePdom[i][0]%></td>	
					</tr>
	<%  	
			}
	%>  	
	</talbe>
	<table   cellspacing="0" >
		<TR>
			<TD id="footer">
				<input class="b_foot_long"  name=allSelectt type=button    value="ȫ��ѡ��" onclick="allSelect()" >&nbsp;
				<input  class="b_foot_long" name=noSelectt  type=button    value="ȫ��ȡ��" onclick="noSelect()" >&nbsp;
				<input  class="b_foot" name="doButton" type="button"  value="��  ��"   onclick="doSubmit()">&nbsp;
				<input  class="b_foot" name="doButton" type="button"  value="��  ��"   onclick="parent.window.close()">&nbsp;
			</TD>	
		</TR>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>  
</form>
</html>