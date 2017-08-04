<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
	//String payType = request.getParameter("payType");/**缴费类型 payType=BX 是建行 payType=BY 是工行**/
	//System.out.println("-----------------payType----------------------------->"+payType);
	S1100View callView = new S1100View();
	String xx_money = "";
	String opCode = "9391";
	String opName = "WLAN用户状态变更";
	String regionCode1 = (String)session.getAttribute("regCode");
	String work_name = (String)session.getAttribute("workName");
	System.out.println("regionCode1----------------------->"+regionCode1);
	
			
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String[][] pass = (String[][])arrSession.get(4);
	
	String loginNo = baseInfoSession[0][2];
	String loginName = baseInfoSession[0][3];
	String powerCode= otherInfoSession[0][4];
	String orgCode = baseInfoSession[0][16];
	String ip_Addr = request.getRemoteAddr();
	
	String regionCode = orgCode.substring(0,2);
	String regionName = otherInfoSession[0][5];
	String loginNoPass = pass[0][0];
	
	String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];

	List al = null;
	String[][] idCodeData = new String[][]{};
	String curDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());


	
	

%>
<html>
	<head>
		<title>WLAN用户状态变更</title>
	</head>

	<body>
		<script language="JavaScript">
			//定义应用全局的变量
			var SUCC_CODE	= "0";   		//自己应用程序定义
			var ERROR_CODE  = "1";			//自己应用程序定义
			var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改
			var dynTbIndex=1;				//用于动态表数据的索引位置,开始值为1.考虑表头
			var TIMEOUTNUM = 35;
			
			var oprType_Add = "a";
	    var oprType_Upd = "u";
	    var oprType_Del = "d";
	    var oprType_Qry = "q";

	    function doProcess(packet)
	    {
	    	var retCode = packet.data.findValueByName("retCode");
	    	var retMsg =  packet.data.findValueByName("retMsg");
	    	alert(retCode);
	    	if(retCode != "000000")
	    	{
	    		rdShowMessageDialog(retMsg);
	    		return;
	    	}
	    }
	    function isNumberString (InString,RefString)
	    {
	            if(InString.length==0) return (false);
	            for (Count=0; Count < InString.length; Count++)  {
	            TempChar= InString.substring (Count, Count+1);
	            if (RefString.indexOf (TempChar, 0)==-1)  
	            return (false);
	            }
	            return (true);
	    }
	    
			function commitJsp()
			{
				var IDItemRange = document.form9391.IDItemRange.value;
				var opType = document.form9391.opType.value;

				  if(IDItemRange.length<11 || isNumberString(IDItemRange,"1234567890")!=1) {
				        rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
				        document.form9391.IDItemRange.focus();
				        return false;
				  }
		        else if (parseInt(IDItemRange.substring(0,2),10)!=15 && parseInt(IDItemRange.substring(0,3),10)!=188 && parseInt(IDItemRange.substring(0,3),10)!=147 && parseInt(IDItemRange.substring(0,2),10)!=18 && (parseInt(IDItemRange.substring(0,3),10)<134 || parseInt(IDItemRange.substring(0,3),10)>139)){
		        rdShowMessageDialog("请输入134-139,15开头的手机号码 !!");
		        document.form9391.IDItemRange.focus();
		        return false;
		        }
				form9391.submit();
			}
	
	
	function resetJsp()
	{
	 with(document.form9391)
	 {
		IDItemRange.value	= "";
	 }
	  document.form9391.IDItemRange.focus();		
	}
	
		</script>
		<FORM method=post name="form9391" action="f9391Cfm.jsp" >
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">WLAN用户状态变更</div>
			</div>
			<TABLE cellSpacing="0">
        		<TR>
        			<td  class="blue">手机号码</td>
					<td > 
						<input name="IDItemRange" type="text" id="IDItemRange"/> 
            		</td>
        			<td  class="blue">操作类型</td>
					<TD>
						<select name="opType" id="opType">
							<option value='04'>暂停</option>
							<option value='02'>取消</option>
		              	</select>
					</TD>
        		</TR>
        <tr> 
            <td align=center id="footer" colspan="4"> 
                <input name="confirm" type="button" class="b_foot" value="确认" onClick="commitJsp()"/>
                &nbsp; 
                <input name="reset" type="button" class="b_foot"  value="清除" onClick="resetJsp()"/>
                &nbsp; 
                <input name="back" onClick="window.close()" class="b_foot" type="button" value="返回"/>
                &nbsp;</td>
        </tr>
       
  </table>
  
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  
  </td>
  </tr>
  </table>
  
  	<input type="hidden" name="loginNoPass" id="loginNoPass" value="<%=loginNoPass%>">
  	<input type="hidden" name="loginName" id="loginName" value="">
  	<input type="hidden" name="opCode" id="opCode" value="">
  	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
  	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">

		<input type="hidden" name="busyAccept" id="busyAccept" value=""> 
		<input type="hidden" name="tmpSendAccept" id="tmpSendAccept" value=""> 	
		<input type="hidden" name="tmpBackAccept" id="tmpBackAccept" value=""> 	
		<input type="hidden" name="accountNo" id="accountNo" value="">
		<input type="hidden" name="tmpPayMoney" id=""tmpPayMoney"" value="">
		
		<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
		<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
		<input type="hidden" name="totalDate" id="totalDate" value="<%=curDate%>"> 	
	
</FORM>
</body>
</html>
