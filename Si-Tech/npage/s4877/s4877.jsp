<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.text.*" %>

<%
/*
 * author  : liuxmc
 * created : 2010-03
 * revised : 2010-03
 */
 
 /*
	*��Ըù����������ĵ��н���һ�������ڵ��˻�ת�����޶
	*��Ԥ������޶��Ԥ������޶�����ã����ʱ��α����ǵ�ǰ�������ڵ�һ�����ڣ�
	*��������£���3��4�����ᵽ���޶�Ϊ��׼�����޸Ķ�����Ч���ڽ������Զ��ָ�Ϊ3��4�еĻ�׼�޶�
	*/
%>
<%
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
    String workno = baseInfo[0][2];
    String workname = baseInfo[0][3];
		String op_code = "4877";
		
		Date date = new Date();
  	DateFormat df = new SimpleDateFormat("yyyyMMdd");   
		String now = df.format(date);
		String time = now.substring(0,6);
		
%>

<HTML>
	<HEAD>
		<TITLE>������BOSS-�û�ͣ����ѯ</TITLE>
		<META content="text/html; charset=gb2312" http-equiv=Content-Type>
		<META content=no-cache http-equiv=Pragma>
		<META content=no-cache http-equiv=Cache-Control>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_single.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/date/iOffice_Popup.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
		<script language=javascript>
	
			core.loadUnit("debug");
			core.loadUnit("rpccore");
			
			function isNumberString (InString,RefString){
				if(InString.length==0) return (false);
				for (Count=0; Count < InString.length; Count++)  {
				       TempChar= InString.substring (Count, Count+1);
				       if (RefString.indexOf (TempChar, 0)==-1)  
				       return (false);
				}
				return (true);
			}

			
			function doquery(){
				var phone_no = document.form1.phoneno.value;
				if(phone_no == null || phone_no.length == 0){
					alert("���벻��Ϊ�գ�");
					document.form1.phoneno.focus();
					return false;
				}				
				
				if( phone_no.length<11 || isNumberString(phone_no,"1234567890")!=1 ) {
					alert("������������,����Ϊ11λ���� !!");
					document.form1.phoneno.focus();
					return false;
				}else if (parseInt(phone_no.substring(0,3),10)<134 || (parseInt(phone_no.substring(0,3),10)>139&&parseInt(phone_no.substring(0,2),10)!=15&&parseInt(phone_no.substring(0,2),10)!=18&&parseInt(phone_no.substring(0,2),10)!=14)){
					alert("������134-139����15��ͷ�ķ������ !!");
					document.form1.phoneno.focus();
					return false;
				}
				
				var year_month = document.form1.year_month.value;
				if(isNumberString(year_month,"1234567890")!=1 || year_month.length != 6){
					alert("��������ȷ��ʱ���ʽ(YYYYMM)��");
					document.form1.year_month.focus();
					return false;
				}
				var time = "<%=time%>";
				if(year_month > time){
					alert("����������Ϣ����ȷ��������֮ǰ�����µ����£���ʽ(YYYYMM)��");
					document.form1.year_month.focus();
					return false;
				}
								
				var myPacket = new RPCPacket("s4877_2.jsp","���ڻ����Ϣ�����Ժ�......");
				myPacket.data.add("phone_no",phone_no);
				myPacket.data.add("year_month",year_month);
				core.rpc.sendPacket(myPacket);
				//delete(myPacket);
				document.getElementById("tb").style.display = "block";		
			}
						
			function doProcess(packet){

				var return_code = packet.data.findValueByName("return_code");
				var return_msg = packet.data.findValueByName("return_msg");
				
				var str = "";
				if(return_code == "000000"){
					
					var triListData = packet.data.findValueByName("tri_list");

					var triListDataLength = triListData.length;

					for(i=0 ; i < triListDataLength; i++){
						
						str = str + "<table id=tbs9 width=100% height=25 border=0 align=\"center\" cellspacing=2>"            	
              + "<tr bgcolor=\"#E8E8E8\"> "
              + "  <td width=\"20%\">�ʻ����룺</td><td width=\"33%\" >"+triListData[i][2]+"</td>"
              + "  <td width=\"20%\">�ʻ����ƣ�</td><td width=\"34%\" >"+triListData[i][3]+"</td>"
              + "</tr>"
         
              + "<tr bgcolor=\"#E8E8E8\">"
              + "  <td width=\"20%\">ͣ��ʱ�䣺</td><td width=\"33%\" >"+triListData[i][4]+"</td>"
              + "  <td width=\"20%\">ͣ��ʱ��Ԥ��</td><td width=\"34%\">"+triListData[i][5]+"Ԫ</td>"
              + "</tr>"
           
              + "<tr bgcolor=\"#E8E8E8\">"
              + "  <td width=\"20%\">ͣ��ʱ��δ���ʻ��ѣ�</td><td width=\"33%\">"+triListData[i][6]+"Ԫ</td>"  
              + "  <td width=\"20%\">����Ƿ�ѣ�</td><td width=\"34%\">"+triListData[i][7]+"Ԫ</td>"
              + "</tr>"
              + "<tr bgcolor=\"#E8E8E8\">"
              + "  <td width=\"20%\">�����ȣ�</td><td width=\"33%\" >"+triListData[i][8]+"</td>"  
              + "  <td width=\"20%\">ͣ��״̬��</td><td width=\"34%\">"+triListData[i][9]+"</td>"
              + "</tr>"
              + "<tr bgcolor=\"#E8E8E8\">"
              + "  <td width=\"20%\">ͣ��ԭ��</td><td width=\"33%\" colspan=\"3\">"+triListData[i][10]+"</td>"  
              + "</tr>"         
            	+ "</table><br/>";
					}		

				}else{
					
					var res = "������룺"+return_code+"    ������Ϣ��"+return_msg;
					alert(res);
					return false;
				}
			  document.getElementById("tb").innerHTML = str;
			}
			
		 onload=function(){
				self.status="";
				core.rpc.onreceive = doProcess;
		 }

		</script>

		<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
	</HEAD>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" background="<%=request.getContextPath()%>/images/jl_background_2.gif" onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<FORM action="" method=post name=form1 >
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td background="<%=request.getContextPath()%>/images/jl_background_1.gif">
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td align="right" width="45%">
            <p><img src="<%=request.getContextPath()%>/images/jl_chinamobile.gif" width="226" height="26"></p>
          </td>
          <td width="55%" align="right"><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">���ţ�<%=workno%><img src="<%=request.getContextPath()%>/images/jl_ico_1.gif" width="13" height="14" hspace="3" align="absmiddle">����Ա��<%=workname%></td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
          <td align="right" background="<%=request.getContextPath()%>/images/jl_background_3.gif" height="69"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="<%=request.getContextPath()%>/images/jl_logo.gif"></td>
                <td align="right"><img src="<%=request.getContextPath()%>/images/jl_head_1.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
          <td align="right" width="73%">
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="42"><img src="<%=request.getContextPath()%>/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td background="<%=request.getContextPath()%>/images/jl_background_4.gif"><font color="FFCC00"><b>�û�ͣ����ѯ</b></font></td>
                      <td><img src="<%=request.getContextPath()%>/images/jl_ico_3.gif" width="389" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="27%">
            <table border="0" cellspacing="0" cellpadding="4" align="right">
              <tr> 
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="<%=request.getContextPath()%>/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr> 
          <td width="45%">
          	<br>
            <table id=tbs9 width=100% height=25 border=0 align="center" cellspacing=2>
            	<tr bgcolor="#E8E8E8" >
                  <td class="blue">������룺 
										<input type="text" name="phoneno" id="phoneno" maxlength="11">	&nbsp;&nbsp;&nbsp;
										��ѯ���ڣ�
										<input type="text" name="year_month" id="year_month" maxlength="6" value="<%=time%>">��ʽ��(YYYYMM)	 &nbsp;
										<input class="b_text" type=button value="��ѯ" onClick="doquery();">
									</td>									
              </tr>
              <tr>
              	<td align="center"><font color="#FF0000">��ʾ��ֻ�ܲ�ѯ���6�������û�ͣ����Ϣ��</font></td>
              </tr>
            </table>
          	<div id="tb" style="display:none"></div>
            <p>&nbsp;</p>
          </td>
        </tr>
      </table>
      <br>
    </td>
  </tr>
</table>
</FORM>
</BODY>
</HTML>
