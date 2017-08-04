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
	String opCode = "8658";	
	String opName = "批量修改IMEI绑定关系";	//header.jsp需要的参数   
   
	String orgcode = (String)session.getAttribute("orgCode");  
	String workno=(String)session.getAttribute("workNo");    //工号 
    String workname =(String)session.getAttribute("workName");//工号名称  	        
    String regionCode = (String)session.getAttribute("regCode"); 
   	String op_code = "8658"  ;
		
	String remark = request.getParameter("remark");
	String serverIp=realip.trim();	

	//ArrayList arlist = new ArrayList();
	String [][] result = new String[][]{};
	int    iErrorNo =0;
	String    sErrorMessage = " ";
	String    sReturnCode = "";
	int   	  flag = 0;
	String [] inputPar=new String [5];
	inputPar[0]=workno;
	inputPar[1]=orgcode;
	inputPar[2]=op_code;
	inputPar[3]=remark;
	inputPar[4]=serverIp;
	
	String total_no = "";
	
	/**SPubCallSvrImpl callView = new SPubCallSvrImpl();	
	s1310Impl viewBean = new s1310Impl();	
	arlist = callView.callFXService("s2204Cfm",inputPar,"4","region","01");
	result = (String [][])arlist.get(0); */
%>
	<wtc:service name="s8658Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="5" >
		<wtc:param value="<%=inputPar[0]%>"/>
		<wtc:param value="<%=inputPar[1]%>"/>	
		<wtc:param value="<%=inputPar[2]%>"/>						
		<wtc:param value="<%=inputPar[3]%>"/>	
		<wtc:param value="<%=inputPar[4]%>"/>		
	</wtc:service>
	<wtc:array id="results8658" scope="end"/>		
<%
	System.out.println("results8658**================"+results8658.length);
	System.out.println("retCode**================"+retCode);
	System.out.println("retMsg**================"+retMsg);
	for(int i=0;i<results8658.length;i++){
		for(int j=0;j<results8658[i].length;j++){
			System.out.println("results8658["+i+"]["+j+"]="+results8658[i][j]);
		}
	}
	if(results8658!=null&&results8658.length>0){
		result=results8658;
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
			total_no = result[0][2];
		}
	}
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
		+"&opName="+opName+"&workNo="+workno+"&loginAccept="+""+"&pageActivePhone="+""
		+"&opBeginTime="+opBeginTime+"&contactId="+""+"&contactType=grp";
%>
	<jsp:include page="<%=url%>" flush="true" />

<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-批量修改IMEI绑定关系</TITLE>
		<script language="JavaScript">
		<!--
		function gohome()
		{
			document.location.replace("f8658_1.jsp");
		}
		-->
		</script>
	</HEAD>
	<BODY>
		<FORM action="f8658_3.jsp" method=post name=form>	
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">批量修改IMEI绑定关系</div>
			</div> 
			<table cellspacing="0" >		     
		              <tbody> 
			              <tr> 
			              		<td class="blue" align=center width="20%">操作类型</td>
				                <td width="30%" colspan="2">
					                    <input type="text" class="InputGrey" readonly value="批量修改IMEI绑定关系">
				                </td>
			              </tr>
		              </tbody> 
			</table>
		        <table cellspacing="0">
		                <tbody> 
			                <tr> 
				                  <td colspan="2" align="center">
				                   	批量修改IMEI绑定关系完成。<br> 					
							<% if (flag == 0){%>
				                          成功数量：<%=total_no%>。
				                       <% } else { %>
				                          错误代码：'<%=sReturnCode%>'。<br>错误信息：'<%=sErrorMessage%>'。");
				                       <% } %>					   
							<br>失败的信息，请检查<a target="_blank" href="/npage/tmp/<%=orgcode.substring(0,2)%>AdjImei.txt.err"><%=orgcode.substring(0,2)%>AdjImei.txt.err</a>文件。	
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



