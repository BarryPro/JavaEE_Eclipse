<%
    /*************************************
    * ��  ��: ������ǩ�ʷ��������� g398
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2013-1-15
    **************************************/
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>������ǩ�ʷ���������</title> 
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
            function query(submitBtn2)
            {
                /* ��ť�ӳ� */
			    			controlButt(submitBtn2);
			    			/* �º����� */
			    			getAfterPrompt();
    			
                var markDiv=$("#intablediv"); 
                markDiv.empty();

                if(!check(frm)) return false;
                
                var offerId=$.trim($("#offerId").val());
                var offerName=$.trim($("#offerName").val());
                
                if(offerId==""&&offerName==""){
                    rdShowMessageDialog("����������һ����ѯ������");
                    return false;	
                }
                var packet = new AJAXPacket("fg398_ajax_query.jsp","���ڻ�����ݣ����Ժ�......");
                	packet.data.add("offerId",offerId);
                	packet.data.add("offerName",offerName);
                	packet.data.add("opCode","<%=opCode%>");
                	core.ajax.sendPacketHtml(packet,doQuery);
                	packet = null;
             }
        	
            function doQuery(data)
            {
                //�ҵ���ӱ���div
								var markDiv=$("#intablediv"); 
								markDiv.empty();
		        		markDiv.append(data);
                var qryChkedState =$("input[@name=qryRadioName][@checked]").attr("v_state"); 
                if(qryChkedState!=undefined){
                  selecQryInfo(qryChkedState);
                }
                var retCode = $("#retCode").val();
                var retMsg = $("#retMsg").val();
                if(retCode!="000000"){
                   rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
                   return false;
                }
            }
            
            function selecQryInfo(val){
              if(val=="1"){
                $("#subBtn").val("����");
                $("#subBtn").attr("v_flag","1");
              }else if(val=="2"){
                $("#subBtn").val("ɾ��");
                $("#subBtn").attr("v_flag","2");
              }else{
                $("#subBtnTr").css("display","none");
              }
            }
            
            function subInfo(obj){
              var v_offerId = $("input[@name=qryRadioName][@checked]").attr("v_offerId");//�ʷѴ���
              var v_flag = $("#subBtn").attr("v_flag");//���ӡ�ɾ����ʶ
              var packet = new AJAXPacket("fg398_ajax_subInfo.jsp","�����ύ���ݣ����Ժ�......");
                	packet.data.add("v_offerId",v_offerId);
                	packet.data.add("v_flag",v_flag);
                	packet.data.add("opCode","<%=opCode%>");
                	core.ajax.sendPacket(packet,doSubInfo);
                	packet = null;
            }
            
            function doSubInfo(packet){
              var retcode_subInfo = packet.data.findValueByName("retcode_subInfo");
              var retmsg_subInfo = packet.data.findValueByName("retmsg_subInfo");
              if(retcode_subInfo == "000000"){
                rdShowMessageDialog("�ύ�ɹ���",2);        
                reSetTab();
              }else{
                rdShowMessageDialog("������룺" + retcode_subInfo + "��������Ϣ��" + retmsg_subInfo,0);
                reSetTab();
              }
            }
            
            function reSetTab(){
              window.location.href="fg398_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
            }

        </script>
    </head>
    <body>
        <form name="frm" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">�����ѯ����</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td class="blue">�ʷѴ���</td>
                    <td>
                        <input type="text" id="offerId" name="offerId"  value="" />
                    </td>
                    <td class="blue">�ʷ�����</td>
                    <td>
                        <input type="text" id="offerName" name="offerName"  value="" />
                    </td>
                </tr>
                <tr>
                  <td colspan="4">
                    <font class='red'> ע��������˵����<br>
                        1.¼����ʷѱ����ǰ����ʷѣ�<br>
                        2.¼����ʷ�Ȩ��ҪС�ڵ���2����<br>
                        3.¼����ʷ�Ϊ��Ч�������ã�<br>
                        4.��ǰ����ֻ�����ù���������ͬ���ʷѡ�<br>
                        5.������¼��˽�����ʷѵ��û�������������3��������1�������Ǵ˽������õİ����ʷѵ��û����ڵ����һ���£�2�����Ͷ���ʱ�ͻ�״̬��������Ƿ�ѣ�ͣ������ͣ��ʵ�����û���3���û��ֻ�������Ԥ�����ڰ������30Ԫ�������¶��ţ����𾴵Ŀͻ����ã�������İ����ʷѱ��µ��ڣ������ʹ�ð����ʷѿ�ͨ������ָ�ZBNXQ����10086��������ʷ���ǩ��������ѯ10086�������ظ��ɽ�����ǩ���������������û���δ¼��˽���İ����ʷѴ������ԭ�������˷��Ͷ�����������ԭ�еİ��굽�����Ѷ��ţ�û�����õĲ����Ͷ��š�
                    </font> 
                  </td>
                  
                </tr>
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="��ѯ" onClick="query(this)" />   
                        <input type="button" id="reSetBtn"  name="reSetBtn"  class="b_foot" value="����" onClick="reSetTab();" /> 
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>