 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-22 页面改造,修改样式
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.io.*"%>
<%@ include file="/npage/common/serverip.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "2204";	
	String opName = "批量费用补收";	//header.jsp需要的参数   
   
	String orgcode = (String)session.getAttribute("orgCode");  
	String workno=(String)session.getAttribute("workNo");    //工号 
    String workname =(String)session.getAttribute("workName");//工号名称  	        
    String regionCode = (String)session.getAttribute("regCode"); 
   	String op_code = "2204"  ;
	String nopass = "111111";		
	String billym = request.getParameter("billym");
	String billitem = request.getParameter("SBillItem");
	String remark = request.getParameter("remark");

	String serverIp=realip.trim();	

	//ArrayList arlist = new ArrayList();
	String [][] result = new String[][]{};
	int    iErrorNo =0;
	String    sErrorMessage = " ";
	String    sReturnCode = "";
	int   	  flag = 0;
	String [] inputPar=new String []{workno,nopass,orgcode,op_code,billym,billitem,remark,serverip};
	String total_fee = "";
	String total_no = "";
	
	/**SPubCallSvrImpl callView = new SPubCallSvrImpl();	
	s1310Impl viewBean = new s1310Impl();	
	arlist = callView.callFXService("s2204Cfm",inputPar,"4","region","01");
	result = (String [][])arlist.get(0); */
%>
	<wtc:service name="s2204Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="4" >
		<wtc:params value="<%=inputPar%>"/>					
	</wtc:service>
	<wtc:array id="resultS2204" scope="end"/>		
<%
	System.out.println("resultS2204**================"+resultS2204.length);
	System.out.println("retCode**================"+retCode);
	System.out.println("retMsg**================"+retMsg);
	for(int i=0;i<resultS2204.length;i++){
		for(int j=0;j<resultS2204[i].length;j++){
			System.out.println("resultS2204["+i+"]["+j+"]="+resultS2204[i][j]);
		}
	}
	if(resultS2204!=null&&resultS2204.length>0){
		result=resultS2204;
		sReturnCode=result[0][0];			
	}		
	if(!sReturnCode.equals("000000")){
		flag = -1;
		//result = (String [][])arlist.get(1);
		if(result!=null&&result.length>0){
			sErrorMessage=result[0][1];
		}
		System.out.println(" 错误信息 : " + sErrorMessage);
	}

	// 判断处理是否成功
	if (flag == 0){	
		//result = (String [][])arlist.get(2);
		//result = (String [][])arlist.get(3);
		if(result!=null&&result.length>0){
			total_fee = result[0][2];			
			total_no = result[0][3];
		}
	}
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
		+"&opName="+opName+"&workNo="+workno+"&loginAccept="+""+"&pageActivePhone="+""
		+"&opBeginTime="+opBeginTime+"&contactId="+""+"&contactType=grp";
%>
	<jsp:include page="<%=url%>" flush="true" />

<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-批量费用补收</TITLE>
		<script language="JavaScript">
		<!--
		function gohome()
		{
			document.location.replace("s2204.jsp");
		}
		-->
		</script>
	</HEAD>
	<BODY>
		<FORM action="s2204_3.jsp" method=post name=form>	
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">批量费用补收</div>
			</div> 
			<table cellspacing="0" >		     
		              <tbody> 
			              <tr> 
			              		<td class="blue">操作类型</td>
				                <td>
				                  <select name = "SOprType" size = "1" >
				                    <option value = "1" selected> 批量费用补收</option>
				                  </select>
				                </td>			                
			                	<td class="blue">部门</td>
			                	<td><%=orgcode%></td>
			              </tr>
		              </tbody> 
			</table>
		        <table cellspacing="0">
		                <tbody> 
			                <tr> 
				                  <td colspan="2" align="center">
				                   	批量费用补收完成。<br> 					
							<% if (flag == 0){%>
				                          共成功补收费用：<%=total_fee%> ，数量：<%=total_no%>。
				                       <% } else { %>
				                          错误代码：'<%=sReturnCode%>'。<br>错误信息：'<%=sErrorMessage%>'。");
				                       <% } %>					   
							<br>失败的号码，请检查<a target="_blank" href="/npage/tmp/<%=orgcode.substring(0,2)%>AdjFee.txt.err"><%=orgcode.substring(0,2)%>AdjFee.txt.err</a>文件。	
				                  </td>
			                </tr>
		                </tbody> 
		              </table>
		        <table cellspacing="0">
		              <tbody> 
			              <tr> 
			                	<td id="footer"> 
				                  	<input class="b_foot" name=sure disabled type=submit value=确认>
				                  	<input class="b_foot" name=reset type=reset value=返回 onClick="gohome()">
			                  		&nbsp; 			                  
			                  	</td>
			              </tr>
		              </tbody> 		           
			</table>
			 <%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>



