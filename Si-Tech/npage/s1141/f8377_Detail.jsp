<%
/********************
 version v1.0
������: si-tech
update: sunaj@2010-03-23
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>

<%
	String opCode=request.getParameter("opcode");
	String opName="����Ԥ������ϸ��Ϣ";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	String RegionName="",PayFee="",BaseFee="",BaseTerm="",FreeFee="",FreeTerm="";
	String ReturnFee="",ReturnTerm="",MonthBaseFee="",MonthConsume="",ConsumeMark="";
	String BeginTime="",EndTime="",AwardCode="",GiftCode="",retFlag="",ReturnDate="";
	String FileName="",FileNo="",AuditName="",AuditPhone ="",ReturnPayType="";
	String ReturnActionCode="";  //huangrong ���� ���ֻ����Ķ���
	String ActionNote="";  //huangrong ���� ��ע��Ϣ�Ķ��� 2010-10-21 13:54
	String channelName=""; //huangrong ���� �������ƵĶ��� 2011-8-30
	String examineSituation = request.getParameter("examineSituation"); //diling add �������@2011/10/26 
	String projectcode = request.getParameter("projectcode"); //diling add �����@2011/10/26 
	String projecttype = request.getParameter("projecttype"); //diling add �����@2011/10/26 
	String innetTime = "";
	String typeOfBaseFeeValue = "";//diling add ����Ԥ������@2012/2/3 
	String typeOfFreeFeeValue = "";//diling add �Ԥ������@2012/2/3 
	
	String paraAray[] = new String[11];
	paraAray[0] = request.getParameter("login_accept");
	paraAray[1] = "01";
    paraAray[2] = request.getParameter("opcode");
	paraAray[3] = work_no;
    paraAray[4] = password;
    paraAray[5] = "";
	paraAray[6] = "";
    paraAray[7] = request.getParameter("projectcode");
    paraAray[8] = request.getParameter("projecttype");
    paraAray[9] = regionCode;
    paraAray[10] = request.getParameter("RegionCode");
    
    System.out.println("-----------8377---------regionCode="+regionCode);
    System.out.println("-----------8377---------RegionCode="+request.getParameter("RegionCode"));
%>
	<wtc:service name="s8377Detail" routerKey="region" routerValue="<%=regionCode%>" outnum="35" retcode="retCode" retmsg="retMsg">  <!--huangrong �����θ�����26��Ϊ27�� update ������28��Ϊ29--><!--diling ��������33��Ϊ35-->
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
	<wtc:array id="tempArr1" start="23" length="3" scope="end"/>
	<wtc:array id="tempArr2" start="28" length="1" scope="end"/>	
	<wtc:array id="tempArr3" start="29" length="1" scope="end"/>	
	<wtc:array id="tempArr4" start="30" length="3" scope="end"/>	
	
<%
	String errCode = retCode;
	String errMsg  = retMsg;
 if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s8377Detail��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else 
  {
	  if (errCode.equals( "000000") && tempArr.length>0)
	  {
	  	if(!(tempArr==null))
	  	{
		    RegionName = tempArr[0][2];         //��������
		    PayFee = tempArr[0][3];             //�ֽ�
		    BaseFee = tempArr[0][4];            //����
		    BaseTerm = tempArr[0][5];           //��������
		    FreeFee = tempArr[0][6];            //�
		    FreeTerm = tempArr[0][7];     	    //�����
		    ReturnFee = tempArr[0][8];     	    //����Ԥ��
		    ReturnTerm = tempArr[0][9];    		//����Ԥ������
		    MonthBaseFee = tempArr[0][10];       //ÿ���������
		    MonthConsume = tempArr[0][11];		//ÿ�����ٹ���ֵ
		    ConsumeMark = tempArr[0][12];		//���ѻ���
		    BeginTime = tempArr[0][13];		    //��ʼʱ��
		    EndTime = tempArr[0][14];		    //����ʱ��
		    AwardCode=tempArr[0][15];	
			GiftCode=tempArr[0][16];
		    FileName = tempArr[0][17];		    //�ļ���
		    FileNo = tempArr[0][18];		    //�ļ���
		    AuditName = tempArr[0][19];		    //����������
		    AuditPhone = tempArr[0][20];		//�����˵绰
		    ReturnPayType=tempArr[0][21];       //����Ԥ���ר������
		    ReturnDate=tempArr[0][22];			//����Ԥ��������
		    ReturnActionCode=tempArr[0][26];			//���ֻ����  huangrong ���� �Ծ��ֻ����ֵ�Ļ�ȡ
		    ActionNote=tempArr[0][27];			//���ֻ����  huangrong ���� ��ע��Ϣֵ�Ļ�ȡ 2010-10-21 13:55
		    innetTime=tempArr3[0][0];
		    typeOfBaseFeeValue=tempArr[0][33];  //diling add ����Ԥ������@2012/2/3 16:29:41
		    typeOfFreeFeeValue=tempArr[0][34];  //diling add �Ԥ������@2012/2/3 16:29:41
		    System.out.println("=====8377=========tempArr[0][33]="+tempArr[0][33]);
		    System.out.println("=====8377=========tempArr[0][34]="+tempArr[0][34]);
	 	}
	 	if (tempArr2.length > 0) {
		 	for(int i=0;i<tempArr2.length;i++)
			{
				if(channelName=="")
				{
					channelName=tempArr2[i][0];
				}else{
					channelName=channelName+"��"+tempArr2[i][0];			
				}
			}
	 	} else {
	 		channelName = "��";
	 	}
	}else{%>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
				history.go(-1);
			</script>
      <%}
    }
%>

<html>
<head>
	<title>����Ԥ������ϸ��Ϣ</title>
<script language="JavaScript">

function printCommit()
{
	if("<%=opCode%>"=="8377")
	{
		frm.action="f8375_login.jsp";
		frm.submit();
	}else if("<%=opCode%>"=="8378")
	{
		frm.action="f8378_1.jsp";
		frm.submit();
	}
}

function go()
{
	if("<%=opCode%>"=="8377")
	{
		frm.action="f8377_Qry.jsp";
		frm.submit();
	}else if("<%=opCode%>"=="8378")
	{
		frm.action="f8378_1.jsp";
		frm.submit();
	}
	
}
onload=function()
{
	if("<%=opCode%>"=="8377")
	{
		table_2.style.display="";
		
	}else if("<%=opCode%>"=="8378")
	{
		table_2.style.display="none";
	}
}

//diling add@2011/10/26 �����޸��ύ��ť
function updateSubmit(){
    if(check(frm)!=true) return false;
    var stop_time = $("#stop_time").val();
    if(stop_time==""||stop_time==null){
        rdShowMessageDialog("Ӫ������ʱ��Ϊ�գ����������룡",0);
	    return false;
    }
    $("#projectcode").val("<%=projectcode%>");
    $("#projecttype").val("<%=projecttype%>");
    $("#regionCode").val("<%=regionCode%>");
    frm.action="f8377_updateSubInfo.jsp";
	frm.submit();
}

</script>
<%/*begin huangrong ��ӶԶ����ı���ı�����ʽ 2010-10-21 13:57*/%>
<style>
.TextAreaGrey{
	background-color: #EEF2F7;
	border-top-width: 0px;
	border-right-width: 0px;
	border-bottom-width: 0px;
	border-left-width: 0px;
	text-indent: 2px;
}		
</style>
<%/*end huangrong ��ӶԶ����ı���ı�����ʽ 2010-10-21 13:57*/%>
</head>
<body>
<form name="frm" method="post" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">������Ϣ</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue" width="10%">��������</td>
            <td width="20%">
					<input name="region_name" type="text"  id="region_name" value="<%=RegionName%>" class="InputGrey" readonly maxlength="30" >
            </td>
            <td class="blue" width="10%">ʡ��˾�����ļ���</td>
            <td width="20%">
					<input name="file_name" type="text"  id="file_name" value="<%=FileName%>" class="InputGrey" readonly maxlength="30" >
            </td>
            <td class="blue" width="10%">ʡ��˾�����ļ���</td>
            <td width="30%">
					<input name="file_no" type="text" id="file_no" value="<%=FileNo%>" class="InputGrey" readonly maxlength="30" >
            </td>
		</tr>
		<tr>
            <td class="blue">����������</td>
            <td>
						  <input name="audit_name"  type="text" id="audit_name" value="<%=AuditName%>" class="InputGrey" readonly>
            </td>
            <td class="blue">�����˵绰</td>
            <td colspan='3'>
						  <input name="audit_phone" type="text" id="audit_phone" value="<%=AuditPhone%>" class="InputGrey" readonly>
            </td>
            
        </tr>
		<tr>
			<!--begin add ����չʾ����Ԥ���������� by diling@2012/2/3 13:57:57 --> 
						<td class="blue">����Ԥ������</td>
            <td>
						  <input name="BaseFeeType" type="text" id="BaseFeeType" value="<%=typeOfBaseFeeValue%>" class="InputGrey" readonly>
            </td>
      <!--end add by diling -->
						<td class="blue">����Ԥ���</td>
            <td>
						  <input name="base_fee" type="text" id="base_fee" value="<%=BaseFee%>" class="InputGrey" readonly>
            </td>
            <td class="blue">����Ԥ����������</td>
            <td>
						  <input name="base_term" type="text" id="base_term"  value="<%=BaseTerm%>" class="InputGrey" readonly>
            </td>
           
     	</tr>
     	<tr>
     		<!--begin add ����չʾ�Ԥ���������� by diling@2012/2/3 13:57:57 --> 
     			<td class="blue">�Ԥ������</td>
          <td>
					  <input name="FreeFeeType" type="text" id="FreeFeeType" value="<%=typeOfFreeFeeValue%>" class="InputGrey" readonly>
          </td>
        <!--end add by diling -->
     		 <td class="blue">�Ԥ���</td>
            <td>
						  <input name="free_fee" type="text" id="free_fee" value="<%=FreeFee%>" class="InputGrey" readonly>
            </td>
            <td class="blue">�Ԥ����������</td>
            <td>
						  <input name="free_term" type="text" id="free_term" value="<%=FreeTerm%>" class="InputGrey" readonly>
            </td>
     	</tr>
		<tr>
			 <td class="blue">ÿ������Ԥ���</td>
            <td>
						  <input name="return_fee" type="text" id="return_fee" value="<%=ReturnFee%>" class="InputGrey" readonly>
            </td>
             <td class="blue">����Ԥ�������</td>
            <td>
						  <input name="return_term" type="text" id="return_term" value="<%=ReturnTerm%>" class="InputGrey" readonly>
            </td>
				<td class="blue">����Ԥ���ר������</td>
            <td>
						  <input name="return_paytype" type="text" id="return_paytype" value="<%=ReturnPayType%>" class="InputGrey" readonly>
            </td>
        </tr>
		<tr>
			<td class="blue">����Ԥ��������</td>
            <td>
						  <input name="return_date" type="text" id="return_date"  value="<%=ReturnDate%>" class="InputGrey" readonly>
            </td>
            <td class="blue">�ֽ�</td>
            <td>
						  <input name="pay_fee" type="text" id="pay_fee"  value="<%=PayFee%>" class="InputGrey" readonly>
            </td>
            <td class="blue">���ѻ���</td>
            <td>
						  <input name="consume_mark"  type="text" type="text" id="consume_mark" value="<%=ConsumeMark%>" class="InputGrey" readonly>
            </td>
        </tr>
		<tr>
            <td class="blue">ÿ���������</td>
            <td>
						  <input name="month_basefee" type="text" id="month_basefee" value="<%=MonthBaseFee%>" class="InputGrey" readonly>
            </td>
            <td class="blue">ÿ�����ٹ���ֵ</td>
            <td>
						  <input name="month_consume" type="text" id="month_consume" value="<%=MonthConsume%>" class="InputGrey" readonly>
            </td>
      	
			<td class="blue">Ӫ����ʼʱ��</td> 
            <td>
						  <input name="begin_time" type="text" id="begin_time" value="<%=BeginTime%>" class="InputGrey" readonly>
            </td>
         </tr>
		<tr>
		    <td class="blue">Ӫ������ʱ��</td>
            <td>
		    <%
		        /*** begin diling update@2011/10/26 �������Ϊ����ͨ��ʱ�����ܽ���Ӫ������ʱ����޸ġ� ***/
		         
		        if("����ͨ��".equals(examineSituation)){
		    %>
		            <input name="stop_time" type="text" id="stop_time" value="<%=EndTime%>" v_type="date"  />
		    <%
		        }else{
		    %>
		            <input name="stop_time" type="text" id="stop_time" value="<%=EndTime%>" class="InputGrey" readonly>
		    <%
		        }
		         /*** end diling update@2011/10/26  ***/
		    %>
            </td>
           <td class="blue">��Ʒ����</td> 
            <td>
						  <input name="Award_Code" type="text" id="Award_Code" value="<%=AwardCode%>" class="InputGrey" readonly>
            </td>   
            <td class="blue">��Ʒ�ȼ�</td>
            <td>
						  <input name="Gift_Code" type="text" id="Gift_Code" value="<%=GiftCode%>" class="InputGrey" readonly>
            </td>
     	</tr>
     	<!--begin  huangrong ���ӶԾ��ֻ�����ı������ʾ  -->
     	<tr>
     				<td class="blue">���ֻ����</td>
            <td>
						  <input name="action_code" type="text" id="action_code" value="<%=ReturnActionCode%>" class="InputGrey" readonly>
            </td>	
            
            <td class="blue">��������</td>
						<td colspan='3' title="<%=ActionNote%>">
							<%=channelName%>
						</td>
     	</tr>
     	<!--end -->
     	<tr>
				<td class="blue">����ʱ��</td>
				<td colspan='5'>
					<input type="text" value="<%=innetTime%>" class="InputGrey" readonly>��
				</td>     		
      </tr>	
     	<tr>
            <td class="blue">��ע</td>
						<td colspan='5'>
							<TEXTAREA NAME="do_note" id="do_note" COLS="60" ROWS="3" class="TextAreaGrey" readonly><%=ActionNote%></TEXTAREA>
						</td>     		
      </tr>	
	<table id="table_2" style="display:;" cellspacing="0">       
       	<tr>
       		<th>��������</th>
       		<th>����ʱ��</th>
       		<th>�������</th>			
       	</tr>
	<%
	for(int i=0;i<tempArr1.length;i++)
	{
	%>
	<tr>
	        <td nowrap name="Login_no"><%=tempArr1[i][0]%></td>
	        <td nowrap name="Audit_Date"><%=tempArr1[i][1]%></td>
	        <td nowrap name="Audti_Suggestion"><%=tempArr1[i][2]%></td>
	</tr>
	<%}%>
</table>
<div class="title">
	<div id="title_zi">ָ���ʷѰ��������</div>
</div>
<table id="table_3">       
	<tr>
		<th>�ʷѴ���</th>
		<th>�ʷ�����</th>
		<th>�ʷ�����</th>
	</tr>
	<%
	for(int i = 0; i < tempArr4.length; i ++) {
		%>
		<tr>
			<td><%=tempArr4[i][0]%></td>
			<td><%=tempArr4[i][1]%></td>
			<td><%=tempArr4[i][2]%></td>
		</tr>
		<%
	}
	%>
</table>
<table>
		<tr>
		    
            <td colspan="6" align="center" id="footer">
             <%
		        /*** begin diling update@2011/10/26 �������Ϊ����ͨ��ʱ�������ύ��ť�� ***/
             %>
                 <input type="hidden" id="projectcode" name="projectcode" value="" />
		        <input type="hidden" id="projecttype" name="projecttype" value="" />
		        <input type="hidden" id="regionCode" name="regionCode" value="" />
             <%		         
		        if("����ͨ��".equals(examineSituation)){
		    %>
		            <input name="confirm" type="button" class="b_foot" index="2" value="�ύ" onClick="updateSubmit()" >
		    <%
		        }
		        /*** end diling update@2011/10/26  ***/
		    %>
                 
                <input name="confirm" type="button" class="b_foot" index="2" value="�ر�" onClick="printCommit()" >
                <input name="back" type="button" class="b_foot" value="����" onClick="go()">
            </td>
		</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

