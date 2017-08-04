<%
    /*************************************
    * 功  能:   成员叠加包订购 m107
    * 版  本:   version v1.0
    * 开发商:   si-tech
    * 创建时间: 2014-4-20
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
		String phoneNo = (String)request.getParameter("activePhone");
		
 		String loginAccept = getMaxAccept();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>成员叠加包订购</title> 
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
					function subInfo(submitBtn2){
					  /* 按钮延迟 */
						controlButt(submitBtn2);
					  if(!check(frm)) return false;
					  
					  /*
					  document.frm.action="fm107_subInfo.jsp";
						document.frm.submit();
					  */
					  
					  var relationID=$.trim($("#relationID").val());
					  var suitID=$.trim($("#suitID").val());
					  var memberNoList=$.trim($("#memberNoList").val());
					  memberNoList=memberNoList.replace(/\+/g,"");
					  memberNoList=memberNoList.replace(/[ ]/g,"");
					  memberNoList=memberNoList.replace(/[\r\n]/g,"");
					  
					  var packet = new AJAXPacket("fm107_ajax_subInfo.jsp","正在获得数据，请稍候......");
						packet.data.add("relationID",relationID);
						packet.data.add("suitID",suitID);
						packet.data.add("memberNoList",memberNoList);
						packet.data.add("opCode","<%=opCode%>");
						core.ajax.sendPacket(packet,doSubInfo);
						packet = null;
						
					}
        	
					function doSubInfo(packet){
						var retCode = packet.data.findValueByName("retCode");
    				var retMsg = packet.data.findValueByName("retMsg");
    				var retArray = packet.data.findValueByName("retArray");
						if (retCode == "000000"){
							if(retArray[0].length>1){
								showErr(retArray);
							}
							else{
								showErr(retArray);
							}
	    			}else{
	    				rdShowMessageDialog('订购失败！错误代码：'+retCode+'<br>错误信息：'+retMsg);
	    				window.location.href="fm107_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	    			}
					}
					/*2014/11/04 9:13:48 gaopeng 流量统付业务本省受理本省支付模式支撑改造
					加入查询方法，弹出页面，选择套餐
					
					*/
					function pacQryFunc(){
						var suitID = $.trim($("#relationID").val());
						if(suitID.length == 0){
							rdShowMessageDialog("请输入成员订购套餐ID！");
							return false;
						}
						
							/*拼接入参*/
						var path = "/npage/sm107/fm107Qry.jsp";
					  path += "?iLoginAccept=<%=loginAccept%>";
					  path += "&iChnSource=01";
					  path += "&iOpCode=<%=opCode%>";
					  path += "&iOpName=<%=opName%>";
					  path += "&iLoginNo=<%=loginNo%>";
					  path += "&iLoginPwd=<%=noPass%>";
					  path += "&iPhoneNo=";
					  path += "&iUserPwd=";
					  path += "&suitID="+suitID;
					 
					  /*打开*/
					  //alert(path);
					  window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
						
						
					}
					/*2016/2/18 12:36:00 liangyl 关于下发和对讲业务支撑实施方案的通知改造
					加入错误提示，弹出页面展示错误信息
					*/
					function showErr(retArray){
						var errorStr="";
						/*判断是否有错误信息 有则拼接*/
						if(retArray.length>0){
							var errPhoneList =retArray[0][0];
							var errMsgList=retArray[0][1];
							var errPhoneArr=errPhoneList.split("~");
							var errMsgArr=errMsgList.split("~");
							for(var i=0;i<errPhoneArr.length;i++){
								if(errPhoneArr[i]!=""){
									errorStr+="<tr><td align=center>"+errPhoneArr[i]+"</td><td>"+errMsgArr[i]+"</td></tr>";
								}
							}
						}
						/*拼接入参*/
						var path = "/npage/sm107/fm107ShowErr.jsp";
					  path += "?iLoginAccept=<%=loginAccept%>";
					  path += "&iChnSource=01";
					  path += "&iOpCode=<%=opCode%>";
					  path += "&iOpName=<%=opName%>";
					  path += "&iLoginNo=<%=loginNo%>";
					  path += "&iLoginPwd=<%=noPass%>";
					  path += "&iPhoneNo=";
					  path += "&iUserPwd=";
					  path += "&errorStr="+errorStr;
					  /*打开*/
					  //alert(path);
					  window.location.href=path;
					//  window.open(path,"showerr","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
					}

        </script>
    </head>
    <body>
        <form name="frm" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
         	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">输入查询条件</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td class="blue">订购关系ID</td>
                    <td>
                        <input type="text" id="relationID" name="relationID" v_must="1"  value="" />
                    		&nbsp;&nbsp;<input class="b_text" type="button" name="qryBtn" value="查询" onclick="pacQryFunc();"/>
                    </td>
                    <td class="blue">成员订购套餐ID</td>
                    <td>
                        <input type="text" id="suitID" name="suitID" v_must="1" value="" />
                    </td>
                </tr>
                <tr>
                    <td class="blue">成员号码</td>
                    <TD>
						        	<textarea cols=30 rows=8 id="memberNoList" name="memberNoList" style="overflow:auto" v_must="1" /></textarea>
						        </TD>
						        <TD colspan='2'>
					            注：批量增加号码时,请用"|"作为分隔符,并且最后一个号码也请用"|"作为结束.
					            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;每次最多50个。
					            <br>&nbsp;例如：
					            <br>&nbsp;13900000001|
					            <br>&nbsp;13900000002|
						        </TD>
                </tr>			
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" disabled="disabled" class="b_foot" value="确认" onClick="subInfo(this)" />   
                        <input type="button" id="reSetBtn"  name="reSetBtn"  class="b_foot" value="重置" onClick="location.reload();" /> 
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>