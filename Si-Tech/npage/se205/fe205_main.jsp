<%
    /*************************************
    * ��  ��: ���Ź�ģ�ȼ��޸� e205
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-8-16
    **************************************/
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>���Ź�ģ�ȼ��޸�</title>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    String loginNo= (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
    String sqlCount="select  count(*) from shighlogin where op_code='e205' and login_no='"+loginNo+"'";
%>
<wtc:pubselect name="sPubSelect" routerKey="regionCode" routerValue="<%=regCode%>" outnum="1">
        <wtc:sql><%=sqlCount%></wtc:sql>         
    </wtc:pubselect>
<wtc:array id="loginNoCount" scope="end"/> 

        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
             $(document).ready(function(){
                judgeLoginNo();
             });
            
            //�жϸù����Ƿ���Ȩ�޲�����ģ��
            function judgeLoginNo(){
                //�˹�����Ȩ��
                if("<%=loginNoCount[0][0]%>"=="0"){
                    rdShowMessageDialog("�ù���û��Ȩ���޸ļ��Ź�ģ�ȼ���",1);
                    removeCurrentTab();
                }
            }
            
            function query(submitBtn2)
            {
                judgeLoginNo();
                /* ��ť�ӳ� */
    			controlButt(submitBtn2);
    			/* �º����� */
    			getAfterPrompt();
    			
                var markDiv=$("#intablediv"); 
                markDiv.empty();

                if(!check(document.form205)){
                    return false;
                }
                var unitNo=$.trim($("#unitNo").val());
                var unitName=$.trim($("#unitName").val());
                
                if(unitNo==""&&unitName==""){
                    rdShowMessageDialog("����������һ����ѯ������",1);
                    return false;	
                }
                var packet = new AJAXPacket("fe205_ajax_query.jsp","���ڻ�����ݣ����Ժ�......");
                    packet.data.add("opCode","<%=opCode%>");
                	packet.data.add("unitNo",unitNo);
                	packet.data.add("unitName",unitName);
                	core.ajax.sendPacketHtml(packet,doQuery);
                	packet = null;
             }
             
            function doQuery(data)
            {
                //�ҵ���ӱ���div
				var markDiv=$("#intablediv"); 
				markDiv.empty();
        		markDiv.append(data);
                var retCode = $("#retCode").val();
                var retMsg  = $("#retMsg").val();
                if(retCode!="000000"){
                     rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
                     return false;
                }
            }
            
            //��ȡ�����б�ѡ������ı�
            function getSelectedText(name){
                var obj=document.getElementById(name);
                for(i=0;i<obj.length;i++){
                    if(obj[i].selected==true){
                        return obj[i].innerText;      //�ؼ���ͨ��option�����innerText���Ի�ȡ��ѡ���ı�
                    }
                }
            }
                 
            function submitUpdate(){
                if(rdShowConfirmDialog("ȷ��Ҫ�ύ��")!=1){
                    return false;
                }else{
                    var newUnitOwner_selecText = getSelectedText("newUnitOwner");
                    var _getUnitId = $("#_getUnitId").val();
                    var _getUnitName = $("#_getUnitName").val();
                    var packet = new AJAXPacket("fe205_ajax_update.jsp","���ڻ�����ݣ����Ժ�......");
                    	packet.data.add("opCode","<%=opCode%>");
                    	packet.data.add("newUnitOwner",newUnitOwner_selecText);
                    	packet.data.add("_getUnitId",_getUnitId);
                    	packet.data.add("_getUnitName",_getUnitName);
                    	core.ajax.sendPacket(packet,doUpdate);
                    	packet = null;
                }
            }
            
            function doUpdate(packet)
            {
				var retCode = packet.data.findValueByName("retcode");
		        var retMsg = packet.data.findValueByName("retmsg");
                if(retCode!="000000"){
                     rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
                     return false;
                }else{
                    rdShowMessageDialog("�ύ�ɹ���",2);
                    location.reload();
                }
            }

        </script>
    </head>
    <body>
        <form name="form205" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">�����ѯ����</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td class="blue">���ű��</td>
                    <td>
                        <input type="text" id="unitNo" name="unitNo" v_type="0_9" maxlength="10" value="" />
                    </td>
                    <td class="blue">��������</td>
                    <td colspan="3">
                        <input type="text" id="unitName" name="unitName" v_type="string" v_maxlength="100" size="40" value="" />
                    </td>
                </tr>			
                <tr>
                    <td colspan="6" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="��ѯ" onClick="query(this)" />   
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