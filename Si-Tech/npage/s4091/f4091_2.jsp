<%
/********************
 * @ OpCode    :  4091
 * @ OpName    :  服务定单查询
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
    String opName = "服务定单查询";
    
    String workNo = (String)session.getAttribute("workNo");
    String workPwd = (String)session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");
    
    String openLabel = ""; /* #标志位# link：通过任务列表模块进入此订购模块；opcode：通过opcode打开此页面。*/
    
    String in_ChanceId = (String)request.getParameter("in_ChanceId"); //商机编码
    String wa_no1 = (String)request.getParameter("wa_no1"); //工单编号
    
    System.out.println("# From f4091_1.jsp -> in_ChanceId = "+in_ChanceId);
    System.out.println("# From f4091_1.jsp -> wa_no1 = "+wa_no1);
    /*********************
     * 判断接入此模块的方式，并做相应的处理。
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
     * 通过任务列表页面接入时，调用s4091QryBatch服务查询定单。
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
    
    String flag = (String)request.getParameter("flag"); //#标志位# search:说明点击“查询”按钮后提交到此页面。
    String sChanceId = ""; //商机编码
    String sWorkNo = ""; //工号
    String sStartDate = ""; //开始时间
    String sStopDate = ""; //结束时间
    
    String orderList2[][] = new String[][]{};
    
    /*********************
     * 通过查询提交到本页面，调用s4091Qry服务进行查询。
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
                            rdShowMessageDialog("没有符合条件的记录！",0);
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
<!--<center><marquee direction=down behavior=slide height=60 ><font size='10' color='red'><b>wangzn测试，原页面备份为f4091_1.jsp.bak</b></font></marquee></cernter>-->
<script type=text/javascript>
    $().ready(function(){ 
        <% if("link".equals(openLabel)){ %>
            document.all.orderList2.style.display="block";
        <% }else if("opcode".equals(openLabel) && "search".equals(flag)){ %>
            document.all.orderList1.style.display="block";
        <% } %>
    });
    
    //执行查询
    function doSearch(){
        frm.action="f4091_1.jsp?flag=search";
        frm.method="post";
        frm.submit();
    }
    
    //执行清除
    function doClear(){
        $("#chanceId,#iWorkNo,#startDate,#stopDate").val("");
    }
    
    //执行任务接收
    function doSub(obj){
        var vWaLen = $("#wa_len").val();
        var url1 = $(obj).attr("in_URL");
        url1 += "&count="+vWaLen+"&openFlag=From4091";
        url = "f4091_2_cfm.jsp?op_code=<%=opCode%>&in_ChanceId=<%=in_ChanceId%>&wa_no1=<%=wa_no1%>"+url1;
        document.frm.action=url;
        document.frm.submit();
        //javascript:topage('3690','000','1','集团产品订购',url);
    }
</script>

<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<% if("opcode".equals(openLabel)){ %>
<div class="title">
	<div id="title_zi">查询条件</div>
</div>

<table cellspacing=0>
    <tr>
        <td class='blue'>商机编码</td>
        <td>
            <input type="text" name="chanceId" id="chanceId" value="<%=sChanceId%>" v_type='0_9' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' />
        </td>
        <td class='blue'>工号</td>
        <td>
            <input type="text" name="iWorkNo" id="iWorkNo" value="<%=sWorkNo%>" />
        </td>
    </tr>
    <tr>
        <td class='blue'>开始时间</td>
        <td>
            <input type="text" name="startDate" id="startDate" value="<%=sStartDate%>" maxlength='8' v_type='date' v_format='yyyyMMdd' onblur='forDate(this);' />
        </td>
        <td class='blue'>结束时间</td>
        <td>
            <input type="text" name="stopDate" id="stopDate" value="<%=sStopDate%>" maxlength='8' v_type='date' v_format='yyyyMMdd' onblur='forDate(this);' />
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
<% } %>

<div  id="orderList1" style="display:none">
<div class="title">
	<div id="title_zi">服务定单查询</div>
</div>
<table cellspacing=0>
    <tr>
        <th>操作流水</th>
        <th>定单生成日期</th>
        <th>品牌</th>
        <th>是否归档</th>
        <th>是否竣工</th>
        <th>操作工号</th>
        <th>客户编号</th>
        <th>用户编号</th>
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
    <input type='button' class='b_foot' value='返回' onclick='history.go(-1)' />
    <input type='button' class='b_foot' value='关闭' onclick='removeCurrentTab()' />
</div>
</div>

<div  id="orderList2" style="display:none">
<div class="title">
	<div id="title_zi">服务定单查询</div>
</div>

<table cellspacing=0>
    <tr>
        <th>商机名称</th>
        <th>服务定单号</th>
        <th>集团名称</th>
        <th>品牌名称</th>
        <th>销售品名称</th>
        <th>原用户id_no</th>
        <th>任务处理</th>
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
                out.print("<td class="+tdClass+"><input type='button' "+disabled+" class='b_text' value='接收' name='receive"+i+"' id='receive"+i+"' chanceName='"+orderList[i][0]+"' orderNo='"+orderList[i][1]+"' grpName='"+orderList[i][2]+"' smName='"+orderList[i][3]+"' offerName='"+orderList[i][4]+"' oldIdNo='"+orderList[i][5]+"' in_URL='"+orderList[i][6]+"' onclick='doSub(this)' /></td>");
                out.print("</tr>");
            }
        }
    %>
</table>
<div id="footer">
    <input type='button' class='b_foot' value='关闭' onclick='removeCurrentTab()' />
</div>
</div>
<input type='hidden' id='wa_len' name='wa_len' value='<%=orderList.length%>' />
<input type='hidden' id='op_code' name='op_code' value='<%=opCode%>' />
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
