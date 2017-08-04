<%
    /*************************************
    * 功  能: 集团成员二次确认短信代码查询 e163
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-8-3
    **************************************/
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>集团成员二次确认短信代码查询</title>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String workNo=WtcUtil.repNull((String)session.getAttribute("workNo"));
    String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));

    //获取数据库时间sql：
    String Strsql = "select to_char(sysdate-1,'yyyy-mm-dd hh24:mi:ss'),to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual";
%>
    <wtc:pubselect name="sPubSelect" routerKey="regionCode" routerValue="<%=regionCode%>" outnum="2">
        <wtc:sql><%=Strsql%></wtc:sql> 	
    </wtc:pubselect>
    <wtc:array id="result" scope="end"/> 
<%
    //获取当前数据库时间-24小时：
    String befor24Time = result[0][0];
    //数据库时间：
    String currentTimeString = result[0][1];
%>
         
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
            window.onload=function()
            {
                //时间默认显示
                $("#startTime").val("<%=befor24Time%>");
                $("#endTime").val("<%=currentTimeString%>");
            }
          
            //校验时间格式
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
                /* 按钮延迟 */
    			controlButt(submitBtn2);
    			/* 事后提醒 */
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
                    rdShowMessageDialog("系统不提供24小时之外的查询，请重新输入开始时间！");
                    return false;	
                }
                
                if(Date.parse(startTime.replace("-","/"))>Date.parse(endTime.replace("-","/")))
                {
                	rdShowMessageDialog("开始时间应小于结束时间，请重新输入！");
                    return false;	
                }
                
                if(Date.parse(endTime.replace("-","/"))>Date.parse(currentTimeVar.replace("-","/")))
                {
                    rdShowMessageDialog("结束时间大于当前系统时间，请重新输入！");
                    return false;	
                }
                
                if(phoneNo==""&&unitNo==""&&operateNo==""){
                    rdShowMessageDialog("请至少输入一个查询条件！");
                    return false;	
                }
                
                var packet = new AJAXPacket("fe163_ajax_query.jsp","正在获得数据，请稍候......");
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
                //找到添加表格的div
				var markDiv=$("#intablediv"); 
				markDiv.empty();
        		markDiv.append(data);
                var retCode = $("#retCode").val();
                var retMsg = $("#retMsg").val();
                if(retCode!="000000"){
                     rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
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
        		<div id="title_zi">输入查询条件</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td class="blue">开始时间</td>
                    <td>
                        <input type="text" id="startTime" name="startTime" v_format="yyyy-MM-dd HH:mm:ss"  v_must="1"  class="button" maxlength="19" onblur="checkTimeFormat()" />&nbsp;
                        <font color="orange">* ( 输入格式：yyyy-MM-dd HH:mm:ss )</font>
                    </td>
                    <td class="blue">结束时间</td>
                    <td>
                        <input type="text" id="endTime" name="endTime" v_format="yyyy-MM-dd HH:mm:ss"  v_must="1"  class="button" maxlength="19" onblur="checkTimeFormat()" />&nbsp;
                        <font color="orange">* ( 输入格式：yyyy-MM-dd HH:mm:ss )</font>
                    </td>
                </tr>
                <tr>
                    <td class="blue">手机号码</td>
                    <td>
                        <input type="text" id="phoneNo" name="phoneNo" v_type="mobphone" value="" />
                    </td>
                    <td class="blue">集团编号</td>
                    <td>
                        <input type="text" id="unitNo" name="unitNo" v_type="0_9" value="" />
                    </td>
                </tr>
                <tr>
                    <td class="blue">操作工号</td>
                    <td colspan="3">
                        <input type="text" id="operateNo" name="operateNo" v_type="string" value="" />
                    </td>
                </tr>			
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="查询" onClick="query(this)" />   
                        <input type="button" id="reSetBtn"  name="reSetBtn"  class="b_foot" value="重置" onClick="location.reload();" /> 
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>