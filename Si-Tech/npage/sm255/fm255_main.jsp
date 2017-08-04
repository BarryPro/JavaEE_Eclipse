<%
  /*
   * ����: m255����ʡ�мۿ���¼Ͷ�ߵ��� 
   * �汾: 1.0
   * ����: 2015/4/6 
   * ����: diling
   * ��Ȩ: si-tech
  */
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
        <title><%=opName%></title>   
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
            window.onload=function(){
               
            }
          
            function query(submitBtn2)
            {
                /* ��ť�ӳ� */
			    			controlButt(submitBtn2);
			    			/* �º����� */
			    			//getAfterPrompt();
			    			
			    			if(!check(frm)) return false;
    			
                var markDiv=$("#intablediv"); 
                markDiv.empty();
                
                var qryType = $("#qryType").val();
                var phoneNo = "";
                if(qryType == "0"){ //֤������
                	phoneNo = "";
                	operateNo = $("#operateNo").val();
                }else{
                	phoneNo = $("#operateNo").val();
                	operateNo = "";
                }
                
                var packet = new AJAXPacket("fm255_ajax_query.jsp","���ڻ�����ݣ����Ժ�......");
              	packet.data.add("opCode","<%=opCode%>");
              	packet.data.add("qryType",$("#qryType").val());
              	packet.data.add("phoneNo",phoneNo);
              	packet.data.add("operateNo",operateNo);
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
            
            function subInfo(obj){
            	var printAccp = $(obj).parent().parent().find("td:eq(3)").text();
            	var operWorkNo = $(obj).parent().parent().find("td:eq(2)").text();
            	var operPhoneNo = $(obj).parent().parent().find("td:eq(1)").text();
            	var orderNo = $(obj).parent().parent().find("td:eq(5)").find("input").val();
            	if(orderNo == ""){
            		rdShowMessageDialog("������Ͷ�ߵ��ţ�",1);
            		$(obj).parent().parent().find("td:eq(5)").find("input").focus();
                return false;
            	}
            	var packet = new AJAXPacket("fm255_ajax_subInfo.jsp","���ڻ�����ݣ����Ժ�......");
            	packet.data.add("opCode","<%=opCode%>");
            	packet.data.add("opName","<%=opName%>");
            	packet.data.add("printAccp",printAccp);
            	packet.data.add("operWorkNo",operWorkNo);
            	packet.data.add("operPhoneNo",operPhoneNo);
            	packet.data.add("orderNo",orderNo);
            	core.ajax.sendPacket(packet,doSubInfo);
            	packet = null;
            }
            
            function doSubInfo(packet){
		          var retCode=packet.data.findValueByName("retCode");
						  var retMsg=packet.data.findValueByName("retMsg");
						  if(retCode == "000000"){
						  	rdShowMessageDialog("��¼Ͷ�ߵ��ųɹ���",2);
						  	window.location.href="fm255_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
						  }else{
						  	rdShowMessageDialog("��¼Ͷ�ߵ���ʧ�ܣ�������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
						  	return false;
						  }
            }
            
            //ֻ��Ҫ��table����һ��vColorTr='set' ���ԾͿ��Ը��б�ɫ
		        $("table[vColorTr='set']").each(function(){
              $(this).find("tr").each(function(i,n){
                $(this).bind("mouseover",function(){
                	$(this).addClass("even_hig");
                });
                
                $(this).bind("mouseout",function(){
                	$(this).removeClass("even_hig");
                });
                
                if(i%2==0){
                	$(this).addClass("even");
                }
              });
		        });

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
                    <td class="blue">��ѯ����</td>
                    <td>
                        <select name="qryType" id="qryType" >
													<option value="0" selected>֤������</option>	
													<option value="1" >�ֻ�����</option>
												</select>	
                    </td>
                    <td class="blue">�������</td>
                    <td>
                        <input type="text" id="operateNo" name="operateNo" v_type="string" value="" v_must="1" />
                        <font class="orange">*</font>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="qryBtn" name="qryBtn" class="b_foot" value="��ѯ" onClick="query(this)" />   
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