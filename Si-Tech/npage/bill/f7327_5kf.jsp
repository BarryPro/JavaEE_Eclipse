<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ��ͥ����ƻ����
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setDateHeader("Expires", 0);
%>	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept_boss.jsp" %>
<%@ page import="com.sitech.boss.pub.exception.BOException"%>
<%		

  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String op_Flag = request.getParameter("op_Flag");
  
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  
%>
<%
  String retFlag="",retMsg="";//����Ƿ�У��ʧ�ܵı�־����Ϣ
/****************���ƶ�����õ����롢������������ܰ��ͥ�������Ϣ s1251Init***********************/
  String[] paraAray1 = new String[4];
  String main_card = request.getParameter("chief_no");
  String mem_card = request.getParameter("srv_no");
  String passwordFromSer="";
  String show_phone = "";
  if(op_Flag.equals("0"))
  { 
  	paraAray1[0] = main_card;	
  	show_phone = main_card;			/* ��������   */
  }
	else 
	{
		paraAray1[0] = mem_card;	/* ��������   */
		show_phone = mem_card;	
	}				 
  paraAray1[1] = opCode; 		/* ��������   */
  paraAray1[2] = op_Flag;			/* ��ѯ��־   */
 System.out.println("------------999999999999999999999999999paraAray1[0]---------------"+paraAray1[0]);
 System.out.println("------------999999999999999999999999999paraAray1[1]---------------"+paraAray1[1]);
 System.out.println("------------999999999999999999999999999paraAray1[2]---------------"+paraAray1[2]);
  for(int i=0; i<paraAray1.length; i++)
  {		
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		}
  }
%>
	<wtc:service name="s7327SelNew" retcode="retCode1" retmsg="retMsg1" outnum="16">			
	<wtc:param value="<%=paraAray1[0]%>"/>	
	<wtc:param value="<%=paraAray1[1]%>"/>	
	<wtc:param value="<%=paraAray1[2]%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  start="0" length="2" scope="end"/>
	<wtc:array id="result2"  start="2" length="1" scope="end"/>
	<wtc:array id="result3"  start="3" length="1" scope="end"/>
	<wtc:array id="result4"  start="4" length="1" scope="end"/>
	<wtc:array id="result5"  start="5" length="1" scope="end"/>
	<wtc:array id="result6"  start="6" length="1" scope="end"/>
	<wtc:array id="result7"  start="7" length="1" scope="end"/>
	
	<wtc:array id="result8"  start="8" length="1" scope="end"/>
	<wtc:array id="result9"  start="9" length="1" scope="end"/>		
	<wtc:array id="result10"  start="10" length="1" scope="end"/>	
	
	<wtc:array id="result11"  start="11" length="1" scope="end"/>
	<wtc:array id="result12"  start="12" length="1" scope="end"/>
	<wtc:array id="result13"  start="13" length="1" scope="end"/>
	<wtc:array id="result14"  start="14" length="1" scope="end"/>
	<wtc:array id="result15"  start="15" length="1" scope="end"/>
<%
  String  bp_name="";
  String otherCardFlag = "",mainDisabledFlag="";
  String[][] tempArr= new String[][]{};
  String[][] beginTimeArr= new String[][]{};
  String[][] phoneNoArr= new String[][]{};
  String[][] custNameArr= new String[][]{};
  String[][] limitPayArr= new String[][]{};
  String[][] sumPayArr= new String[][]{};
  String[][] activePayArr= new String[][]{};
  /* add by wanglm 20110324 ��ʾ����״̬������Ƿ��ԭ�򣬸���Ƿ�ѽ�� start*/
  String[][] stateFlagArr= new String[][]{};
  String[][] flagArr= new String[][]{};
  String[][] billFeeArr= new String[][]{};
  /* add by wanglm 20110324 ��ʾ����״̬������Ƿ��ԭ�򣬸���Ƿ�ѽ�� end */
  
  String mainCartState = "";
  String mainCartOwe = "";
  String mainCartOweMoney = "";
  String errCode = retCode1;
  String errMsg = retMsg1;
  String[][] main_nameA = new String[][]{}; // mainCartState ����״̬
  String[][] second_nameA = new String[][]{}; // stateFlagArr
  String main_nameB = "";
  String second_nameB = "";
  System.out.println("errCode======"+errCode);
  if(result2.length==0)
  {
	if(!retFlag.equals("1"))   
	{
	   retFlag="1";
	   retMsg="" + errMsg ;
    }  
  }else if(errCode.equals("000000") && result2.length > 0)
  { 
	  beginTimeArr = result2;			//����ʱ�� 
	  phoneNoArr = result3;		//�������� �� ��������
    custNameArr = result4;		//�ͻ�����
    limitPayArr = result5;		//���ѽ��
    sumPayArr = result6;			//�����ܽ��
   	activePayArr = result7;			//����ʵ�ʽ��
   	stateFlagArr = result8;    //����״̬
   	flagArr = result9;        //����Ƿ��ԭ��
   	billFeeArr = result10;    //����Ƿ�ѽ��
	mainCartState = result11[0][0]; //����״̬
    /*xl add for ����״̬תname*/
	second_nameA = result14;
	main_nameA = result15;
	main_nameB = result15[0][0];
   mainCartOwe = result12[0][0]; 
   mainCartOweMoney = result13[0][0];
	  //�ж��Ƿ���������¼  
	  if(phoneNoArr==null || phoneNoArr.length==0 || phoneNoArr[0][0].equals("")){
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="�ú���û�ж�Ӧ��������Ϣ!";
        }  
	  }else if(phoneNoArr.length>1){
	    otherCardFlag = "1";//�ж��Ƿ���ڸ���
	  }
	}else{
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="��ѯ���������Ϣʧ��!"+errMsg;
        }
	}  

  

  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();
%>
<head>
<title>���ļ�ͥ��Ϣ��ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">
    //���У��ʧ�ܣ��򷵻���һ����
	<%if(retFlag.equals("1")){%>
	 rdShowMessageDialog("<%= retMsg %>");
	 history.go(-1);
	<%}%>
<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";
 
  onload=function()
  {		
  }
  
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//У��one
  function checkOne(){    
	var flag = 0;
	var card_type,phoneNo ;
	var radio1 = document.getElementsByName("phoneNo");
	for(var i=0;i<radio1.length;i++){
	  if(radio1[i].checked){
	    flag = 1;
		phoneNo = oneTokSelf(radio1[i].value,"~",1);//������
		card_type = oneTokSelf(radio1[i].value,"~",2);//������
		document.frm.phoneNoForPrt.value=phoneNo;
		document.frm.cardTypeForPrt.value=card_type;
	  }
	}
	if(flag==0){
	  rdShowMessageDialog("��ѡ��Ҫȡ���ĺ���!");
	  return false;
	}else
	{
	  if(card_type=="1")
	  {
	    if(document.frm.new_rate_code2.value=="")
		{
		  rdShowMessageDialog("��ѡ�����ײʹ���!");
		  document.frm.new_rate_code2.focus();
	      return false;
		}
	  }
	}
	return true;
  }
  //
 
  /*���ݿ����Ͷ�̬�ı��еĿɼ���*/
  function controlByCardType(str)
  {
    var card_type = oneTokSelf(str,"~",2);//������
	var phoneNo = oneTokSelf(str,"~",1);//������
	document.frm.phoneNoForPrt.value=phoneNo;
    document.frm.cardTypeForPrt.value=card_type;
	if(card_type=="1")
	{
		document.all.newRateCode2Tr.style.display="";
	}else
	{
	    document.all.newRateCode2Tr.style.display="none";
	}
	return true;
  }
  function ret()
  {
  		
  		window.location.href='/npage/bill/f7327Kf.jsp?phoneNo=<%=show_phone%>&opName=<%=opName%>&opCode=<%=opCode%>';
  }

//-->
</script>

</head>


<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
		  <tr> 
            <td class="blue">��������</td>
            <td>��ѯ</td> 
		    <td class="blue">��ѯ����</td>
            <td>
			  <input name="phone_no" type="text" class="InputGrey" id="phone_no" value="<%=show_phone%>" readonly >
			</td>     
      </tr>
      <%
        if(op_Flag.equals("1") && stateFlagArr.length>0 && flagArr.length>0){
          %>
             <tr> 
            <td class="blue">����״̬</td>
            <td><%=second_nameA[0][0]%></td> 
		    <td class="blue">����ͣ��ԭ��</td>
            <td>
            	<%
            	   if("0".equals(flagArr[0][0])){
            	      %>
            	       ����Ƿ��
            	      <%
            	   }else if("1".equals(flagArr[0][0])){
            	   	  %>
            	       ����Ƿ��
            	      <%
            	   }else{
            	      %>
            	      <%=flagArr[0][0]%>
            	      <%	
            	   }
            	%>
			</td> 
			     
      </tr>
      <tr>
      	<td class="blue" >����Ƿ�ѽ��</td>
            <td colspan="3">
            	 <%=billFeeArr[0][0]%>
			</td> 
  </tr>
          <%
        }else{
      %>
       <tr> 
            <td class="blue">����״̬</td>
            <td><%=main_nameB%></td> 
		    <td class="blue">����ͣ��ԭ��</td>
            <td>
            	<%
            	   if("0".equals(mainCartOwe)){
            	      %>
            	       ����Ƿ��
            	      <%
            	   }else if("1".equals(mainCartOwe)){
            	   	  %>
            	       ����Ƿ��
            	      <%
            	   }else{
            	      %>
            	      <%=mainCartOwe%>
            	      <%	
            	   }
            	%>
            	
			</td> 
			     
      </tr>
      <tr>
      	<td class="blue" >����Ƿ�ѽ��</td>
            <td colspan="3">
            	 <%=mainCartOweMoney%>
			</td> 
  </tr>
  <%}%>
		</table>
		</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">ҵ����ϸ</div>
</div>
		<TABLE cellSpacing="0">
          <TBODY> 
		  <tr>
			<tr>
		    <th align=center>��ʼʱ��</th>
		    <%
		    	if(op_Flag.equals("0"))
		    	{
		    %>
			  <th align=center>��������</th>
			  <th align=center>�ͻ�����</th>                    
			  <th align=center>Ϊ�������ѵ��޶�</th>                    
			  <th align=center>Ϊ�������ѵ�ʵ�ʽ��(6�����ں�����)</th>
			  <th align=center>����״̬</th>
			  <th align=center>����ͣ��ԭ��</th>
			  <th align=center>����Ƿ�ѽ��</th>
			  <%}
			  	else
			  	{	
			  %>
			  <th align=center>��������</th>							                                        
			  <th align=center>�ͻ�����</th>                    
			  <th align=center>�������丶�ѵ��޶�</th>                    
			  <th align=center>�������丶�ѵ�ʵ�ʽ��</th>
			  <th align=center>����״̬</th>
			  <th align=center>����ͣ��ԭ��</th>
			  <th align=center>����Ƿ�ѽ��</th>                
			 	<%}%>                                                  
			</tr>                                               
			<% 
			 for(int j=0;j<phoneNoArr.length;j++){
			 	String tdClass = (j%2==0)?"Grey":"";              
			/*xl add for ����״̬תname ��ѭ����*/
			%>
		    <tr> 
			  <TD align=center class="<%=tdClass%>"><%=beginTimeArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=phoneNoArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=custNameArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=limitPayArr[j][0]%></TD>
			  <TD align=center class="<%=tdClass%>"><%=sumPayArr[j][0]%></TD>
			  <%
			    if(op_Flag.equals("1")){
			  %>
			  <TD align=center class="<%=tdClass%>"><%=main_nameA[j][0]%></TD>
			  <%
			      if("1".equals(mainCartOwe)){
			      %>
			         <TD align=center class="<%=tdClass%>">����Ƿ��</TD>
			      <%
			  }else if("0".equals(mainCartOwe)){
			  	%>
			         <TD align=center class="<%=tdClass%>">����Ƿ��</TD>
			      <%
			  }else{
			     %> 
			         <TD align=center class="<%=tdClass%>"><%=mainCartOwe%></TD>
			      <%	
			  }
			  %>
			  <TD align=center class="<%=tdClass%>"><%=mainCartOweMoney%></TD>
			  <%
			    }else{
			  %>
			  <TD align=center class="<%=tdClass%>"><%=second_nameA[j][0]%></TD>
			  <%
			      if("1".equals(flagArr[j][0])){
			         %>
			          <TD align=center class="<%=tdClass%>">����Ƿ��</TD>
			         <%
			      }else if("0".equals(flagArr[j][0])){
			  	%>
			         <TD align=center class="<%=tdClass%>">����Ƿ��</TD>
			      <%
			      }else{
			     %> 
			         <TD align=center class="<%=tdClass%>"><%=flagArr[j][0]%></TD>
			      <%	
			      }
			  %>
			  <TD align=center class="<%=tdClass%>"><%=billFeeArr[j][0]%></TD>
			  <%
			   }
			  %>
			</tr>				
			<%
			 }
			%>
		</table>
	    <TABLE  cellSpacing="0">
          <TBODY> 
		  <tr> 
            <td id="footer" colspan="4"> <div align="center"> 
                <input name="reset" type="reset" class="b_foot" value="���" >
                &nbsp; 
                <input name="back" onClick="ret();" type="button" class="b_foot" value="����">
                &nbsp; 
				
				</div>
			</td>
          </tr>
       </table>
 	
  <input type="hidden" name="phoneNoForPrt" ><!--Ҫȡ�����ֻ�����,���ڴ�ӡ-->
  <input type="hidden" name="cardTypeForPrt" ><!--Ҫȡ���Ŀ�����,���ڴ�ӡ-->
  <input type="hidden" name="printAccept" value="<%=printAccept%>"><!--��ӡ��ˮ-->
   <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>



