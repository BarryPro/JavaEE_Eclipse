<%
	/********************
	 version v2.0
	������: si-tech
	*
	*update:zhanghonga@2008-08-12 ҳ�����,�޸���ʽ
	*
	********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

	String opCode = "1500";
  String opName = "�ۺ���Ϣ��ѯ֮�û��ʵ�";
  
	String org_code = (String)session.getAttribute("orgCode");
	String busy_name="";
	String TGroupFlag="";
	String TBigFlag = "";
	String BigFlag = "0";
	String rowNum = "16";
	
	String phoneNo = request.getParameter("phoneNo");
	String count = request.getParameter("count");
	String busy_type = request.getParameter("busy_type");
	String idNo = request.getParameter("idNo");
	String op_code = "1500";
	// xl add ����У��
	String pwdcheck = request.getParameter("pwdcheck"); 
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAA pwdcheck is "+pwdcheck);
	if(busy_type.equals("1"))
	{
		busy_name="�û��ʵ�";
	}else{
		busy_name="�ʻ��ʵ�";
	}
		/**
		try
		{	s1500moreWrapper wrapper = new s1500moreWrapper();//ʵ����wrapper
			arlist = wrapper.wrapper_s1500UConQry(phoneNo,count,busy_type,org_code,op_code,"5"); 
			//System.out.println(" call ebj 55555555555555555555555");
		}
		catch(Exception e)
		{
			//System.out.println("����EJB����ʧ�ܣ�");
		}
	**/
%>
	<wtc:service name="s1500UConQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="21" >
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=count%>"/>
	<wtc:param value="<%=busy_type%>"/>
	<wtc:param value="<%=org_code%>"/>
	<wtc:param value="5"/>
	</wtc:service>
	<wtc:array id="result" start="0" length="10" scope="end"/>
	<wtc:array id="result2" start="10" length="11" scope="end"/>
<%
	int iretCode = 0;
	if(retCode1!=null&&!"".equals(retCode1)){
		iretCode=Integer.parseInt(retCode1);
	}
	if(iretCode!=0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("����δ�ܳɹ�,�������<%=retCode1%><br>������Ϣ<%=retMsg1%>!");
	</script>
<%
		return;
	}
	
	if((result==null||result.length==0)&&(result2==null||result2.length==0)){
%>
	<script language="javascript">
		rdShowMessageDialog("�û��˵���Ϣ������!");
		history.go(-1);
	</script>
<%
		return;	
	}

	String return_code =result[0][0];
	String return_msg = "";   
	String countName  = "";   
	String userType   = "";   
	String currentFee = "";		
	String predelFee  = "0";            
	String phoneNum   = "";   
	String prepayFee  = "";   
	String contract   = "";   
	String sTotalFee = "0";

	double sum_delayfee=0.00;
	double sum_owefee=0.00;
	int flag=0;

	//System.out.println("return_code "+return_code);
	//System.out.println("return_msg "+return_msg);
	if (Integer.parseInt(return_code)==0)
	{
		return_msg = result[0][1];   
		countName  = result[0][2];   
		userType   = result[0][3];   
		currentFee = result[0][5];	
		predelFee  = "0";            
		phoneNum   = result[0][6];   
		prepayFee  = result[0][4];   
		contract   = result[0][8];  
		if ( userType.equals("999") )
		{
			BigFlag = "1";
		}
		else 
		{
			if (userType.substring(0,2).equals("01") )
			{
				TBigFlag = "��ʯ���ͻ�";
			}
			else if (userType.substring(0,2).equals("02") )
			{
				TBigFlag = "�𿨿ͻ�";
			}
			else if (userType.substring(0,2).equals("03") )
			{
				TBigFlag = "�����ͻ�";
			}
			else if (userType.substring(0,2).equals("04") )
			{
				TBigFlag = "������ͻ�";
			}
			else if (userType.substring(0,2).equals("05") )
			{
				TBigFlag = "��ͻ�";
			}
			else
			{
				TBigFlag = "��ͨ�ͻ�";
			}
			if ( userType.substring(2,3).equals("0"))
			{
				TGroupFlag = "�Ǽ��ſͻ�";
			}
			else if (userType.substring(2,3).equals("1"))
			{
				TGroupFlag = "������ͨ�ͻ�";
			}
			else if (userType.substring(2,3).equals("2"))
			{
				TGroupFlag = "�����и߼�ֵ�ͻ�";
			}
			else if (userType.substring(2,3).equals("3"))
			{
				TGroupFlag = "�����еĴ�ͻ�";
			}

		} 


		for (int i=0; i< result2.length;i++)
		{
			sum_owefee = sum_owefee + Double.parseDouble(result2[i][5]);
			sum_delayfee = sum_delayfee + Double.parseDouble(result2[i][6]);
		}
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAA");
		//double dTotalFee = sum_delayfee+sum_owefee+Double.parseDouble(predelFee)+Double.parseDouble(currentFee);
		double dTotalFee = 0.00;
		//System.out.println("BBBBBBBBBBBBBBBBBBBBBBB");
		String tmp1=Double.toString(dTotalFee*100+0.5);		
		if (tmp1.indexOf(".")!=-1){
		String tmp2 = tmp1.substring(0,tmp1.indexOf("."));
			double tmp3 = Double.parseDouble(tmp2);
			sTotalFee=Double.toString(tmp3/100);		
		}
%>
<script language="JavaScript">
	 var GroupFee = new Array(11);
	   GroupFee[0] = new Array();
	   GroupFee[1] = new Array();
	   GroupFee[2] = new Array();
	   GroupFee[3] = new Array();
	   GroupFee[4] = new Array();
	   GroupFee[5] = new Array();
	   GroupFee[6] = new Array();
	   GroupFee[7] = new Array();
	   GroupFee[8] = new Array();
	   GroupFee[9] = new Array();
	   GroupFee[10] = new Array();   
<%
	 for(int x = 0; x< result2.length; x++){
%>
	     GroupFee[0][<%= x %>] = "<%= result2[x][0] %> ";
		 GroupFee[1][<%= x %>] = "<%= result2[x][1] %> ";
		 GroupFee[2][<%= x %>] = "<%= result2[x][2] %> ";
		 GroupFee[3][<%= x %>] = "<%= result2[x][3] %> ";
		 GroupFee[4][<%= x %>] = "<%= result2[x][4] %> ";
		 GroupFee[5][<%= x %>] = "<%= result2[x][5] %> ";
		 GroupFee[6][<%= x %>] = "<%= result2[x][6] %> ";
		 GroupFee[7][<%= x %>] = "<%= result2[x][7] %> ";
		 GroupFee[8][<%= x %>] = "<%= result2[x][8] %> ";
		 GroupFee[9][<%= x %>] = "<%= result2[x][9] %> ";
		 GroupFee[10][<%= x %>] = "<%= result2[x][10] %> ";		 
<%
	}
%> 
 
</script>
<%
	}else if (return_code.equals("150011")){
		  flag = 1;
	}else{
			flag = 2;
	}
%>

<HTML><HEAD>

<script language="JavaScript">

 function showSelWindow()
 {
		var userGroup = new Array(<%=result2.length%>);
			userGroup[0] = new Array(2);
			userGroup[1] = new Array(2);
		<%for(int x = 0; x< result2.length; x++)
		{%>
			userGroup[<%= x %>][0]= "<%=result2[x][0]%>";
			userGroup[<%= x %>][1]= "<%=result2[x][1]%>";
		<%}%>

		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight "+300+"px; dialogWidth "+500+"px; dialogLeft "+l+"px; dialogTop "+t+"px;toolbar no; menubar no; scrollbars yes; resizable no;location no;status no";
		var str=window.showModalDialog('getUserCount.jsp?userGroup='+userGroup,"",prop);

		if( typeof(str) != "undefined" ){
			if ( str == "0" ){
				history.go(-1);
			}
			else{

			}
		}
 }
 function init(){
		//�������ȱʡֵ�ǹ淶�е�Ҫ��
		<% if ( flag == 2 ){%>
			rdShowMessageDialog("δ��ѯ���û��˵��������!<br>������� :<%=return_code%>");
			history.go(-1);
		<%}%>
		<% if ( flag == 1 ){
		%>
			showSelWindow();
		<%}%>

	}
</script> 
 
<title>�������ƶ�ͨ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<BODY onLoad="init();">
<FORM method="post" name="form">
		<input type="hidden" name="Op_Code"  value=<%=op_code%>>
		<input type="hidden" name="busy_type"  value=<%=busy_type%>>
		<input type="hidden" name="sumdelayFee"  value=<%=sum_delayfee%>>
		<input type="hidden" name="unitCode" value="<%=org_code%>">
		<input type="hidden" name="sumFee"  value=<%=sTotalFee%>>
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�û��˵�</div>
		</div>
       <table cellspacing="0">
         <tr>
           <td class="blue">�ʵ�����</td>
           <td>
             <input type="text" class="InputGrey" readonly name="TbusyName" size="16" maxlength="12"  value=<%=busy_name%>>
           </td>
           <td class="blue">��������</td>
           <td>
             <input type="text"  class="InputGrey" readonly name="PhoneNum" size="36" maxlength="12" value=<%=phoneNum%>>
           </td>
         </tr>
         <tr> 
           <td class="blue">�ʻ�����</td>
           <td> 
             <input type="text" class="InputGrey" readonly name="count" size="16" maxlength="12"  onKeyPress="return isKeyNumberdot(0)" value=<%=contract%>>
           </td>
           <td class="blue">�ʻ����� </td>
           <td>
		   <%
			 //pwdcheck="N";
			 if(pwdcheck=="Y" ||pwdcheck.equals("Y"))
			 {
				 %>
				 <input type="text" name="countName"  readonly class="InputGrey" size="36" maxlength="36" value=<%=countName%>>
				 <%
			 }
			 else if(pwdcheck=="N" ||pwdcheck.equals("N"))
			 {
				 %>
				 <input type="text" name="countName"  readonly class="InputGrey" size="36" maxlength="36" value=<%=countName.substring(0,1)%>XX>
				 <%
			 }
			 else
			 {
				 %>
				 <input type="text" name="countName"  readonly class="InputGrey" size="36" maxlength="36" value="����״̬δȷ�ϣ��ʻ����Ʋ�չʾ">
				 <%
			 }
		   %>
             
           </td>
         </tr>
         <tr id="bat_id"> 
           <td class="blue">Ԥ���</td>
           <td> 
             <input type="text"  class="InputGrey" readonly name="prepayFee" size="16" maxlength="12" value=<%=prepayFee%>>
           </td>
           <td class="blue">��������</td>
           <td> 
             <input type="text"  class="InputGrey" readonly name="predelFee" size="12" maxlength="10" value=<%=predelFee%>>
           </td>
         </tr>
         <tr id="phoneId"> 
           <td class="blue">�ֻ�����</td>
           <td colspan="3"> 
             <input type="text" readonly class="InputGrey" name="phoneNo" size="16" maxlength="11" value=<%=phoneNo%> >
           </td>
        </tr>
       </table>
		  
		  </div>
		  
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">�˵���ϸ</div>
			</div>
		  
       <table style="cursor:hand" cellspacing="0">
         <tr align="center"> 
             <th>&nbsp;</th>
	           <th>�ֻ�����</th>
	           <th>�ʵ�����</th>            
	           <th>�ʵ�״̬</th>
	           <th>��ʼʱ��</th>
	           <th>����ʱ��</th>                        
	           <th>Ƿ�ѽ��</th>
	           <th>���ɽ�</th>
	           <th>Ӧ�ս��</th>
	           <th>�Żݽ��</th>
	           <th>Ԥ�滮��</th>
	           <th>�½���</th>
         </tr>
		 <%
		 		String tbClass="";
			  for (int i=0;i<result2.length;i++){
			  	if(i%2==0){
			  		tbClass="Grey";
			  	}else{
			  		tbClass="";	
			  	}
		%>
					<tr align="center">
		<%
		  		if ( busy_type.equals("2") ){
		%>
					 
					   <td> 
			         <input type="checkbox" name="checkbox" value=<%=result2[i][0]%> checked onclick="">
			       </td>
    <%
            }else{
    %>
	           <td>&nbsp;</td>
    <%
     				}
    %>
           <a href="f1500ConFee.jsp?idNo=<%=idNo.trim()%>&yearMonth=<%=result2[i][1]%>&phoneNo=<%=phoneNo%>&contractNo=<%=count%>&billBegin=<%=result2[i][3]%>&billEnd=<%=result2[i][4]%>&statusName=<%=result2[i][2]%>" target="_blank">
	           <td class="<%=tbClass%>"><%=result2[i][0]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][1]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][2]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][3]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][4]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][5]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][6]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][7]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][8]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][9]%></td>
	           <td class="<%=tbClass%>"><%=result2[i][10]%></td>    
           </a>
         </tr>
		<%
		 	}
		%>
       </table>
        
       <TABLE cellSpacing="0">
         <TR> 
           <td noWrap colspan="6" id="footer"> 
             <div align="center"> 
               <input type="button" name="return" class="b_foot" value="����" onClick="window.history.go(-1)">
               <input type="button" name="return" class="b_foot" value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
            </td>
         </TR>
       </TABLE>
        
       <%@ include file="/npage/include/footer.jsp" %>
</FORM>
 
</body>
</html>
