<%
    /*************************************
    * 功  能: 卡通协议签约信息查询 e626
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-2-21
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String iPhoneNo = WtcUtil.repStr(request.getParameter("iPhoneNo"), "");
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName=WtcUtil.repNull((String)request.getParameter("opName"));
	String loginNo = WtcUtil.repStr(request.getParameter("loginNo"), "");
	String password = WtcUtil.repStr(request.getParameter("password"), "");
	String groupId = (String)session.getAttribute("groupId");
	String notes = "卡通协议签约信息查询";
	
	//获取系统时间
  Date currentTime = new Date(); 
  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
  String currentTimeString = formatter.format(currentTime);
  System.out.println("系统时间="+currentTimeString);
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=iPhoneNo%>" id="printAccept"/>
<%
	String printAcceptSub = printAccept.substring(0,6);
	System.out.println("------e626----------printAcceptSub="+printAcceptSub);
	String timeAndAccept = "451"+"BIP1C005"+currentTimeString + printAcceptSub;
	System.out.println("------e626----------timeAndAccept="+timeAndAccept);
%>
	<wtc:service name="sProWorkFlowCfm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode" retmsg="retMsg" outnum="4">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="1"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="92"/>
		<wtc:param value="045101"/>
		<wtc:param value="ZY0101"/>
    <wtc:param value="21"/>
		<wtc:param value="<%=currentTimeString%>"/>
		<wtc:param value="20501231235959"/>
		<wtc:param value="<%=currentTimeString%>"/>
		<wtc:param value="<%=notes%>"/>
		<wtc:param value="<%=groupId%>"/>
		<wtc:param value="<%=timeAndAccept%>"/>
	</wtc:service>
	<wtc:array id="retList"  scope="end"/>
<%
    if("000000".equals(retCode)){
    	System.out.println("------e626----------retList.length="+retList[0].length);
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">卡通协议签约信息查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
				  <th>银行卡号（后4位）</th>
					<th>卡通绑定状态</th>
					<th>卡通绑定银行</th>
					<th>卡通绑定时间</th>
				</tr>
<%
				if(retList[0].length==0){
					out.println("<tr height='25' align='center'><td colspan='4'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(retList[0].length>0){
							String tbclass = "";
							String arr1[] = retList[0][0].split("\\|");
							String arr2[] = retList[0][1].split("\\|");
							String arr3[] = retList[0][2].split("\\|");
							String arr4[] = retList[0][3].split("\\|");
							System.out.println("---e626------arr1.length="+arr1.length);
							System.out.println("---e626------arr1[0]="+arr1[0]);
							if((arr1.length==arr2.length)&&(arr2.length==arr3.length)&&(arr3.length==arr4.length)){
  							for(int i=0;i<arr1.length;i++){
  							System.out.println("--------arr1[i]---------arr1[i]="+arr1[i]);
  							System.out.println("--------arr1[i]---------arr2[i]="+arr2[i]);
  							System.out.println("--------arr1[i]---------arr3[i]="+arr3[i]);
  							System.out.println("--------arr1[i]---------arr4[i]="+arr4[i]);
%>
								<tr align="center" id="row_<%=i%>">
<%
								if(i<arr1.length){
%>
                    <td class="<%=tbclass%>"><%=arr1[i]%></td>					    
<%
								}if(i<arr2.length){
                  if("0".equals(arr2[i])){
%>
                       <td class="<%=tbclass%>">绑定</td>
<%
                  }else if("1".equals(arr2[i])){
%>
                       <td class="<%=tbclass%>">非绑定</td>
<%                  
                  }
                }if(i<arr3.length){
%>
								  <td class="<%=tbclass%>"><%=arr3[i]%></td>
<%
								}if(i<arr4.length){
%>
								  <td class="<%=tbclass%>"><%=arr4[i]%></td>
<%
								}
%>
								</tr>
<%
							}
				  }else{
%>
              <SCRIPT language="JavaScript">
                rdShowMessageDialog("返回数据格式不正确！",1);
                window.location.href="fe626_main.jsp?activePhone=<%=iPhoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>";
              </SCRIPT>
<%  
				  }
				}
%>

			</table>
	</div>
</div>
<%}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />