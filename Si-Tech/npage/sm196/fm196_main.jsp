<%
    /*************************************
    * 功  能: 工单采集信息查询  m196
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2014/11/5
    **************************************/
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="import java.text.SimpleDateFormat"%>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    
    
    Date currentTime = new Date(); 
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
		String currentTimeString = formatter.format(currentTime);
		Calendar cal = Calendar.getInstance(); 
		cal.add(Calendar.MONTH , -5);    //算出6个月以前的
		cal.get(Calendar.YEAR);         //6个月以前的年
		cal.get(Calendar.MONTH);         //6个月以前的月
	  String v_beforSixMonthFirstDay = new SimpleDateFormat("yyyyMM").format(cal.getTime());
	  String beforSixMonthFirstDay = v_beforSixMonthFirstDay + "01";
%>
  <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title><%=opName%></title>       
				<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
            window.onload=function(){
                
            }
          
            function query(submitBtn2){
              /* 按钮延迟 */
		    			controlButt(submitBtn2);
		    			/* 事后提醒 */
		    			//getAfterPrompt();
		    			
		    			var markDiv=$("#intablediv"); 
              markDiv.empty();
		    			
		    			var idIccid=$.trim($("#idIccid").val());
              var operNo=$.trim($("#operNo").val());
		    			var startTime=$.trim($("#startTime").val());
              var endTime=$.trim($("#endTime").val());
              
		    			if(idIccid == ""&& operNo == "" && startTime == "" && endTime == ""){
		    				rdShowMessageDialog("请至少输入一个查询条件！");
                return false;	
		    			}
		    			
		    			if(idIccid == "" && operNo == ""){
		    				rdShowMessageDialog("必须输入证件号码、或操作工号作为查询条件！");
                return false;	
		    			}
		    			
		    			if(operNo != "" && idIccid == ""){
		    				if(startTime == "" || endTime == ""){
		    					rdShowMessageDialog("根据操作工号查询，开始时间和结束时间必须输入！");
                  return false;	
		    				}
		    			}
		    			
		    			if(idIccid != "" && operNo == ""){
		    				if(startTime == "" && endTime == ""){
		    					endTime = "<%=currentTimeString%>";
		    					startTime = "<%=beforSixMonthFirstDay%>"; 
		    				}
		    			}
		    			
		    			if(startTime != "" && endTime != ""){
		    				if(startTime > endTime){
		    					rdShowMessageDialog("开始时间应小于结束时间,请重新输入！");
                	return false;	
		    				}
								if((startTime.substring(0,4) != endTime.substring(0,4)) || (startTime.substring(4,6) != endTime.substring(4,6))){
									rdShowMessageDialog("根据操作工号查询，开始时间和结束时间跨度最大为一个自然月！");
                	return false;	
								}
		    			}
              
              var packet = new AJAXPacket("fm196_ajax_query.jsp","正在获得数据，请稍候......");
              	packet.data.add("startTime",startTime);
              	packet.data.add("endTime",endTime);
              	packet.data.add("idIccid",idIccid);
              	packet.data.add("operNo",operNo);
              	packet.data.add("opCode","<%=opCode%>");
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
                   window.location.href="fm196_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
                }
            }
            
            //只需要将table增加一个vColorTr='set' 属性就可以隔行变色
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
						
						$("#startTime").click(
							function (){
								WdatePicker({startDate:'%y%M%d'
									,dateFmt:'yyyyMMdd'
									,readOnly:true
									,alwaysUseStartDate:true})	
							}
						);
			
						$("#endTime").click(
							function (){
								WdatePicker({startDate:'%y%M%d'
									,dateFmt:'yyyyMMdd'
									,readOnly:true
									,alwaysUseStartDate:true})	
							}
						);

        </script>
    </head>
    <body>
        <form name="frm" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">输入查询条件</div>
        	</div>
            <table cellspacing="0">
            		 <tr>
                    <td class="blue">证件号码</td>
                    <td>
                        <input type="text" id="idIccid" name="idIccid" value="" />
                    </td>
                    <td class="blue">操作工号</td>
                    <td>
                        <input type="text" id="operNo" name="operNo" value="" />
                    </td>
                </tr>
                <tr>
                    <td class="blue">开始时间</td>
                    <td>
                    		<input type = 'text' id = 'startTime' name = 'startTime' value=''
                    		ch_name = '开始时间' 
												onClick = "WdatePicker({maxDate:'%y-%M-%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})" /> 
                    </td>
                    <td class="blue">结束时间</td>
                    <td>
							 					<input type = 'text' id = 'endTime' name = 'endTime' value='' 
												ch_name = '结束时间'  			
												onClick = "WdatePicker({maxDate:'%y-%M-%d',dateFmt:'yyyyMMdd',readOnly:true,alwaysUseStartDate:true})" /> 
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