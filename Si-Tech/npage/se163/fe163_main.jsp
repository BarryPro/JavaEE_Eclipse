<%
    /*************************************
    * ��  ��: ���ų�Ա����ȷ�϶��Ŵ����ѯ e163
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-8-3
    **************************************/
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>���ų�Ա����ȷ�϶��Ŵ����ѯ</title>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String workNo=WtcUtil.repNull((String)session.getAttribute("workNo"));
    String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));

    //��ȡ���ݿ�ʱ��sql��
    String Strsql = "select to_char(sysdate-1,'yyyy-mm-dd hh24:mi:ss'),to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual";
%>
    <wtc:pubselect name="sPubSelect" routerKey="regionCode" routerValue="<%=regionCode%>" outnum="2">
        <wtc:sql><%=Strsql%></wtc:sql> 	
    </wtc:pubselect>
    <wtc:array id="result" scope="end"/> 
<%
    //��ȡ��ǰ���ݿ�ʱ��-24Сʱ��
    String befor24Time = result[0][0];
    //���ݿ�ʱ�䣺
    String currentTimeString = result[0][1];
%>
         
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
            window.onload=function()
            {
                //ʱ��Ĭ����ʾ
                $("#startTime").val("<%=befor24Time%>");
                $("#endTime").val("<%=currentTimeString%>");
            }
          
            //У��ʱ���ʽ
            function checkTimeFormat(){
                if(!forDate(document.frme163.startTime)){
                    return false;
                }
                
                 if(!forDate(document.frme163.endTime)){
                    return false;
                }
            }
            function query(submitBtn2)
            {
                /* ��ť�ӳ� */
    			controlButt(submitBtn2);
    			/* �º����� */
    			getAfterPrompt();
    			
                var markDiv=$("#intablediv"); 
                markDiv.empty();

                if(!forDate(document.frme163.startTime)){
                    return false;
                }
                
                 if(!forDate(document.frme163.endTime)){
                    return false;
                }
                if(!check(frme163)) return false;
                
                var startTime=$.trim($("#startTime").val());
                var endTime=$.trim($("#endTime").val());
                var phoneNo=$.trim($("#phoneNo").val());
                var unitNo=$.trim($("#unitNo").val());
                var operateNo=$.trim($("#operateNo").val());
                var befor24TimeVar = "<%=befor24Time%>";
                var currentTimeVar = "<%=currentTimeString%>";
                var _startTime = startTime.replace("-","").replace("-","").replace(" ","").replace(":","").replace(":","");
                var _endTime = endTime.replace("-","").replace("-","").replace(" ","").replace(":","").replace(":","");
                
                if(Date.parse(startTime.replace("-","/"))<Date.parse(befor24TimeVar.replace("-","/"))){
                    rdShowMessageDialog("ϵͳ���ṩ24Сʱ֮��Ĳ�ѯ�����������뿪ʼʱ�䣡");
                    return false;	
                }
                
                if(Date.parse(startTime.replace("-","/"))>Date.parse(endTime.replace("-","/")))
                {
                	rdShowMessageDialog("��ʼʱ��ӦС�ڽ���ʱ�䣬���������룡");
                    return false;	
                }
                
                if(Date.parse(endTime.replace("-","/"))>Date.parse(currentTimeVar.replace("-","/")))
                {
                    rdShowMessageDialog("����ʱ����ڵ�ǰϵͳʱ�䣬���������룡");
                    return false;	
                }
                
                if(phoneNo==""&&unitNo==""&&operateNo==""){
                    rdShowMessageDialog("����������һ����ѯ������");
                    return false;	
                }
                
                var packet = new AJAXPacket("fe163_ajax_query.jsp","���ڻ�����ݣ����Ժ�......");
                	packet.data.add("startTime",_startTime);
                	packet.data.add("endTime",_endTime);
                	packet.data.add("phoneNo",phoneNo);
                	packet.data.add("unitNo",unitNo);
                	packet.data.add("operateNo",operateNo);
                	packet.data.add("opCode","<%=opCode%>");
                	packet.data.add("regionCode","<%=regionCode%>");
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
                var retMsg = $("#retMsg").val();
                if(retCode!="000000"){
                     rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
                     return false;
                }
            }

        </script>
    </head>
    <body>
        <form name="frme163" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">�����ѯ����</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td class="blue">��ʼʱ��</td>
                    <td>
                        <input type="text" id="startTime" name="startTime" v_format="yyyy-MM-dd HH:mm:ss"  v_must="1"  class="button" maxlength="19" onblur="checkTimeFormat()" />&nbsp;
                        <font color="orange">* ( �����ʽ��yyyy-MM-dd HH:mm:ss )</font>
                    </td>
                    <td class="blue">����ʱ��</td>
                    <td>
                        <input type="text" id="endTime" name="endTime" v_format="yyyy-MM-dd HH:mm:ss"  v_must="1"  class="button" maxlength="19" onblur="checkTimeFormat()" />&nbsp;
                        <font color="orange">* ( �����ʽ��yyyy-MM-dd HH:mm:ss )</font>
                    </td>
                </tr>
                <tr>
                    <td class="blue">�ֻ�����</td>
                    <td>
                        <input type="text" id="phoneNo" name="phoneNo" v_type="mobphone" value="" />
                    </td>
                    <td class="blue">���ű��</td>
                    <td>
                        <input type="text" id="unitNo" name="unitNo" v_type="0_9" value="" />
                    </td>
                </tr>
                <tr>
                    <td class="blue">��������</td>
                    <td colspan="3">
                        <input type="text" id="operateNo" name="operateNo" v_type="string" value="" />
                    </td>
                </tr>			
                <tr>
                    <td colspan="4" align="center" id="footer">
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