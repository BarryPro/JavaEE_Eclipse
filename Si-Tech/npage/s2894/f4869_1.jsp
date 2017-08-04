<%
/*************************************
* ��  ��: ����V������ȷ�϶��Ž����ѯ 4869
* ��  ��: version v1.0
* ������: si-tech
* ������: shengzd @ 2010-03-22
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode     = "4869";
    String opName     = "������VPMN����ȷ�϶�����������ѯ";
    
    String workNo     = (String)session.getAttribute("workNo");//��������!!!
    String regionCode = (String)session.getAttribute("regCode");
    
    String flag      = (String)request.getParameter("flag"); //#��־λ# search:˵���������ѯ����ť���ύ����ҳ�档
    String vLoginNo  = "";//��ѯ����!!!
    String vUnitId   = "";
    String vBeginTime= "";
    String vEndTime  = "";
    String vPhoneNo  = "";
    String vDealFlag = "";
    
    String orderList[][] = new String[][]{};
    
    /****************************************************
     * ͨ����ѯ�ύ����ҳ�棬����s4869Qry������в�ѯ�� *
     ****************************************************/
    if("search".equals(flag)){
        vLoginNo    = (String)request.getParameter("loginNo");
        vBeginTime  = (String)request.getParameter("beginTime");
        vEndTime    = (String)request.getParameter("endTime");
        vUnitId     = (String)request.getParameter("unitId");
        vPhoneNo    = (String)request.getParameter("phoneNo");
        vDealFlag   = (String)request.getParameter("dealResult");
        
 try{
        %>
             <wtc:service name="s4869Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="s4869QryCode" retmsg="s4869QryMsg" outnum="8" >
                <wtc:param value="<%=vBeginTime%>"/>
                <wtc:param value="<%=vEndTime%>"/>
                <wtc:param value="<%=vLoginNo%>"/>
                <wtc:param value="<%=vUnitId%>"/>
                <wtc:param value="<%=vPhoneNo%>"/>
                <wtc:param value="<%=vDealFlag%>"/>
             </wtc:service>
             <wtc:array id="s4869QryArr" scope="end"/>
        <%
        System.out.println("# s4869QryCode = "+s4869QryCode);
        System.out.println("# s4869QryArr.length = "+s4869QryArr.length);
            if("000000".equals(s4869QryCode)){
                if(s4869QryArr.length>0){
                    orderList = s4869QryArr;
                }else{
                    %>
                        <script type=text/javascript>
                            rdShowMessageDialog("û�в鵽���������ļ�¼��",1);
                            window.location.href = "f4869_1.jsp";
                        </script>
                    <%
                }
            }else{
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("<%=s4869QryCode%>,<%=s4869QryMsg%>",0);
                </script>
            <%
            }
            System.out.println("# return from f4869_1.jsp by s4869Qry -> returnCode = " + s4869QryCode);
            System.out.println("# return from f4869_1.jsp by s4869Qry -> returnMsg  = " + s4869QryMsg);
        }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("Call Service s4869Qry Failed!",0);
            </script>
        <%
            System.out.println("# return from f4869_1.jsp -> Call Service s4869Qry Failed!");
            e.printStackTrace();
        }
    }else{
        vLoginNo   = "";
        vBeginTime = "";
        vEndTime   = "";
        vUnitId    = "";
        vPhoneNo   = "";
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
    	
    	if(!check(document.frm)){
			return false;			
		}
    	
    	
        if($("#beginTime").val()!='' && !forDate(document.getElementById('beginTime'))){
            return false;
        }
        
        if($("#endTime").val()!='' && !forDate(document.getElementById('endTime'))){
            return false;
        }
        
        var iLoginNo   = $("#loginNo").val();
        var iPhoneNo    = $("#phoneNo").val();
        
        if( iLoginNo =='' && iPhoneNo == '' )
        {
            rdShowMessageDialog("�������ź��ֻ��������һ��",1);
            $("#dealResult").val('0');
            return false;
        }
        
        
        var iBeginTime = $("#beginTime").val();
        var iEndTime   = $("#endTime").val();
        var iLoginNo   = $("#loginNo").val();
        var iUnitId    = $("#unitId").val();
        var iPhoneNo   = $("#phoneNo").val();

        if(iBeginTime == '' && iEndTime == '' && iLoginNo == '' && iUnitId == '' && iPhoneNo == '')
        {
            rdShowMessageDialog("����������һ����Ϊ��ѯ������",1);
            $("#beginTime").focus();
            return false;
        }
        
        if(iUnitId != '' && forNonNegInt(frm.unitId) == false)
        {
            $("#unitId").focus();
            rdShowMessageDialog("�����ű��롱���������֣�",0);
            return false;
        }
        
        if(iPhoneNo != '' && forNonNegInt(frm.phoneNo) == false)
        {
            $("#phoneNo").focus();
            rdShowMessageDialog("���ֻ����롱������11λ���ȵ����֣�",0);
            return false;
        }
        
        frm.action="f4869_1.jsp?flag=search";
        frm.method="post";
        frm.submit();
    }

    // ִ�����
    function doClear(){
        $("#beginTime,#endTime,#loginNo,#unitId,#phoneNo").val("");
    }
    
    function checkDealFlag(){
        var iLoginNo   = $("#loginNo").val();
        var iUnitId    = $("#unitId").val();
        
        if(iLoginNo == '' && iUnitId == '')
        {
            rdShowMessageDialog("����������ѯʱ�����������š��͡����ű��롱������Ҫ����һ�",1);
            $("#dealResult").val('0');
            return false;
        }
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
            <input type="text" name="beginTime" id="beginTime" value="<%=vBeginTime%>" maxlength='8' v_type='date' v_must = '1' v_format='yyyyMMdd' onblur='if(this.value!=""){forDate(this);}' />
            <font color="orange">* ( �����ʽ��yyyyMMdd )</font>
        </td>
        <td class='blue'>����ʱ��</td>
        <td>
            <input type="text" name="endTime" id="endTime" value="<%=vEndTime%>" maxlength='8' v_type='date' v_must = '1' v_format='yyyyMMdd' onblur='if(this.value!=""){forDate(this);}' />
            <font color="orange">* ( �����ʽ��yyyyMMdd )</font>
        </td>
    </tr>
    <tr>
        <td class='blue'>��������</td>
        <td>
            <input type="text" name="loginNo" id="loginNo" value="<%=vLoginNo%>" maxlength='6'/>
        </td>
        <td class='blue'>���ű��</td>
        <td>
            <input type="text" name="unitId" id="unitId" value="<%=vUnitId%>" maxlength='10'/>
        </td>
    </tr>
    <tr>
    	  <td class='blue'>�ֻ�����</td>
    	  <td>
    	     <input type="text" name="phoneNo" id="phoneNo" value="<%=vPhoneNo%>" maxlength='11'/>	
    	  </td>
    	  <td class='blue'>������</td>
    	  <td>
            <select name='dealResult' id='dealResult' onchange='checkDealFlag()'>
               <option value='0' selected>...... ��ѡ�� ......</option>
               <option value='Y'>01 Y ---- > �ɹ�</option>
               <option value='N'>02 N ---- > ʧ��</option>
            </select>
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
	<div id="title_zi">������</div>
</div>

<table cellspacing=0>
    <tr>
        <th>���ж��Ŷ˿ں�</th>
        <th>�ֻ�����</th>
        <th>Ʒ��</th>
        <th>������</th>
        <th>������Ϣ</th>
        <th>��������</th>
        <th>��������</th>
        <th>���Ź�������</th>
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