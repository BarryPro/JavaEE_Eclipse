   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-11
********************/
%>
              
<%
  String opCode = "3172";
  String opName = "һ��֧���ʻ��ɷ�";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="org.apache.log4j.Logger"%>
<%
	Logger logger = Logger.getLogger("f3172_1.jsp");
	//xl add for Ԥ����Ʊ����
	String account_id = WtcUtil.repNull(request.getParameter("account_id"));
	String invoice_money = WtcUtil.repNull(request.getParameter("invoice_money"));
	String loginaccept = WtcUtil.repNull(request.getParameter("loginaccept"));
	String print_flag = WtcUtil.repNull(request.getParameter("print_flag"));
	System.out.println("ccccccccccccccccccccccccccccccccccccccc loginaccept is "+loginaccept+" and print_flag is "+print_flag+" and invoice_money is "+invoice_money);
	//xl add for Ԥ����ʱ�� ��������Ϊֻ������
	String s_read_only="";
	if(invoice_money!=null &&!("".equals(invoice_money)) )
	{
		s_read_only="readonly";
		System.out.println("cssssssssssssssssssss go here?");
	}
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa s_read_only is "+s_read_only);
	//yyyyMM��ʽ����������
	GregorianCalendar cal=new GregorianCalendar();
  cal.setTime(new java.util.Date());     
  cal.add(GregorianCalendar.MONTH,-1);
  String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(cal.getTime());
	
	//��ȡ�û�session��Ϣ
	String workNo   = (String)session.getAttribute("workNo");             //����
	String workName = (String)session.getAttribute("workName");             //��������
	String org_code = (String)session.getAttribute("orgCode");							//��������	
	String nopass  = (String)session.getAttribute("password");  							//����
	String regionCode = (String)session.getAttribute("regCode");
	String result2 [][] = new String[][]{};				//2	���ſͻ�ID            
	String result3 [][] =new String[][]{};					//3	BOSS���ſͻ�ID        
	String result4 [][] = new String[][]{};				//4	��ҵ����              
	String result5 [][] = new String[][]{};				//5	������ID              
	String result6 [][] =new String[][]{};					//6	���ſͻ�����          
	String result7 [][] = new String[][]{};				//7	����ʡ��              
	String result8 [][] = new String[][]{};				//8	���˴�������          
	String result9 [][] =new String[][]{};					//9	�������ʻ�ID          
	String result10 [][] = new String[][]{};			//10	֧��˳��        	
	String[][] result_t2 = new String[][]{};
	String[][] result_t1 = new String[][]{};
	
	String[][] nameResult = new String[][]{};
	String errCode ="";
	String errMsg = "";
	String action=request.getParameter("action");//�ύ����ҳ��
	String yearMonth=new java.text.SimpleDateFormat("yyyyMM").format(Calendar.getInstance().getTime());
	int nextFlag=1;
	
	String contract_no = "";
	String qryMonth = "";
	double sumUse=0;
	double sumDelay=0;
	double sumState=0;
	String accountNum="";
	// add by hq for lizhongqiu
	String nameSql="";
	
	if (action!=null&&action.equals("select")){
	
			contract_no = request.getParameter("contract_no");//֧���ʻ���
			qryMonth = request.getParameter("qryMonth");//��ѯ�·�
			//xl add invoice_money
			String invoice_money1 = request.getParameter("invoice_money");
		 
		 	String paramsIn[] = new String[4];
		 	
		 	paramsIn[0]=workNo;
		 	paramsIn[1]=nopass;
		 	paramsIn[2]=contract_no;
		 	paramsIn[3]=qryMonth;
			
				String sqlStr1="";
			sqlStr1 ="select to_char(count(*)) from dconmsg where account_type='1' and  contract_no='?'";
			//retList1 = callView.sPubSelect("1",sqlStr1,"region",regionCode);
			nameSql="select a.cust_name from dcustdoc a ,dconmsg b where a.cust_id=b.con_cust_id and b.contract_no='?'";
			
			
%>

		<wtc:pubselect name="TlsPubSelBoss" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=nameSql%></wtc:sql>
 	   <wtc:param value="<%=contract_no%>"/>
 	  </wtc:pubselect>
	 <wtc:array id="name_result" scope="end"/>
	 	

		<wtc:pubselect name="TlsPubSelBoss" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	   <wtc:param value="<%=contract_no%>"/>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1t" scope="end"/>

<%			
			nameResult=name_result;
			//String[][] retListString1 = (String[][])retList1.get(0);
			result_t1 = result_t1t;
			accountNum=(String)((result_t1[0][0]).trim());
			 System.out.println("-----------------accountNum--------------"+accountNum);
			 
			//��ѯ�ʻ���Ϣ
			//acceptList = callView.callFXService("s3172Init", paramsIn, "10");
%>

    <wtc:service name="s3172Init" outnum="12" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
		</wtc:service>
		<wtc:array id="result_t2t1" start="0" length="1" scope="end" />
		<wtc:array id="result_t2t" start="1" length="1" scope="end" />
		<wtc:array id="result21" start="2" length="1" scope="end" />
		<wtc:array id="result31" start="3" length="1" scope="end" />			
		<wtc:array id="result41" start="4" length="1" scope="end" />
		<wtc:array id="result51" start="5" length="1" scope="end" />
		<wtc:array id="result61" start="6" length="1" scope="end" />
		<wtc:array id="result71" start="7" length="1" scope="end" />		
		<wtc:array id="result81" start="8" length="1" scope="end" />
		<wtc:array id="result91" start="9" length="1" scope="end" />
		<wtc:array id="result101" start="10" length="1" scope="end" />											
<%			
			result2 =	result21 ;	         
			result3 =	result31 ;	      
			result4 =	result41 ;	            
			result5 =	result51 ;        
			result6 =	result61 ; 
			result7 =	result71 ;            
			result8 =	result81 ;   
			result9 =	result91 ;   
			result10 = result101;
						        
			System.out.println("result_t2tresult_t2t===="+result_t2t.length);
			for(int hjw=0;hjw<result_t2t.length;hjw++)
			{
				for(int hhh=0;hhh<result_t2t[hjw].length;hhh++)
					System.out.println("-----------------result_t2t["+hjw+"]["+hhh+"]-----------------"+result_t2t[hjw][hhh]);
			}
			result_t2 = result_t2t;
			System.out.println("-----------------code2--------------"+code2);
			errCode = code2;
			errMsg = msg2;
			System.out.println("end get server");	 		
			if(!errCode.equals("000000"))
			{
				%>        
			    <script language='jscript'>
			       rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
			       history.go(-1);
		      </script> 
				<%  
			}
			if(errCode.equals("000000"))
			{
				nextFlag = 2;
			}
			
			}

%>
<html>
<head>
<base target="_self">
<title>һ��֧���ɷ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<script language="JavaScript"> 
	
		// ���ù������棬��ѯ֧���ʻ�   end 
	

	//---------------------------��ȡrpc���ص��û���Ϣ--------------------------------
	function doProcess(myPacket)
	{
		var i_yk = myPacket.data.findValueByName("i_yk");
		var errCode    = myPacket.data.findValueByName("errCode");
		var retMessage = myPacket.data.findValueByName("errMsg");//�������ص���Ϣ		
		var retFlag    = myPacket.data.findValueByName("retFlag");
 
        var invoice_money ="<%=invoice_money%>";
		if(i_yk>0 &&invoice_money=="")
		{
			rdShowMessageDialog("���˺�Ԥ����ͨ��Ʊδ����,����ͨ��zg46����Ԥ�����պ��ٽ��нɷѲ���!");
			return false;
		}
		else
		{
			self.status="";
			//�����ɹ�
			if (errCode==000000)
			{
					var num = myPacket.data.findValueByName("num");
					if(num=="0"){
						rdShowMessageDialog("���ʻ����������������������룡",0);	
					}
					else{
						rdShowMessageDialog("��֤�ɹ���",2);	
						document.all.cfmButton.disabled=false;
					}
			}
		}
			
		
 		
		
	}
	
	function changeCon(){
		
		document.all.cfmButton.disabled=true;
	}
	
	function doQuery(invoice_money,loginaccept,print_flag)
	{
		//alert("doQuery is " +invoice_money);
		if(!forNonNegInt(document.form1.contract_no))
		return false;
		
		document.form1.action = "f3172_1.jsp?action=select&invoice_money="+invoice_money+"&loginaccept="+loginaccept+"&print_flag="+print_flag;
		//alert("document.form1.action is "+document.form1.action);
		document.form1.submit(); 
	}
	
		function queryAccount()
	{		
		/**
		if (!forIdCard(document.all.idCard))
    {
    	return false;
    }
	  else{   */		
			var pageTitle = "֧���ʻ���Ϣ";
		  var fieldName = "�ʺ�|�ʻ�����|";
			var sqlStr = "";
	    var selType = "S";    //'S'��ѡ��'M'��ѡ
	    var retQuence = "2|0|1|";
	    var retToField = "contract_no|accountName|";		    	
	    if(pubSimpSelAccount(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));			
	  //}	
	}
	
	function pubSimpSelAccount(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{	    
    var path = "f3172_account_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&idCard="+document.all.idCard.value;
    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
		return true;
	}
	
		function getvaluecust(retInfo)
	{
	    var retToField = "contract_no|accountName|";
	    if(retInfo ==undefined)      
	    {   return false;   }
	
		var chPos_field = retToField.indexOf("|");
	    var chPos_retStr;
	    var valueStr;
	    var obj;
	    while(chPos_field > -1)
	    {
	        obj = retToField.substring(0,chPos_field);
	        chPos_retInfo = retInfo.indexOf("|");
	        valueStr = retInfo.substring(0,chPos_retInfo);
	        document.all(obj).value = valueStr;
	        retToField = retToField.substring(chPos_field + 1);
	        retInfo = retInfo.substring(chPos_retInfo + 1);
	        chPos_field = retToField.indexOf("|");	        
	    }
	}
	
		function checkAccount(){
		if(!forNonNegInt(document.all.contract_no)){
			return false;
		}
		var contract_no=document.all.contract_no.value;
		var myPacket = new AJAXPacket("f3172_account_rpc.jsp","������֤�ʻ���Ϣ�����Ժ�......");		
		myPacket.data.add("contract_no",contract_no);	
		core.ajax.sendPacket(myPacket);
		myPacket = null
	}
	
	 <%
  if(nextFlag==2)//��ѯ����
  {

  %>
		
	function submitValue()
	{
			getAfterPrompt();
			if(document.all.payType.value=="0")//�ֽ�ɷ�
			{
				var m = <%=result9[0][0]%>;//"17281100";//;
				var n = <%=result8[0][0]%>;
				//alert("m is "+m+" and n is "+n);
				if(document.all.cashPay.value.substring(0,1)=="-"){
					rdShowMessageDialog("���ѽ��������븺��!",0);
					return false;
				}
				/*
				if(parseFloat(document.all.cashPay.value)<=0){
					rdShowMessageDialog("���ѽ��������0!",0);
					return false;
				}
				*/
				//xl add for zg46�����Ĳ��ж��Ƿ�С�ںϼ�Ӧ��
				//alert("read ony is "+"<%=s_read_only%>");
				if("<%=s_read_only%>"!="readonly")
				{
					//alert("�ж� ��="+parseFloat(document.all.cashPay.value)+parseFloat(n)+" and m is "+parseFloat(m));
					if(parseFloat(document.all.cashPay.value)+parseFloat(n) < parseFloat(m))
					{
						rdShowMessageDialog("���ѽ��ӿ��ý��ĺͲ���С�ںϼ�Ӧ��!",0);  
						document.all.cashPay.select();
						document.all.cashPay.focus();
						return false;
					}
				}
				else
				{
					//alert("���ж�");
				}
				
			}
		else//���нɷ�
		{
			if (checkGetCheckFee() == false)
			{
				return false;
			}
			
			if (document.form1.currentMoney.value == "")
			{
				rdShowMessageDialog("�����ý�����Ϊ�գ�",0);	
				return false;	 		
			}
			
			if (parseInt(document.form1.cashPay.value)>parseInt(document.form1.currentMoney.value))
			{
				rdShowMessageDialog("�����ѽ����ܴ��ڡ����ý���",0);	
				return false;	 		
			}			
		}
		if((parseFloat(document.all.rate.value)<0) || (parseFloat(document.all.rate.value)>1)){
			rdShowMessageDialog("�����ɽ��Ż��ʡ�ֻ����0��1֮���С����",0);
			return false;
		}
		if(!forDate(document.all.yearMonth)){
			return false;
		}
		
		var prtFlag=0;
 		prtFlag = rdShowConfirmDialog("֧���ʺ�"+document.all.contract_no.value+"<BR>�ɷѽ��"+document.all.cashPay.value+"<BR>�Ƿ�ȷ���ɷѣ�");
		//xl add ��ӡ��ˮ loginaccept
		var loginaccept = document.getElementById("loginaccept").value;
		var print_flag  = document.getElementById("print_flag").value;
		//alert("loginaccept is "+loginaccept+" and print_flag is "+print_flag);
 		if (prtFlag==1)
		{
			document.form1.action="f3172cfm.jsp?loginaccept="+loginaccept+"&print_flag="+print_flag;
			document.form1.submit();
		}
		
				  
	}
	
	//��һ��
	function previouStep(){
		history.go(-1);
	}
	
//ѡ��֧����ʽ
function changePayType(){
	if (document.all.payType.value == "0"){
			document.all.tab1.style.display = "none";		
	}
	else {
		document.all.tab1.style.display = "";		
	}
}
	
		/************************** ���ù������棬��ѯ���д���   begin *******************/
	function getBankCode()
	{
		var pageTitle = "���д����ѯ";
	    var fieldName = "���д���|��������|";
	    var sqlStr = "";
	    var selType = "S";    //'S'��ѡ��'M'��ѡ
	    var retQuence = "2|0|1|";
	    var retToField = "bankCode|bankName|";
	    pubSimpSelBankCode(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
	}
	
	function pubSimpSelBankCode(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{	    
	    var path = "f1393_bankCode_sel.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType +"&bankName=" + document.all.bankName.value+"&bankCode=" + document.all.bankCode.value;
	
	    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	
		return true;
	}
	
	function getvalue(retInfo)
	{
	    var retToField = "bankCode|bankName|";
	    if(retInfo ==undefined)      
	    {   return false;   }
	
		var chPos_field = retToField.indexOf("|");
	    var chPos_retStr;
	    var valueStr;
	    var obj;
	    while(chPos_field > -1)
	    {
	        obj = retToField.substring(0,chPos_field);
	        chPos_retInfo = retInfo.indexOf("|");
	        valueStr = retInfo.substring(0,chPos_retInfo);
	        document.all(obj).value = valueStr;
	        retToField = retToField.substring(chPos_field + 1);
	        retInfo = retInfo.substring(chPos_retInfo + 1);
	        chPos_field = retToField.indexOf("|");	        
	    }	   		    			
	}
	
 	
 	/************************** ��ѯ���ý�� ************************/
 	function getCheckFee() 
 	{	
		var bankCode = document.form1.bankCode.value;
		var checkNo = document.form1.checkNo.value;	
		
		if (checkGetCheckFee() == false)
		{
			return false;
		}				
		else 
		{			
			var h=480;
			var w=650;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
			var str=window.showModalDialog('/npage/s1300/getcheckfee.jsp?bankcode='+bankCode+'&checkno='+checkNo,"",prop);
			
			if( typeof(str) != "undefined" )
			{
				if (parseInt(str)==0)
				{
			   		rdShowMessageDialog("û���ҵ���֧Ʊ����",0);
			   		document.form1.checkNo.focus();
			   		document.form1.currentMoney.value = "";
			   		return false;
			   	}
			   	else
			   	{
					document.form1.currentMoney.value = str;					
				}
				
				return true;
			}
		}

	}
	
	function checkGetCheckFee()
	{	
		if (document.form1.bankCode.value=="")
		{
			rdShowMessageDialog("��������ѯ�����д��롱!",0);
			document.form1.bankCode.focus();
			return false;
		}
			
		if (document.form1.checkNo.value == "")
		{
			rdShowMessageDialog("�����롰֧Ʊ���롱!",0);
			document.form1.checkNo.focus();
			return false;
		}			
	}

function comp(){
	if(!forReal(document.form1.rate)){
		return;
	}
	if((parseFloat(document.form1.rate.value)<0) || (parseFloat(document.form1.rate.value)>1)){
		rdShowMessageDialog("���ɽ��Ż���ֻ����0~1֮�䣡",0);
		return;
	}
	var paymoney=0;
	
	for(i = 0;i < document.all.num.value;i++){
		if(parseInt(eval("document.all.state"+i+".value"))==0){
			paymoney += Math.ceil(parseFloat(eval("document.all.use"+i+".value")) + parseFloat(eval("document.all.delay"+i+".value"))*(1-parseFloat(document.form1.rate.value)));
		}
		else{
			paymoney += Math.ceil(parseFloat(eval("document.all.state"+i+".value")));
		}
	}
	//alert("comp here paymoney is "+paymoney);
	//paymoney = parseFloat(document.form1.sumUse.value)+parseFloat(document.form1.sumDelay.value)*(1-parseFloat(document.form1.rate.value))+parseFloat(document.form1.sumState.value);
  document.getElementById("shouldPay").innerText = formatAsMoney(paymoney);
  //document.form1.cashPay.value= formatAsMoney(paymoney);
}


 <%}%>
</script>
</head>

<body>
		
<form name="form1"  method="post">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">һ��֧���ʻ��ɷ�</div>
	</div>

		<input type="hidden" id="loginaccept" value="<%=loginaccept%>">
		<input type="hidden" id="print_flag" value="<%=print_flag%>">
			
				<input type="hidden" name="workNo"   value="<%=workNo%>">
				<input type="hidden" name="noPass"   value="<%=nopass%>">
				<input type="hidden" name="org_code"   value="<%=org_code%>">
				
				<input type="hidden" name="opcode"   value="3172">				
				<%
				System.out.println("-----------------------------nextFlag---------------------------------"+nextFlag);
      	if(nextFlag==1)
      	{%>
      	<TABLE   cellspacing="0" >
				<TR  id="line_1" align="center">
          <TD align="left"   class="blue">֤������</TD>
          <TD align="left" >
            	<input type="text"  v_type="idcard"  v_must="1"  v_name="֤������" name="idCard" maxlength="18">&nbsp;&nbsp;
            	<input    id="querybutton" name=querybutton type=button value=��ѯ֧���ʻ� onClick="queryAccount();" style="cursor:hand" <% if(nextFlag==2){out.println("disabled");} %> class="b_text">
          </TD>
        </TR>

		        <TR  id="line_1" align="center">
			  	 <td align="left"    class="blue">֧���ʺ�</td>
	         <td align="left" > 
	             <input   type="text"  v_type="0_9"  v_must=1 v_minlength=11 v_maxlength=14 v_name="֧���ʻ���"  name="contract_no"  value="<%=account_id%>" <% if(nextFlag==2){out.println("readonly");} %> maxlength="14"  onkeydown="if(event.keyCode==13)queryAccount()" onchange="changeCon()">
	              <font class="orange">*</font>
	             <input type="button"  style="cursor:hand"  name="checkButt"  value="��֤" onClick="checkAccount()" <% if(nextFlag==2){out.println("disabled");} %> class="b_text">
	             <input type="hidden" name="accountName">
	             
	         </td>
	         
      	</TR>

      	<TR  align="center"> 
		         	<TD height="30" align="center" id="footer"  colspan="2"> 
		         	    <input name="cfmButton" id="cfmButton" style="cursor:hand" type="button"  value="ȷ��" onClick="doQuery('<%=invoice_money%>','<%=loginaccept%>','<%=print_flag%>')" disabled class="b_foot">
		         	    <input name="backButton" onClick="removeCurrentTab();" style="cursor:hand" type="button"  value="�ر�" class="b_foot">
				 			</TD>
		    </TR>
		  </table>
	      <%
	      }
	      %>
	      	<%
	      if(nextFlag==2)//��ѯ����
	      {
	      %>
	      <TABLE   cellspacing="0" >
		        <TR  id="line_1" align="center">
			  	 <td align="left"    class="blue" width="50%">֧���ʺ�</td>
	         <td align="left" colspan="3" width="50%"> 
	             <input   type="text"  v_type="0_9"  v_must=1 v_minlength=11 v_maxlength=14 v_name="֧���ʻ���"  name="contract_no"  value="<%=contract_no%>" <% if(nextFlag==2){out.println("readonly");} %> maxlength="14"  onkeydown="if(event.keyCode==13)queryAccount()" onchange="changeCon()">
	              <font class="orange">*</font>
	             <input type="button"  style="cursor:hand"  name="checkButt"  value="��֤" onClick="checkAccount()" <% if(nextFlag==2){out.println("disabled");} %> class="b_text">
	             <input type="hidden" name="accountName">
	             
	         </td>
	         
      	</TR>
			</table>
			<TABLE   cellspacing="0" >
	     <TR  >
	      	<TD  class="blue" colspan="7"><B>��֧���ʻ���Ϣ</B></TD>
	      </TR>
	      <TR  >
	      	<TD class="blue" >��֧���ʻ�</TD>
	      	<TD class="blue" >Ԥ���</TD>
	      	<TD class="blue" >Ƿ�ѽ��</TD>
	      	<TD class="blue" >���ɽ�</TD>
	      	<TD class="blue" >ȫ���־</TD>
	      	<TD class="blue" >������</TD>
	      	<TD class="blue" >֧��˳��</TD>
	      </TR>
	      <%
	      int num=0;
	   
     		for(int i=0;i<result2.length;i++)
     		{
	     		if(Double.parseDouble(result6[i][0])==0){
		     		sumUse += Double.parseDouble(result4[i][0]);
		     		sumDelay += Double.parseDouble(result7[i][0]);
		     	}
		    	else{
		    		sumState += Double.parseDouble(result6[i][0]);
		    	}
		    	
     		%>
		      <TR  >
		      	<TD ><%=result2[i][0]%></TD>
		      	<TD ><%=result3[i][0]%></TD>
		      	<TD ><%=result4[i][0]%><input type="hidden" name=use<%=i%> value=<%=result4[i][0]%>></TD>
		      	<TD ><%=result7[i][0]%><input type="hidden" name=delay<%=i%> value=<%=result7[i][0]%>></TD>
		      	<TD ><%=result5[i][0]%></TD>
		      	<TD ><%=result6[i][0]%><input type="hidden" name=state<%=i%> value=<%=result6[i][0]%>></TD>
		      	<TD ><%=result10[i][0]%></TD> 
		      </TR>
	      <%
	      	num++;
	     	 }
	     	 
	      %>
	</table>
	
	<TABLE   cellspacing="0" >
  			<TR >
	      		<TD  class="blue"> ֧���˺�����</TD><TD><%=nameResult[0][0]%></TD>
				  	<TD   class="blue"> </TD><TD > </TD>
				</TR>		
					
	      <TR >
	      		<TD  class="blue"> ���ý��</TD><TD><%=result8[0][0]%></TD>
				  	<TD   class="blue"> �ϼ�Ӧ��</TD><TD id="shouldPay"><%=result9[0][0]%></TD>
				</TR>
	
				<TR  style="display:<%=accountNum.equals("0")?"none":""%>">
				  	<TD class="blue">ͳ������</TD>
				  	<TD >
				  		<input type="text" name="yearMonth" v_name="��������" v_must="1" v_type="0_9" maxlength="6" value="<%=accountNum.equals("0")?yearMonth:""%>" v_format="yyyyMM">
				  		<font class="orange">*(��ʽ:YYYYMM)</font>
				  	</TD>
				  	<td>&nbsp;</td>
				  	<td>&nbsp;</td>
				</TR>
				<TR >

			 				<TD   class="blue">���ɽ��Ż���</TD>
	            <TD  >
	              	<input type="text" v_name="���ɽ��Ż���" v_type="float" v_must=1 value="1.00" name="rate" onblur="comp()">
	              	 <font class="orange">*</font>	              	
	            </TD>			    
	            <td>&nbsp;</td>
	            <td>&nbsp;</td>		 		            	              
			 </TR>	
			  <TR  id="line_2">
				  	<TD class="blue"> �ɷѷ�ʽ</TD>
				  	<TD>
				  		<select name='payType' onchange='changePayType()' readonly>
								<option value='0' checked>�ֽ�</option>
								<option value='9'>֧Ʊ</option>
							</select> <font class="orange">*</font>
				  	</TD>
				  	<td class="blue">�ɷѽ�� </td>
		         <td >
				 
						<input  type="text" name="cashPay"  value="<%=invoice_money%>" maxlength="14"  v_must=1 v_type="float" v_name="���ѽ��" <%=s_read_only%>>
							 <font class="orange">*</font>
						 </td>
			  </TR>
			</table>
		<div id="tab1" style="display:none;">
			<TABLE   cellspacing="0" >
			 <TR  id="line_1">
			 	<TD   class="blue" >���д���</TD>
	            <TD >
	              	<input name="bankCode" size=12 maxlength="12" >
                  <input name="bankName" size=13 onKeyDown="if(event.keyCode==13)getBankCode();" onfocus="this.select();">
	              	<input type="button" style="cursor:hand"  name="queryBankButt"  value="��ѯ" onClick="getBankCode()" class="b_text">	              	
	            </TD>
			    		<TD    class="blue">֧Ʊ����</TD>
	            <TD >
	              	<input type="text" v_type="string"  v_maxlength="20" v_name="֧Ʊ����" name="checkNo" maxlength="20" >
	              	<input type="button" style="cursor:hand"  name="queryCheckButt"  value="��ѯ" onClick="getCheckFee()" class="b_text">	              	
	            </TD> 			 		            	              
			 </TR>			 
			 <TR  id="line_1">
			 	<TD   class="blue">���ý��</TD>
	            <TD  >
	              	<input type="text" readonly class="InputGrey" name="currentMoney" value="">	              	
	            </TD>			    
           <td>&nbsp;</td>
	            <td>&nbsp;</td>		 		
	            			 </TR>
			</table>
	   </div>
	   <TABLE   cellspacing="0" >
		<TR  id="line_2">
		    	<TD  class="blue"  >��    ע</TD>
				  <TD >
				  	<input  name="note" type="text" size="60" maxlength="60" v_must=1 v_type="string"  v_name="��ע"  Class="InputGrey" readOnly>  
				  	<input type="hidden" name="qryMonth" value="<%=qryMonth%>">
				  	 <font class="orange">*</font>
			  	</TD>
		</TR>
			 
			<input type="hidden" name="sumUse" value="<%=sumUse%>">
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="sumDelay" value="<%=sumDelay%>">
			<input type="hidden" name="sumState" value="<%=sumState%>">
				<TR > 
		         	<TD height="30" align="center" id="footer" colspan="2"> 
		         			<input  name="previous" style="cursor:hand" type=button value="��һ��" onclick="previouStep()" class="b_foot">
			 						 &nbsp; &nbsp; &nbsp;
		         	    <input name="cfmButton" id="cfmButton" style="cursor:hand" type="button"  value="ȷ��" onClick="if(check(form1)) submitValue()" class="b_foot">
		         	    &nbsp;  &nbsp; &nbsp;
		         	    <input name="backButton" onClick="removeCurrentTab();" style="cursor:hand" type="button"  value="�ر�" class="b_foot">
		         	    &nbsp; 
				 			</TD>
		    </TR>
		    
		  </table>
		<script>
			<%if(accountNum.equals("0")){%>
				document.all.note.value="һ��֧���ɷ�";
			<%}else{%>
				document.all.note.value="ͳһ���ѽɷ�";
			<%}%>
		</script>
		<%
		 }
		%>

 <%@ include file="/npage/include/footer.jsp" %>
 </form>
</body>

</html>
<%
  if(nextFlag==2)//��ѯ����
  {
  %>
<script language='javascript'>
	comp()
</script>
<%
}
%>