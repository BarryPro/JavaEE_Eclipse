<%
/********************
 * @ OpCode    :  4089
 * @ OpName    :  业务受理结果查询
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
    String opName = "业务受理结果查询";
    
    String workNo = (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode");
    
    String flag = (String)request.getParameter("flag"); //#标志位# search:说明点击“查询”按钮后提交到此页面。
    String sWorkNo = ""; //工号
    String sAccept = ""; //操作流水
    String sCustId = ""; //客户ID
    String sGrpId = "";
    String sStartDate = ""; //开始时间
    String sStopDate = ""; //结束时间
    
    String orderList[][] = new String[][]{};
    
    /*********************
     * 通过查询提交到本页面，调用s4089Qry服务进行查询。
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
                            rdShowMessageDialog("没有符合条件的记录！",0);
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
    
    // 执行查询
    function doSearch(){
        if($("#startDate").val()!='' && !forDate(document.getElementById('startDate'))){
            return false;
        }
        
        if($("#stopDate").val()!='' && !forDate(document.getElementById('stopDate'))){
            return false;
        }
        
        var vWorkNo = $("#iWorkNo").val();
        if(vWorkNo == ''){
            rdShowMessageDialog("操作工号不能为空！",0);
            $("#iWorkNo").focus();
            return false;
        }
        
        frm.action="f4089_1.jsp?flag=search";
        frm.method="post";
        frm.submit();
    }
    
    // 执行清除
    function doClear(){
        $("#iWorkNo,#custId,#iAccept,#startDate,#stopDate").val("");
    }

</script>

<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">查询条件</div>
</div>
<table cellspacing=0>
    <tr>
        <td class='blue'>开始时间</td>
        <td>
            <input type="text" name="startDate" id="startDate" value="<%=sStartDate%>" maxlength='8' v_type='date' v_format='yyyyMMdd' onblur='if(this.value!=""){forDate(this);}' />
        </td>
        <td class='blue'>结束时间</td>
        <td>
            <input type="text" name="stopDate" id="stopDate" value="<%=sStopDate%>" maxlength='8' v_type='date' v_format='yyyyMMdd' onblur='if(this.value!=""){forDate(this);}' />
        </td>
    </tr>
    <tr>
        <td class='blue'>操作工号</td>
        <td>
            <input type="text" name="iWorkNo" id="iWorkNo" value="<%=sWorkNo%>" />
            <font class='orange'>*</font>
        </td>
        <td class='blue'>操作流水</td>
        <td>
            <input type="text" name="iAccept" id="iAccept" value="<%=sAccept%>" />
        </td>
    </tr>
    <tr>
        <td class='blue'>用户号码</td>
        <td>
            <input type="text" name="custId" id="custId" value="<%=sCustId%>" />
        </td>
        <td class='blue'>集团编号</td>
        <td>
            <input type="text" name="grpId" id="grpId" value="<%=sGrpId%>" />
        </td>
    </tr>
    
    <tr id='footer'>
        <td colspan='4'>
            <input type="button" class='b_foot' value="查询" name="search" id="search" onclick="doSearch()" />
            <input type="button" class='b_foot' value="清除" name="clear" id="clear" onclick="doClear()" />
        </td>
    </tr>
</table>

</div>
<div id="Operation_Table">
<div  id="orderList" style="display:none">
<div class="title">
	<div id="title_zi">业务受理结果查询列表</div>
</div>

<table cellspacing=0>
    <tr>
        <th>操作流水</th>
        <th>集团编号</th>
        <th>用户号码</th>
        <th>品牌</th>
        <th>处理结果</th>
        <th>处理信息</th>
        <th>处理日期</th>
        <th>操作工号</th>
        <th>操作功能</th>
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
            <input type="button" class="b_foot" id="close" name="close" value="关闭" onclick="removeCurrentTab()"/>
        </td>
    </tr>
</table>
</div>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>