<%
/********************
 * @ OpCode    :  4091
 * @ OpName    :  ���񶨵���ѯ
 * @ Services  :  s4091QryBatch,s4091Qry,
 * @ Pages     :  s4091/f4091_1.jsp,
 * @ CopyRight :  si-tech
 * @ Author    :  qidp
 * @ Date      :  2009-09-02
 * @ Update    :  
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode = "4091";
    String opName = "���񶨵���ѯ";
    
    String workNo = (String)session.getAttribute("workNo");
    String workPwd = (String)session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");
    
    String openLabel = ""; /* #��־λ# link��ͨ�������б�ģ�����˶���ģ�飻opcode��ͨ��opcode�򿪴�ҳ�档*/
    
    String in_ChanceId = (String)request.getParameter("in_ChanceId"); //�̻�����
    String wa_no1 = (String)request.getParameter("wa_no1"); //�������
    
    System.out.println("# From f4091_1.jsp -> in_ChanceId = "+in_ChanceId);
    System.out.println("# From f4091_1.jsp -> wa_no1 = "+wa_no1);
    /*********************
     * �жϽ����ģ��ķ�ʽ��������Ӧ�Ĵ���
     *********************/
    if(in_ChanceId != null){
    	openLabel = "link";
    }else{
        in_ChanceId = "";
        wa_no1 = "";
        openLabel = "opcode";
    }
    
    String orderList[][] = new String[][]{};
    
    /*********************
     * ͨ�������б�ҳ�����ʱ������s4091QryBatch�����ѯ������
     *********************/
    if("link".equals(openLabel)){
        try{
        %>
            <wtc:service name="s4091QryBatchE" routerKey="region" routerValue="<%=regionCode%>" retcode="s4091QryBatchCode" retmsg="s4091QryBatchMsg" outnum="12" >
            	<wtc:param value="<%=workNo%>"/>
            	<wtc:param value="<%=workPwd%>"/>
                <wtc:param value="<%=in_ChanceId%>"/>
                <wtc:param value="<%=opCode%>"/>
                <wtc:param value="<%=wa_no1%>"/>
            </wtc:service>
            <wtc:array id="s4091QryBatchArr" scope="end"/>
        <%
            if("000000".equals(s4091QryBatchCode) && s4091QryBatchArr.length>0){
                orderList = s4091QryBatchArr;
            }else{
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("<%=s4091QryBatchCode%>,<%=s4091QryBatchMsg%>",0);
                </script>
            <%
            }
            System.out.println("# return from f4091_1.jsp by s4091QryBatch -> returnCode = " + s4091QryBatchCode);
            System.out.println("# return from f4091_1.jsp by s4091QryBatch -> returnMsg  = " + s4091QryBatchMsg);
        }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("Call Service s4091QryBatch Failed!",0);
            </script>
        <%
            System.out.println("# return from f4091_1.jsp -> Call Service s4091QryBatch Failed!");
            e.printStackTrace();
        }
    }
    
    String flag = (String)request.getParameter("flag"); //#��־λ# search:˵���������ѯ����ť���ύ����ҳ�档
    String sChanceId = ""; //�̻�����
    String sWorkNo = ""; //����
    String sStartDate = ""; //��ʼʱ��
    String sStopDate = ""; //����ʱ��
    
    String orderList2[][] = new String[][]{};
    
    /*********************
     * ͨ����ѯ�ύ����ҳ�棬����s4091Qry������в�ѯ��
     *********************/
    if("search".equals(flag)){
        sChanceId = (String)request.getParameter("chanceId");
        sWorkNo = (String)request.getParameter("iWorkNo");
        sStartDate = (String)request.getParameter("startDate");
        sStopDate = (String)request.getParameter("stopDate");
        
        try{
        %>
            <wtc:service name="s4091Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="s4091QryCode" retmsg="s4091QryMsg" outnum="8" >
            	<wtc:param value="<%=sWorkNo%>"/>
            	<wtc:param value="<%=sChanceId%>"/>
                <wtc:param value="<%=sStartDate%>"/>
                <wtc:param value="<%=sStopDate%>"/>
            </wtc:service>
            <wtc:array id="s4091QryArr" scope="end"/>
        <%
            if("000000".equals(s4091QryCode)){
                if(s4091QryArr.length>0){
                    orderList2 = s4091QryArr;
                }else{
                    %>
                        <script type=text/javascript>
                            rdShowMessageDialog("û�з��������ļ�¼��",0);
                            window.location.href = "f4091_1.jsp";
                        </script>
                    <%
                }
            }else{
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("<%=s4091QryCode%>,<%=s4091QryMsg%>",0);
                </script>
            <%
            }
            System.out.println("# return from f4091_1.jsp by s4091Qry -> returnCode = " + s4091QryCode);
            System.out.println("# return from f4091_1.jsp by s4091Qry -> returnMsg  = " + s4091QryMsg);
        }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("Call Service s4091Qry Failed!",0);
            </script>
        <%
            System.out.println("# return from f4091_1.jsp -> Call Service s4091Qry Failed!");
            e.printStackTrace();
        }
        
    }else{
        sChanceId = "";
        sWorkNo = "";
        sStartDate = "";
        sStopDate = "";
    }
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link href="s2002.css" rel="stylesheet" type="text/css">		
	<script type="text/javascript" src="/njs/extend/jquery/portalet/interface_pack.js"></script>
    <title><%=opName%></title>
</head>
<!--<center><marquee direction=down behavior=slide height=60 ><font size='10' color='red'><b>wangzn���ԣ�ԭҳ�汸��Ϊf4091_1.jsp.bak</b></font></marquee></cernter>-->
<script type=text/javascript>
    $().ready(function(){ 
        <% if("link".equals(openLabel)){ %>
            document.all.orderList2.style.display="block";
        <% }else if("opcode".equals(openLabel) && "search".equals(flag)){ %>
            document.all.orderList1.style.display="block";
        <% } %>
    });
    
    //ִ�в�ѯ
    function doSearch(){
        frm.action="f4091_1.jsp?flag=search";
        frm.method="post";
        frm.submit();
    }
    
    //ִ�����
    function doClear(){
        $("#chanceId,#iWorkNo,#startDate,#stopDate").val("");
    }
    
    //ִ���������
    function doSub(obj){
        var vWaLen = $("#wa_len").val();
        var url1 = $(obj).attr("in_URL");
        url1 += "&count="+vWaLen+"&openFlag=From4091";
        url = "f4091_2_cfm.jsp?op_code=<%=opCode%>&in_ChanceId=<%=in_ChanceId%>&wa_no1=<%=wa_no1%>"+url1;
        document.frm.action=url;
        document.frm.submit();
        //javascript:topage('3690','000','1','���Ų�Ʒ����',url);
    }
</script>

<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<% if("opcode".equals(openLabel)){ %>
<div class="title">
	<div id="title_zi">��ѯ����</div>
</div>

<table cellspacing=0>
    <tr>
        <td class='blue'>�̻�����</td>
        <td>
            <input type="text" name="chanceId" id="chanceId" value="<%=sChanceId%>" v_type='0_9' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' />
        </td>
        <td class='blue'>����</td>
        <td>
            <input type="text" name="iWorkNo" id="iWorkNo" value="<%=sWorkNo%>" />
        </td>
    </tr>
    <tr>
        <td class='blue'>��ʼʱ��</td>
        <td>
            <input type="text" name="startDate" id="startDate" value="<%=sStartDate%>" maxlength='8' v_type='date' v_format='yyyyMMdd' onblur='forDate(this);' />
        </td>
        <td class='blue'>����ʱ��</td>
        <td>
            <input type="text" name="stopDate" id="stopDate" value="<%=sStopDate%>" maxlength='8' v_type='date' v_format='yyyyMMdd' onblur='forDate(this);' />
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
<% } %>

<div  id="orderList1" style="display:none">
<div class="title">
	<div id="title_zi">���񶨵���ѯ</div>
</div>
<table cellspacing=0>
    <tr>
        <th>������ˮ</th>
        <th>������������</th>
        <th>Ʒ��</th>
        <th>�Ƿ�鵵</th>
        <th>�Ƿ񿢹�</th>
        <th>��������</th>
        <th>�ͻ����</th>
        <th>�û����</th>
    </tr>
    <%
        if("search".equals(flag)){
            for(int i=0;i<orderList2.length;i++){
                String tdClass = "";
                if (i%2==0){
                    tdClass = "Grey";
                }
            
                out.print("<tr>");
                out.print("<td class="+tdClass+">"+orderList2[i][0]+"</td>");
                out.print("<td class="+tdClass+">"+orderList2[i][1]+"</td>");
                out.print("<td class="+tdClass+">"+orderList2[i][4]+"</td>");
                out.print("<td class="+tdClass+">"+orderList2[i][5]+"</td>");
                out.print("<td class="+tdClass+">"+orderList2[i][6]+"</td>");
                out.print("<td class="+tdClass+">"+orderList2[i][7]+"</td>");
                out.print("<td class="+tdClass+">"+orderList2[i][2]+"</td>");
                out.print("<td class="+tdClass+">"+orderList2[i][3]+"</td>");
                out.print("</tr>");
            }
        }
    %>
</table>
<div id="footer">
    <input type='button' class='b_foot' value='����' onclick='history.go(-1)' />
    <input type='button' class='b_foot' value='�ر�' onclick='removeCurrentTab()' />
</div>
</div>

<div  id="orderList2" style="display:none">
<div class="title">
	<div id="title_zi">���񶨵���ѯ</div>
</div>

<table cellspacing=0>
    <tr>
        <th>�̻�����</th>
        <th>���񶨵���</th>
        <th>��������</th>
        <th>Ʒ������</th>
        <th>����Ʒ����</th>
        <th>ԭ�û�id_no</th>
        <th>������</th>
    </tr>
    <%
        if("link".equals(openLabel)){
            
            for(int i=0;i<orderList.length;i++){
                String tdClass = "";
                String disabled = "";
                if (i%2==0){
                    tdClass = "Grey";
                }
                out.print("<tr>");
                for(int j=0;j<orderList[i].length-6;j++){
                    out.print("<td class="+tdClass+">"+orderList[i][j]+"</td>");
                }
                if(!("0".equals(orderList[i][9]))){
                 disabled = "disabled";
                }
                out.print("<td class="+tdClass+"><input type='button' "+disabled+" class='b_text' value='����' name='receive"+i+"' id='receive"+i+"' chanceName='"+orderList[i][0]+"' orderNo='"+orderList[i][1]+"' grpName='"+orderList[i][2]+"' smName='"+orderList[i][3]+"' offerName='"+orderList[i][4]+"' oldIdNo='"+orderList[i][5]+"' in_URL='"+orderList[i][6]+"' onclick='doSub(this)' /></td>");
                out.print("</tr>");
            }
        }
    %>
</table>
<div id="footer">
    <input type='button' class='b_foot' value='�ر�' onclick='removeCurrentTab()' />
</div>
</div>
<input type='hidden' id='wa_len' name='wa_len' value='<%=orderList.length%>' />
<input type='hidden' id='op_code' name='op_code' value='<%=opCode%>' />
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
