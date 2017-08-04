<%
/********************
 * @ OpCode    :  4089
 * @ OpName    :  ҵ����������ѯ
 * @ Services  :  s4089Qry,
 * @ Pages     :  s4089/f4089_1.jsp,
 * @ CopyRight :  si-tech
 * @ Author    :  qidp
 * @ Date      :  2009-09-03
 * @ Update    :  
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode = "4089";
    String opName = "ҵ����������ѯ";
    
    String workNo = (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode");
    
    String flag = (String)request.getParameter("flag"); //#��־λ# search:˵���������ѯ����ť���ύ����ҳ�档
    String sWorkNo = ""; //����
    String sAccept = ""; //������ˮ
    String sCustId = ""; //�ͻ�ID
    String sGrpId = "";
    String sStartDate = ""; //��ʼʱ��
    String sStopDate = ""; //����ʱ��
    
    String orderList[][] = new String[][]{};
    
    /*********************
     * ͨ����ѯ�ύ����ҳ�棬����s4089Qry������в�ѯ��
     *********************/
    if("search".equals(flag)){
        sWorkNo = (String)request.getParameter("iWorkNo");
        sAccept = (String)request.getParameter("iAccept");
        sCustId = (String)request.getParameter("custId");
        sStartDate = (String)request.getParameter("startDate");
        sStopDate = (String)request.getParameter("stopDate");
        sGrpId = (String)request.getParameter("grpId");
        
 try{
        %>
            <wtc:service name="s4089Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="s4089QryCode" retmsg="s4089QryMsg" outnum="9" >
            	<wtc:param value="<%=sWorkNo%>"/>
            	<wtc:param value="<%=sAccept%>"/>
            	<wtc:param value="<%=sCustId%>"/>
                <wtc:param value="<%=sStartDate%>"/>
                <wtc:param value="<%=sStopDate%>"/>
                <wtc:param value="<%=sGrpId%>"/>
            </wtc:service>
            <wtc:array id="s4089QryArr" scope="end"/>
        <%
            if("000000".equals(s4089QryCode)){
                if(s4089QryArr.length>0){
                    orderList = s4089QryArr;
                }else{
                    %>
                        <script type=text/javascript>
                            rdShowMessageDialog("û�з��������ļ�¼��",0);
                            window.location.href = "f4089_1.jsp";
                        </script>
                    <%
                }
            }else{
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("<%=s4089QryCode%>,<%=s4089QryMsg%>",0);
                </script>
            <%
            }
            System.out.println("# return from f4089_1.jsp by s4089Qry -> returnCode = " + s4089QryCode);
            System.out.println("# return from f4089_1.jsp by s4089Qry -> returnMsg  = " + s4089QryMsg);
        }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("Call Service s4089Qry Failed!",0);
            </script>
        <%
            System.out.println("# return from f4089_1.jsp -> Call Service s4089Qry Failed!");
            e.printStackTrace();
        }
    }else{
        sWorkNo = "";
        sAccept = "";
        sCustId = "";
        sStartDate = "";
        sStopDate = "";
        sGrpId = "";
    }
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<script type=text/javascript>
    $().ready(function(){ 
        <% if("search".equals(flag)){ %>
            document.all.orderList.style.display="block";
        <% }else{ %>
            document.all.orderList.style.display="none";
        <% } %>
    });
    
    // ִ�в�ѯ
    function doSearch(){
        if($("#startDate").val()!='' && !forDate(document.getElementById('startDate'))){
            return false;
        }
        
        if($("#stopDate").val()!='' && !forDate(document.getElementById('stopDate'))){
            return false;
        }
        
        var vWorkNo = $("#iWorkNo").val();
        if(vWorkNo == ''){
            rdShowMessageDialog("�������Ų���Ϊ�գ�",0);
            $("#iWorkNo").focus();
            return false;
        }
        
        frm.action="f4089_1.jsp?flag=search";
        frm.method="post";
        frm.submit();
    }
    
    // ִ�����
    function doClear(){
        $("#iWorkNo,#custId,#iAccept,#startDate,#stopDate").val("");
    }

</script>

<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ����</div>
</div>
<table cellspacing=0>
    <tr>
        <td class='blue'>��ʼʱ��</td>
        <td>
            <input type="text" name="startDate" id="startDate" value="<%=sStartDate%>" maxlength='8' v_type='date' v_format='yyyyMMdd' onblur='if(this.value!=""){forDate(this);}' />
        </td>
        <td class='blue'>����ʱ��</td>
        <td>
            <input type="text" name="stopDate" id="stopDate" value="<%=sStopDate%>" maxlength='8' v_type='date' v_format='yyyyMMdd' onblur='if(this.value!=""){forDate(this);}' />
        </td>
    </tr>
    <tr>
        <td class='blue'>��������</td>
        <td>
            <input type="text" name="iWorkNo" id="iWorkNo" value="<%=sWorkNo%>" />
            <font class='orange'>*</font>
        </td>
        <td class='blue'>������ˮ</td>
        <td>
            <input type="text" name="iAccept" id="iAccept" value="<%=sAccept%>" />
        </td>
    </tr>
    <tr>
        <td class='blue'>�û�����</td>
        <td>
            <input type="text" name="custId" id="custId" value="<%=sCustId%>" />
        </td>
        <td class='blue'>���ű��</td>
        <td>
            <input type="text" name="grpId" id="grpId" value="<%=sGrpId%>" />
        </td>
    </tr>
    
    <tr id='footer'>
        <td colspan='4'>
            <input type="button" class='b_foot' value="��ѯ" name="search" id="search" onclick="doSearch()" />
            <input type="button" class='b_foot' value="���" name="clear" id="clear" onclick="doClear()" />
        </td>
    </tr>
</table>

</div>
<div id="Operation_Table">
<div  id="orderList" style="display:none">
<div class="title">
	<div id="title_zi">ҵ����������ѯ�б�</div>
</div>

<table cellspacing=0>
    <tr>
        <th>������ˮ</th>
        <th>���ű��</th>
        <th>�û�����</th>
        <th>Ʒ��</th>
        <th>������</th>
        <th>������Ϣ</th>
        <th>��������</th>
        <th>��������</th>
        <th>��������</th>
    </tr>
    <%
    if("search".equals(flag)){
        for(int i=0;i<orderList.length;i++){
            String tdClass = "";
            if (i%2==0){
                tdClass = "Grey";
            }
            
            out.print("<tr>");
	            out.print("<td class="+tdClass+">"+orderList[i][0]+"</td>");
	            out.print("<td class="+tdClass+">"+orderList[i][1]+"</td>");
	            out.print("<td class="+tdClass+">"+orderList[i][2]+"</td>");
	            out.print("<td class="+tdClass+">"+orderList[i][3]+"</td>");
	            out.print("<td class="+tdClass+">"+orderList[i][4]+"</td>");
	            out.print("<td class="+tdClass+">"+orderList[i][5]+"</td>");
	            out.print("<td class="+tdClass+">"+orderList[i][6]+"</td>");
	            out.print("<td class="+tdClass+">"+orderList[i][7]+"</td>");
	            out.print("<td class="+tdClass+">"+orderList[i][8]+"</td>");
            out.print("</tr>");
        }
    }
    %>
</table>

<table cellspacing=0>
    <tr id="footer">
        <td>
            <input type="button" class="b_foot" id="close" name="close" value="�ر�" onclick="removeCurrentTab()"/>
        </td>
    </tr>
</table>
</div>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>