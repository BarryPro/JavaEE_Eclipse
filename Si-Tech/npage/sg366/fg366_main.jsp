<%
    /*************************************
    * 功  能: 营销限制配置 g366
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-12-24
    **************************************/
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String workNo=WtcUtil.repNull((String)session.getAttribute("workNo"));
    String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String sqlStr = "select SEQ_PRODLIMIT.nextval from dual";
    String limitCodeStr = "";
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_limitCodeList" retmsg="retMsg_limitCodeList" outnum="1"> 
  <wtc:param value="<%=sqlStr%>"/>
    </wtc:service>
  <wtc:array id="limitCodeList"  scope="end"/>
  <%
    if("000000".equals(retCode_limitCodeList)){
      if(limitCodeList.length>0){
        limitCodeStr = limitCodeList[0][0];
      }
    }
  %>
    
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>营销限制配置</title>
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
            window.onload=function(){
            }
          
            function query(submitBtn2)
            {
                /* 按钮延迟 */
			    			controlButt(submitBtn2);
			    			/* 事后提醒 */
			    			getAfterPrompt();
			    			
			    			//if(!check(frm)) return false;
              	var chargeNo = $("#chargeNo").val();
              	var chargeName = $("#chargeName").val();
              	if(chargeNo==""&&chargeName==""){
              	  rdShowMessageDialog("请至少输入一个查询条件！");
                  return false;
              	}
              	window.open (
            			'seleQueryInfo.jsp?chargeNo='+chargeNo+"&chargeName="+chargeName , 
            			"newwindow",
            			'dialogHeight:450px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
            		);
             }
             
             var allListStr = "";
             var allList = "";
             var seleNum = 1; //选择的次数
             
             function doSeleQueryInfo(s){
               var allListSimple="";
               if(s){
                 var trArr = s.substring(0,s.length - 1).split(',');//获取新添加的行数据的所有记录
                 for(var i = 0,len = trArr.length; i < len; i++) {
                   if(allListStr && allListStr.indexOf(trArr[i]) != -1) {
		               }else{
		                 allListStr += trArr[i] + ',';
		               }
                 }
               }
               $("#intablediv").css("display","");
               $("#offerInfodiv").css("display","");
               $("#terminal").empty();
               if(allListStr.length > 0){
                 var allListStrTemp = allListStr.substring(0,allListStr.length - 1); 
                 allList = allListStrTemp.split(",");
                 for(var i = 0;i<allList.length;i++){
                   var aaa="";
                   aaa ="<tr name='selectedTr' ><td><input type='checkbox' id='chkQrySub"+i+"' name='chkQrySub' value='' v_row='"+i+"' checked /></td>";
                   allListSimple = allList[i].split("|");
                   for(var j=0;j<allListSimple.length;j++){
                     aaa = aaa +"<td>"+allListSimple[j]+"</td>";
                   }
                   aaa =aaa+"<td><input type='button' class='b_foot' id='detailBtn"+i+"' name='detailBtn' v_rowDetail='"+i+"' value='详细信息' onclick='showDetailInfo(this)' /></td></tr>";
                   $("#terminal").append(aaa);
                 }
                 seleNum = seleNum+1;
               }else{
                 rdShowMessageDialog("没有相匹配的内容！",1);
                 return false;
               }
             }
        	
            function reSetTab(){
              window.location.href="fg366_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
            }
            
            function subInfo(btn){
              /* 按钮延迟 */
		    			controlButt(btn);
		    			/* 事后提醒 */
		    			getAfterPrompt();
		    			
		    			//if(!check(frm)) return false;
		    			if(!checkElement(document.all.limitPrompt)) return false;
		    			
		    			var offerIdStr=""; 
		    			$('input[name="chkQrySub"]:checked').each(function(){ 
		    			  var qryRow = $(this).attr("v_row");//行数
		    			  offerIdStr = offerIdStr + $("#terminal tr:eq("+qryRow+") td:eq(1)").text()+"|";
		    			});
		    			var orderMainOffer = $("#orderMainOffer").val();//预约主资费
              var operateLimit = $("#operateLimit").val();//办理限制
              var limitCode = "<%=limitCodeStr%>";//限制编码
              var limitPrompt = $("#limitPrompt").val();//限制提示语
              
		    			if(offerIdStr.length==0){
		    			  rdShowMessageDialog("请选择需要营销限制配置的内容！");
                return false;
		    			}
              
              var packet = new AJAXPacket("fg366_ajax_subInfo.jsp","正在获得数据，请稍候......");
            	packet.data.add("offerIdStr",offerIdStr);
            	packet.data.add("orderMainOffer",orderMainOffer);
            	packet.data.add("operateLimit",operateLimit);
            	packet.data.add("limitCode",limitCode);
            	packet.data.add("limitPrompt",limitPrompt);
            	packet.data.add("opCode","<%=opCode%>");
            	core.ajax.sendPacket(packet,doSubInfo);
            	packet = null;
            }
            
            function doSubInfo(packet){
              var retcode_subInfo = packet.data.findValueByName("retcode_subInfo");
              var retmsg_subInfo = packet.data.findValueByName("retmsg_subInfo");
              if(retcode_subInfo == "000000"){
                rdShowMessageDialog("提交成功！",2);        
                reSetTab();
              }else{
                rdShowMessageDialog("错误代码：" + retcode_subInfo + "，错误信息：" + retmsg_subInfo,0);
                reSetTab();
              }
            }
            
            function showDetailInfo(obj){
              var rowDetail = obj.v_rowDetail;//行数
		    			var offerId = $("#terminal tr:eq("+rowDetail+") td:eq(1)").text();
	    				window.open (
          			'showDetailInfo.jsp?offerId='+offerId , 
          			"newwindow",
          			'dialogHeight:300px; dialogWidth:50px;scrollbars:yes;resizable:no;location:no;status:no'
          		);
            }

        </script>
    </head>
    <body>
        <form name="frm" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
         	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">输入查询条件</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <TD class=blue>资费代码</TD>
                    <TD>
                        <input type="text" name="chargeNo"  id="chargeNo"  value=""  />
                    </TD>
                    <td class="blue">资费名称</td>
                    <td>
                        <input type="text" id="chargeName" name="chargeName"   value="" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="qryBtn" name="qryBtn" class="b_foot" value="查询" onClick="query(this)" />   
                        <input type="button" id="reSetBtn"  name="reSetBtn"  class="b_foot" value="重置" onClick="reSetTab();" /> 
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
           <div id="intablediv" style="display:none;">
             <div id="Main" >
          		<div id="Operation_Table">
          			<div class="title">
          				<div id="title_zi">营销限制配置列表</div>
          			</div>
          			<table cellspacing="0" name="t1" id="t1">
          				<tr>
          				  <TD ></TD>
          					<TD >资费代码</TD>
                    <TD >资费名称</TD>
                    <TD >开始时间</TD>
                    <TD >结束时间</TD>
                    <TD >资费发布的地市、资费权限</TD>
          				</tr>
          				<tbody id="terminal"></tbody>
          			</table>
            	</div>
            </div>
          </div>
          <div id="offerInfodiv" style="display:none;">
            <table cellspacing="0">
                  <tr>
                      <TD class=blue>是否包含预约主资费</TD>
                      <TD>
                          <select align="left" name="orderMainOffer" id="orderMainOffer" width=50>
                            <option value="1">否</option>
                            <option value="2">是</option>
                          </select>
                      </TD>
                      <td class="blue">办理限制</td>
                      <td>
                          <select align="left" name="operateLimit" id="operateLimit" width=50>
                            <option value="0">允许办理</option>
                            <option value="1">不允许办理</option>
                          </select>
                      </td>
                  </tr>
                  <tr>
                      <TD class=blue>限制编码</TD>
                      <TD>
                          <input type="text" name="limitCode"  id="limitCode"  value="C<%=limitCodeStr%>" class="InputGrey" readonly />
                      </TD>
                      <td class="blue">限制提示语</td>
                      <td>
                          <input type="text" id="limitPrompt" name="limitPrompt" size="60" maxlength="50"  v_type="string" v_must="1"  value="" />
                          <font class="orange">*</font>
                          (最多输入50个字)
                      </td>
                  </tr>
                  <tr>
                      <td colspan="4" align="center" id="footer">
                          <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="确认" onClick="subInfo(this)" />   
                          <input type="button" id="reSetBtn"  name="reSetBtn"  class="b_foot" value="重置" onClick="reSetTab();" /> 
                          <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                      </td>
                  </tr>
              </table>
            </div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>