<%
    /*************************************
    * ��  ��:   ��Ա���Ӱ����� m107
    * ��  ��:   version v1.0
    * ������:   si-tech
    * ����ʱ��: 2014-4-20
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
        <title>��Ա���Ӱ�����</title> 
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
					function subInfo(submitBtn2){
					  /* ��ť�ӳ� */
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
					  
					  var packet = new AJAXPacket("fm107_ajax_subInfo.jsp","���ڻ�����ݣ����Ժ�......");
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
	    				rdShowMessageDialog('����ʧ�ܣ�������룺'+retCode+'<br>������Ϣ��'+retMsg);
	    				window.location.href="fm107_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	    			}
					}
					/*2014/11/04 9:13:48 gaopeng ����ͳ��ҵ��ʡ����ʡ֧��ģʽ֧�Ÿ���
					�����ѯ����������ҳ�棬ѡ���ײ�
					
					*/
					function pacQryFunc(){
						var suitID = $.trim($("#relationID").val());
						if(suitID.length == 0){
							rdShowMessageDialog("�������Ա�����ײ�ID��");
							return false;
						}
						
							/*ƴ�����*/
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
					 
					  /*��*/
					  //alert(path);
					  window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
						
						
					}
					/*2016/2/18 12:36:00 liangyl �����·��ͶԽ�ҵ��֧��ʵʩ������֪ͨ����
					���������ʾ������ҳ��չʾ������Ϣ
					*/
					function showErr(retArray){
						var errorStr="";
						/*�ж��Ƿ��д�����Ϣ ����ƴ��*/
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
						/*ƴ�����*/
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
					  /*��*/
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
        		<div id="title_zi">�����ѯ����</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td class="blue">������ϵID</td>
                    <td>
                        <input type="text" id="relationID" name="relationID" v_must="1"  value="" />
                    		&nbsp;&nbsp;<input class="b_text" type="button" name="qryBtn" value="��ѯ" onclick="pacQryFunc();"/>
                    </td>
                    <td class="blue">��Ա�����ײ�ID</td>
                    <td>
                        <input type="text" id="suitID" name="suitID" v_must="1" value="" />
                    </td>
                </tr>
                <tr>
                    <td class="blue">��Ա����</td>
                    <TD>
						        	<textarea cols=30 rows=8 id="memberNoList" name="memberNoList" style="overflow:auto" v_must="1" /></textarea>
						        </TD>
						        <TD colspan='2'>
					            ע���������Ӻ���ʱ,����"|"��Ϊ�ָ���,�������һ������Ҳ����"|"��Ϊ����.
					            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ÿ�����50����
					            <br>&nbsp;���磺
					            <br>&nbsp;13900000001|
					            <br>&nbsp;13900000002|
						        </TD>
                </tr>			
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" disabled="disabled" class="b_foot" value="ȷ��" onClick="subInfo(this)" />   
                        <input type="button" id="reSetBtn"  name="reSetBtn"  class="b_foot" value="����" onClick="location.reload();" /> 
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>