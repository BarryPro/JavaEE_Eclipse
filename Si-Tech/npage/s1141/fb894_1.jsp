<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ͳһԤ������2289
   * �汾: 1.0
   * ����: 2008/12/31
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode="b894";
	String opName="���Ŀͻ�����";
  String loginPwd    = (String)session.getAttribute("password"); //��������
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String[][] favInfo = (String[][])session.getAttribute("favInfo");  				//���ݸ�ʽΪString[0][0]---String[n][0]
	String groupId = (String)session.getAttribute("groupId");
	String flag= request.getParameter("flag");
	int recordNum=0;
	int i=0;
	
	String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
	String timesql = "select to_char(sysdate,'YYYYMMDD') from dual ";
	String errCode2 = "";//retCode3;
    String errMsg2 = "";//retMsg3;
	 
	String retFlag="",retMsg="";
	String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
	String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
	String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
	String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
	String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
	String point_note="",open_time="";
	String  start_time="";

	String iPhoneNo = request.getParameter("srv_no");
	String iOpCode = request.getParameter("opcode");
	String cus_pass = request.getParameter("cus_pass");
	%>
	<wtc:pubselect name="TlsPubSelBoss"  retcode="retCode" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=timesql%></wtc:sql>
	</wtc:pubselect>
		
	<wtc:array id="time1" start="0" length="1" scope="end" />
	<%
	String errCode21 = retCode;
    String errMsg21 = retMsg1;
	if(time1==null||time1.length==0){

		retMsg1 = "��ȡϵͳʱ�䱨��!<br>errCode: " + errCode21 + "<br>errMsg+" + errMsg21;
		%>
		<script language="javascript">
			rdShowMessageDialog("����δ�ܳɹ�,�������<%=errCode21%><br>������Ϣ<%=errMsg21%>!");
			 
		</script>
	<%}
	String times = time1[0][0];
	System.out.println("1111111111111111111111111111111111 and times is "+times);
	
	String querysql = "select project_name,project_code,transin_fee from STRANSFERACTIVE where region_code =" +regionCode+" and "+times+" between begin_time and end_time ";
	//String querysql2 = "select transin_fee from STRANSFERACTIVE where project_code =  ?  ";
%>

<%
 
String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;

  
   %>

	<wtc:service name="s2289Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="32" retcode="retCode" retmsg="retMsg1">
		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=" "/>
		<wtc:param value="<%=orgCode%>"/>


 
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  String errCode = retCode;
  String errMsg = retMsg1;

  System.out.println("errCode="+errCode);
  System.out.println("errMsg ="+errMsg);

  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "sb894Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals( "000000") && tempArr.length>0){
	  	if(!(tempArr==null)){
		    bp_name = tempArr[0][3];           //��������xl
	 
		    sm_name = tempArr[0][12];          //ҵ���������xl
	 
		    rate_name = tempArr[0][6];    		//�ʷ�����xl
		 
		    prepay_fee = tempArr[0][16];		//��Ԥ��xl
		   
		    print_note = tempArr[0][25];		//�������xl
		 
	 	}
	}else{%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
				history.go(-1);
			</script>
      <%}
  }
%>
 
 	<wtc:pubselect name="TlsPubSelBoss"  retcode="retCode3" retmsg="retMsg3" outnum="3">
	<wtc:sql><%=querysql%></wtc:sql>
	</wtc:pubselect>
		
	<wtc:array id="result0" start="0" length="3" scope="end" />
<%	
	
	if(result0==null||result0.length==0){
		System.out.println("888888888888888888888888weikong");
		 
		%>
		<script language="javascript">
			 
			rdShowMessageDialog("����δ�ܳɹ�,������Ϣ����ѯ�����������ϢΪ��!");
			//history.go(-1); 
		</script>
	<%}
 
	 System.out.println("qweqwe1111111111111111111111111111111111111111111");
 

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>��̨�Ӻ��Ŀͻ������</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
 
  //����ȫ�ֱ���
  var project_code = new Array();
  var transin_fee = new Array();//where���� �� projectCode Ҫ��ѯ��ʾ���� fee
	 
<%
	System.out.println("qweqwe1888888888888888888888888888881111111111111");
	if(result0.length >0){
		for(int m=0;m<result0.length;m++)
		  {
			out.println("project_code["+m+"]='"+result0[m][1]+"';\n");
			out.println("transin_fee["+m+" ]='"+result0[m][2]+"';\n");
		  }
	}
	else{
	System.out.println("qweqwe9888800000000000000000111");
	}
	


%> 
function frmCfm()
{
		 
		
		posSubmitForm();
		
		
		 
} 
	/* ningtn add for pos start @ 20100430 */
	function posSubmitForm(){
		frm.submit();
		return true;
	}
	 
	 
	/* xl ��̨�Ӻ��Ļ��� */
 function chkType(choose,ItemArray,GroupArray)
 {
 	document.getElementById("cz").value ="";
	for ( x = 0 ; x < ItemArray.length  ; x++ )
	   {
		   if ( ItemArray[x] == choose.value )
		  {
	 
		   document.getElementById("cz").value = GroupArray[x];
		  }
	   }
	 }

 

 

 
/**/
function printCommit()
{
	 
 	 
	if(document.all.czje.value==""){
		rdShowMessageDialog("��ѡ�񷽰�����!");
		document.all.projectType.focus();
		return false;
	}
 

     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
     {
	   frmCfm();
     }
  
  return true;
}

 
</script>

</head>
<body>
<form name="frm" method="post" action="fb894Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	 

	 
	 

	<div class="title">
		<div id="title_zi">ҵ����ϸ</div>
	</div>
<table cellspacing="0">
	
	<tr>
		<td class="blue">�ֻ�����</td>
		<td width="39%">
			<input class="InputGrey" type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo"  maxlength=11 index="3" readonly >
		</td>
		<td class="blue">��������</td>
		<td>
			<input name="oCustName"  type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">ҵ��Ʒ��</td>
		<td>
			<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
		</td>
		<td class="blue">�ʷ�����</td>
		<td>
			<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" size ="40" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">�ʺ�Ԥ��</td>
		<td>
			<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=prepay_fee%>" readonly>
		</td>
		<td class="blue">��ǰ����</td>
		<td>
			<input name="oMarkPoint" type="text" class="InputGrey" id="oMarkPoint" value="<%=print_note%>" readonly>
		</td>
	</tr>
	 
	<tr>
		<td class="blue">��������</td>
		<td colspan="3">
			<select id=projectType name=projectType onChange="chkType(this,project_code,transin_fee)" style="width:300px;" >
				<option value = "0" selected>��ѡ��Ŀ��ͻ����ѽ�� </option>
				<%
					if(result0.length > 0){
						System.out.println("2222222222222222222222222222222222222222222222");
						for(int k =0;k<result0.length;k++)
						{%>
							<option value="<%=result0[k][1]%>"><%=result0[k][0]%></option>
						<%}
					}
					else{
						System.out.println("33333333333333333333333333333332222222222211111111111111111");
						
					}	
						%>
			</select>
		</td>

	</tr>
	<tr>
	<td class="blue">��ֵ���</td>
	<td colspan="3" ><input id="cz" type="text" class="InputGrey" name = "czje" readonly>Ԫ </td>
	</tr>
	 
	 
	 
	<tr>
		<td colspan="4" align="center" id="foot">
			&nbsp;
			<input name="commit" id="commit" type="button" class="b_foot"   value="ȷ��&��ӡ" onClick="printCommit();">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="���" >
			&nbsp;
			<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
			<input type = "hidden" name = "iOpCode" value ="<%=opCode%>">
			<input type = "hidden" name = "loginNo" value ="<%=loginNo%>">
			&nbsp;
		</td>
	</tr>
</table>

<div name="licl" id="licl">
			 
		 
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
 
</body>
</html>
