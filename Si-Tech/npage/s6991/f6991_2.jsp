<%
    /********************
     * @ OpCode    :  6991
     * @ OpName    :  SIM卡变更历史和详细信息查询
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2010-01-28
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode = "6991";
    String opName = "SIM卡变更历史和详细信息查询";
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));
    String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String iPhoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));
    
    String iSimNo = "";
    String sqlStr = "select sim_no from dsimres where  phone_no = "+iPhoneNo;
    System.out.println("sql = "+sqlStr);
%>
    <wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr" scope="end"/>
<%
    if("000000".equals(retCode)){
        if(retArr.length>0){
            iSimNo = retArr[0][0];
        }else{
            System.out.println("SIM卡不存在!");
        %>
            <script type="text/javascript">
                rdShowMessageDialog("SIM卡不存在，请重新输入！",0);
                history.go(-1);
            </script>
        <%
        }
    }else{
        System.out.println("查询Sim卡号码出错！");
    %>
        <script type="text/javascript">
            rdShowMessageDialog("查询Sim卡号码出错！",0);
            history.go(-1);
        </script>
    <%
    }
    System.out.println("phoneNo = "+iPhoneNo);
    /* BEGIN:查询SIM卡变更历史 */
    String iChnSource = "06"; /* 渠道标识：01-BOSS；02-网上营业厅；03-掌上营业厅；04-短信营业厅；05-多媒体查询机；06-10086 */
    String[][] iSimModHis = new String[][]{};
%>
    <wtc:service name="sPCSelService" retcode="sPCSelServiceCode" retmsg="sPCSelServiceMsg" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="0"/>
    	<wtc:param value="<%=iChnSource%>"/> 
    	<wtc:param value=""/> 
    	<wtc:param value="<%=workNo%>"/> 
    	<wtc:param value="<%=workPwd%>"/> 
    	<wtc:param value="<%=iPhoneNo%>"/> 
    	<wtc:param value=""/> 
    	<wtc:param value=""/> 
    </wtc:service>
    <wtc:array id="sPCSelServiceArr" scope="end"/>
<%
    if("000000".equals(sPCSelServiceCode)){
        iSimModHis = sPCSelServiceArr;
    }else{
    %>
        <script type="text/javascript">
            rdShowMessageDialog("查询SIM卡变更历史失败！错误代码：<%=sPCSelServiceCode%>,错误信息：<%=sPCSelServiceMsg%>",0);
            history.go(-1);
        </script>
    <%
    }
    /* END:查询SIM卡变更历史 */
    
    /* BEGIN:查询SIM卡详细信息 */
    String[] inputFlagArr = new String[6];
    inputFlagArr[0] = "5";  /* 手机号码 */
    inputFlagArr[1] = "78"; /* SIM 卡号 */
    inputFlagArr[2] = "98"; /* PUK1 码 */
    inputFlagArr[3] = "99"; /* PUK2 码 */
    inputFlagArr[4] = "96"; /* PIN1 码 */
    inputFlagArr[5] = "97"; /* PIN2 码 */
    String[][] iSimInfo = new String[][]{};
%>
    <wtc:service name="sPubUserMsg" retcode="sPubUserMsgCode" retmsg="sPubUserMsgMsg" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="0"/>
    	<wtc:param value="<%=iPhoneNo%>"/> 
    	<wtc:params value="<%=inputFlagArr%>"/> 
    </wtc:service>
    <wtc:array id="sPubUserMsgArr" scope="end"/>
<%
    if("000000".equals(sPubUserMsgCode)){
        iSimInfo = sPubUserMsgArr;
    }else{
    %>
        <script type="text/javascript">
            rdShowMessageDialog("查询SIM卡信息失败！错误代码：<%=sPubUserMsgCode%>,错误信息：<%=sPubUserMsgMsg%>",0);
            history.go(-1);
        </script>
    <%   
    }
    /* END:查询SIM卡详细信息 */
%>

<%if(iSimInfo.length>0){%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">SIM卡变更历史</div>
</div>
<table cellspacing=0>
<tr>
    <th>操作工号</th>
    <th>操作工号名称</th>
    <th>操作时间</th>
    <th>操作名称</th>
</tr>
<%
    for(int i=0;i<iSimModHis.length;i++){
    %>
        <tr>
            <td><%=iSimModHis[i][3]%></td>
            <td><%=iSimModHis[i][4]%></td>
            <td><%=iSimModHis[i][6]%></td>
            <td><%=iSimModHis[i][8]%></td>
        </tr>
    <%
    }
%>
</table>

</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">SIM卡详细信息</div>
</div>

<table cellspacing="0">
<tr>
    <td class="blue">SIM卡号</td>
    <td colspan="3">
        <input type="text" id="sim_no" name="sim_no" value="<%=iSimInfo[1][2]%>" class="InputGrey" readOnly />
    </td>
</tr>
<tr>
    <td class="blue">PUK1 码</td>
    <td>
        <input type="text" id="puk1_no" name="puk1_no" value="<%=iSimInfo[2][2]%>" class="InputGrey" readOnly />
    </td>
    <td class="blue">PUK2 码</td>
    <td>
        <input type="text" id="puk2_no" name="puk2_no" value="<%=iSimInfo[3][2]%>" class="InputGrey" readOnly />
    </td>
</tr>
<tr>
    <td class="blue">PIN1 码</td>
    <td>
        <input type="text" id="pin1_no" name="pin1_no" value="<%=iSimInfo[4][2]%>" class="InputGrey" readOnly />
    </td>
    <td class="blue">PIN2 码</td>
    <td>
        <input type="text" id="pin2_no" name="pin2_no" value="<%=iSimInfo[5][2]%>" class="InputGrey" readOnly />
    </td>
</tr>
<tr id="footer">
    <td colspan="4">
        <input type="button" id="bBack" name="bBack" value="返回" class="b_foot" />
        <input type="button" id="bClose" name="bClose" value="关闭" class="b_foot" />
    </td>
</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</form>

<script type=text/javascript>
    $(document).ready(function(){
        $("#bBack").bind("click",function(){
            history.go(-1);
        });
        $("#bClose").bind("click",removeCurrentTab);
    });
</script>

</body>
</html>
<%}%>