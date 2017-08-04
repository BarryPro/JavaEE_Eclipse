<%
/*************************************
* 功  能: 组合营销成员操作记录查询7484
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: 
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode     = "7484";
    String opName     = "组合营销成员操作记录查询";
    
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String iOrgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String iLoginPwd = WtcUtil.repNull((String)session.getAttribute("password"));
    String iIpAddr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
    String regionCode = iOrgCode.substring(0,2);
    
    
    String flag      = (String)request.getParameter("flag"); //#标志位# search:说明点击“查询”按钮后提交到此页面。
    String vPhoneNo  = "";
    String vLoginNo  = "";//查询工号!!!
    String vUnitId   = "";
    String vBeginTime= "";
    String vEndTime  = "";
    
    
    String orderList[][] = new String[][]{};
    
    /****************************************************
     * 通过查询提交到本页面，调用s7484Qry服务进行查询。 *
     ****************************************************/
    if("search".equals(flag)){
        vLoginNo    = (String)request.getParameter("loginNo");
        vBeginTime  = (String)request.getParameter("beginTime");
        vEndTime    = (String)request.getParameter("endTime");
        vUnitId     = (String)request.getParameter("unitId");
        vPhoneNo    = (String)request.getParameter("phoneNo");
        
 try{
        %>
             <wtc:service name="s7484Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="s7484QryCode" retmsg="s7484QryMsg" outnum="6" >
                <wtc:param value="<%=workNo%>"/>
                <wtc:param value="<%=iLoginPwd%>"/>
                <wtc:param value="<%=iOrgCode%>"/>
                <wtc:param value="<%=iIpAddr%>"/>
                <wtc:param value="<%=vPhoneNo%>"/>
                <wtc:param value="<%=vLoginNo%>"/>
                <wtc:param value="<%=vUnitId%>"/>
                <wtc:param value="<%=vBeginTime%>"/>
                <wtc:param value="<%=vEndTime%>"/>
             </wtc:service>
             <wtc:array id="s7484QryArr" scope="end"/>
        <%
        System.out.println("# s7484QryCode = "+s7484QryCode);
        System.out.println("# s7484QryArr.length = "+s7484QryArr.length);
            if("000000".equals(s7484QryCode)){
                if(s7484QryArr.length>0){
                    orderList = s7484QryArr;
                }else{
                    %>
                        <script type=text/javascript>
                            rdShowMessageDialog("没有查到符合条件的记录！",1);
                            window.location.href = "f7484_1.jsp";
                        </script>
                    <%
                }
            }else{
            %>
                <script type=text/javascript>
                    rdShowMessageDialog("<%=s7484QryCode%>,<%=s7484QryMsg%>",0);
                </script>
            <%
            }
            System.out.println("# return from f7484_1.jsp by s7484Qry -> returnCode = " + s7484QryCode);
            System.out.println("# return from f7484_1.jsp by s7484Qry -> returnMsg  = " + s7484QryMsg);
        }catch(Exception e){
        %>
            <script type=text/javascript>
                rdShowMessageDialog("Call Service s7484Qry Failed!",0);
            </script>
        <%
            System.out.println("# return from f7484_1.jsp -> Call Service s7484Qry Failed!");
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
    
    // 执行查询
    function doSearch(){
    	
        if($("#beginTime").val()!='' && !forDate(document.getElementById('beginTime'))){
            return false;
        }
        
        if($("#endTime").val()!='' && !forDate(document.getElementById('endTime'))){
            return false;
        }
        var iBeginTime = $("#beginTime").val();
        var iEndTime   = $("#endTime").val();
        var iLoginNo   = $("#loginNo").val();
        var iUnitId    = $("#unitId").val();
        var iPhoneNo   = $("#phoneNo").val();

        if(iBeginTime == '' && iEndTime == '' && iLoginNo == '' && iUnitId == '' && iPhoneNo == '')
        {
            rdShowMessageDialog("请至少输入一项作为查询条件！",1);
            $("#beginTime").focus();
            return false;
        }
        
        if(iUnitId != '' && forNonNegInt(frm.unitId) == false)
        {
            $("#unitId").focus();
            rdShowMessageDialog("“集团编码”必须是数字！",0);
            return false;
        }
        
        if(iPhoneNo != '' && forNonNegInt(frm.phoneNo) == false)
        {
            $("#phoneNo").focus();
            rdShowMessageDialog("“手机号码”必须是11位长度的数字！",0);
            return false;
        }
        
        frm.action="f7484_1.jsp?flag=search";
        frm.method="post";
        frm.submit();
    }

    // 执行清除
    function doClear(){
        $("#beginTime,#endTime,#loginNo,#unitId,#phoneNo").val("");
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
            <input type="text" name="beginTime" id="beginTime" value="<%=vBeginTime%>" maxlength='8' v_type='date' v_format='yyyyMMdd' onblur='if(this.value!=""){forDate(this);}' />
            <font color="orange">( 输入格式：yyyyMMdd )</font>
        </td>
        <td class='blue'>结束时间</td>
        <td>
            <input type="text" name="endTime" id="endTime" value="<%=vEndTime%>" maxlength='8' v_type='date' v_format='yyyyMMdd' onblur='if(this.value!=""){forDate(this);}' />
            <font color="orange">( 输入格式：yyyyMMdd )</font>
        </td>
    </tr>
    <tr>
        <td class='blue'>操作工号</td>
        <td>
            <input type="text" name="loginNo" id="loginNo" value="<%=vLoginNo%>" maxlength='6'/>
        </td>
        <td class='blue'>集团编号</td>
        <td>
            <input type="text" name="unitId" id="unitId" value="<%=vUnitId%>" maxlength='10'/>
        </td>
    </tr>
    <tr>
    	  <td class='blue'>手机号码</td>
    	  <td>
    	     <input type="text" name="phoneNo" id="phoneNo" value="<%=vPhoneNo%>" maxlength='11'/>	
    	  </td>
    	  <td class='blue'></td>
    	  <td>
           
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
	<div id="title_zi">受理结果</div>
</div>

<table cellspacing=0>
    <tr>
        
        <th>集团编号</th>
        <th>集团名称</th>
        <th>客户经理</th>
        <th>操作时间</th>
        <th>手机号码</th>
        <th>销售品名称</th>
        
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