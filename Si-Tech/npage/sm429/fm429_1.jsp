<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)[2016/11/8 20:27:33]------------------
 关于国际漫游业务流程优化业务支撑系统改造的通知
 
 -------------------------后台人员：[jianglei]--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");

	String custName = "";
	String pp_name  = "";
	String id_type  = "";
	String id_iccid = "";
	
	/*
          查询客户信息公共服务
  */
   String paraAray[] = new String[9];
   paraAray[0] = "";
   paraAray[1] = "01";
   paraAray[2] = opCode;
   paraAray[3] = workNo;
   paraAray[4] = password;
   paraAray[5] = activePhone;
   paraAray[6] = "";
   paraAray[7] = "";
   paraAray[8] = "通过phoneNo[" + activePhone + "]查询客户信息";
%>


	
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="40" >
      <wtc:param value="<%=paraAray[0]%>"/>
      <wtc:param value="<%=paraAray[1]%>"/>
      <wtc:param value="<%=paraAray[2]%>"/>
      <wtc:param value="<%=paraAray[3]%>"/>
      <wtc:param value="<%=paraAray[4]%>"/>
      <wtc:param value="<%=paraAray[5]%>"/>
      <wtc:param value="<%=paraAray[6]%>"/>
      <wtc:param value="<%=paraAray[7]%>"/>
      <wtc:param value="<%=paraAray[8]%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
<wtc:array id="result_t2" scope="end" />

<%

 

String custBrandName = "";
        if("000000".equals(retCode2)){
            if(result_t2.length>0){
                    custName = result_t2[0][5];
                    pp_name  = result_t2[0][38];
                    id_type  = result_t2[0][12];
                    id_iccid = result_t2[0][13];
                    
              if (pp_name.equals("gn")) {
								custBrandName = "全球通";
							} else if (pp_name.equals("zn")) {
								custBrandName = "神州行";
							} else if (pp_name.equals("dn")) {
								custBrandName = "动感地带";
							} 
							
            }
        }else{
%>
            <script language="JavaScript">
                    rdShowMessageDialog("该用户不是在网用户或状态不正常！");
                    removeCurrentTab();
            </script>
<%              
        }
        

String  offer_info_sql = "select a.ProId,a.Fee ,b.offer_name from DBCUSTADM.SGPRSMODE a ,product_offer b where a.offer_id=b.offer_id  and a.offer_id!='58137'  and a.offer_id!='58136' order by b.offer_name  ";
System.out.println("-------hejwa--------------offer_info_sql----------->"+offer_info_sql);

String  quit_offer_sql = " select a.prodid, a.prodinstid, b.offer_name  "+
												 " 	  from dbcustadm.dGPRSMsg a, DBCUSTADM.SGPRSMODE c, product_offer b  "+
												 " 	 where a.prodid = c.proid  "+
												 " 	   and c.offer_id = b.offer_id  and a.prodtype = '01'  and a.expiretime > to_char(sysdate, 'yyyymmddhh24miss')"+
												 " 	   and a.phone_no = :phone_no  and b.offer_id!='58136'";

System.out.println("-------hejwa--------------quit_offer_sql----------->"+quit_offer_sql);
												 
String  query_offer_sql = " select a.prodid, a.prodinstid, b.offer_name  "+
												 " 	  from dbcustadm.dGPRSMsg a, DBCUSTADM.SGPRSMODE c, product_offer b  "+
												 " 	 where a.prodid = c.proid  "+
												 " 	   and c.offer_id = b.offer_id  "+
												 " 	   and a.phone_no = :phone_no  and b.offer_id!='58136'";
												 
												 												 
String  quit_offer_prm = "phone_no="+activePhone;
%>   	


  <wtc:service name="TlsPubSelCrm" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=offer_info_sql%>" />
	</wtc:service>
	<wtc:array id="result_Offer" scope="end" />
		
  <wtc:service name="TlsPubSelCrm" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=quit_offer_sql%>" />
		<wtc:param value="<%=quit_offer_prm%>" />	
	</wtc:service>
	<wtc:array id="result_QuitOffer" scope="end" />		
		
  <wtc:service name="TlsPubSelCrm" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=query_offer_sql%>" />
		<wtc:param value="<%=quit_offer_prm%>" />	
	</wtc:service>
	<wtc:array id="result_QueryOffer" scope="end" />				
		
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>

//手机号码
var COM_OPCODE = "";


//重置刷新页面
function reSetThis(){
	  location = location;	
}


//
function go_Query(){
	if($("#sel_q_accept").val()==""){
		rdShowMessageDialog("请选择查询流水");
		return;
	}
	
 	var pactket = new AJAXPacket("fm429_Query.jsp","正在进行查询，请稍候......");
			pactket.data.add("opCode","m431");
			pactket.data.add("phoneNo","<%=activePhone%>");
			pactket.data.add("sel_q_accept",$("#sel_q_accept").val());
			core.ajax.sendPacket(pactket,do_Query);
			pactket=null;
}
// 回调
function do_Query(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";

/*			
8	MSISDN			1	String	V32		手机号码				移动用户终端号码，不带“+86”的手机号码。
9	UserType		1	String	F2		用户类型				00 – 个人用户01 – 集团用户
10	GroupName		？	String	V256	集团名称				UserType为01时填写，可使用汉字填写
11	ProvCode		1	String	F3		省代码					用户归属省代码见附录省代码表
12	oprTIMSI		1	String	F14		订购关系查询处理时间	订购关系查询处理时间格式如：YYYYMMDDHHmmSS
13	ProdInstID		1	String	V32		产品订购流水号			用户订购产品会生成一个唯一的订购流水号
14	ProdID			1	String	V32		产品ID					产品ID
15	ProdType		1	String	F2		产品类型				00 – 一次性产品 01 – 功能性产品
16	ProdStat		?	String	F2		产品状态				00 – 未激活，未过期01 – 未激活，已过期02 – 已激活，正在使用03 – 已激活，使用完毕04 – 已退订05 – 已销户退订
17	Efftime			1	String	V32		订购生效时间			产品成功订购的时间格式如：YYYYMMDDHHmmSS
18	expireTIMSI		1	String	F14		订购过期时间			用户必须在订购过期时间前使用格式如：YYYYMMDDHHmmSS
19	Activetime		？	String	F14		产品激活时间			ProdType产品类型取值为01时不填写用户首次使用的时间，新增用户订购信息时没有该时间的。格式如：YYYYMMDDHHmmSS
20	Deadlinetime	？	String	F14		产品失效时间			ProdType产品类型取值为01时不填写产品资源使用完毕的时间格式如：YYYYMMDDHHmmSS
21	feeaccessMod	1	String	V256	订购渠道				订购渠道，由国漫集中节点使用汉字或者英文填写如：短信等；
*/
			
			for(var i=0;i<retArray.length;i++){
					var j_UserType = "未知";
					if(retArray[i][9].trim()=="00"){
						j_UserType = "个人用户";
					}
					if(retArray[i][9].trim()=="01"){
						j_UserType = "集团用户";
					}
					
					var j_ProdType = "未知";
					if(retArray[i][15].trim()=="00"){
						j_ProdType = "一次性产品";
					}
					if(retArray[i][15].trim()=="01"){
						j_ProdType = "功能性产品";
					}
					
					var j_ProdStat = "未知";
					if(retArray[i][16].trim()=="00"){
						j_ProdStat = "未激活，未过期";
					}
					if(retArray[i][16].trim()=="01"){
						j_ProdStat = "未激活，已过期";
					}
					if(retArray[i][16].trim()=="02"){
						j_ProdStat = "已激活，正在使用";
					}
					if(retArray[i][16].trim()=="03"){
						j_ProdStat = "已激活，使用完毕";
					}
					if(retArray[i][16].trim()=="04"){
						j_ProdStat = "已退订";
					}
					if(retArray[i][16].trim()=="05"){
						j_ProdStat = "已销户退订";
					}
					
				  //如果有一条空记录不展示，服务返回数据为空字符串，服务改进后此逻辑可删除
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][8]+"</td>"+ //
														 "<td>"+j_UserType+"</td>"+ //
														 "<td>"+retArray[i][10]+"</td>"+ //
														 "<td>"+retArray[i][11]+"</td>"+//
														 "<td>"+retArray[i][12]+"</td>"+//
														 "<td style='word-break:break-all'>"+retArray[i][13]+"</td>"+//
														 "<td style='word-break:break-all'>"+retArray[i][14]+"</td>"+//
														 "<td>"+j_ProdType+"</td>"+//
														 "<td>"+j_ProdStat+"</td>"+//
														 "<td>"+retArray[i][17]+"</td>"+//
														 "<td>"+retArray[i][18]+"</td>"+//
														 "<td>"+retArray[i][19]+"</td>"+//
														 "<td>"+retArray[i][20]+"</td>"+//
														 "<td>"+retArray[i][21]+"</td>"+//
												 "</tr>";
			}
			//将拼接的行动态添加到table中
			$("#div_show_result").show();
			$("#tab_show_result tr:gt(0)").remove();
			$("#tab_show_result tr:eq(0)").after(trObjdStr);
			
	}else{
			$("#div_show_result").hide();
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}


//
function go_Cfm(opcode,opTypeCode){

	var j_prodId = "";
	if($("#sel_optype").val()=="m429"){
		if($("#sel_prodId").val()==""){
			rdShowMessageDialog("请选择订购资费");
			return;
		}
		j_prodId = $("#sel_prodId").val();
	}else if($("#sel_optype").val()=="m430"){
		if($("#sel_q_prodId").val()==""){
			rdShowMessageDialog("请选择退订资费");
			return;
		}
		alert("888888");
		j_prodId = $("#sel_q_prodId").val();
	}else{
		go_Query();
		return;
	}
	
	
 	var pactket = new AJAXPacket("fm429_Cfm.jsp","正在进行查询，请稍候......");
 			pactket.data.add("opTypeCode",$("#sel_optype").find("option:selected").attr("v_opTypeCode"));
			pactket.data.add("opCode",$("#sel_optype").val());
			pactket.data.add("phoneNo","<%=activePhone%>");
			pactket.data.add("prodId",j_prodId);
			
			core.ajax.sendPacket(pactket,do_Cfm);
			pactket=null;
}
// 回调
function do_Cfm(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//
		rdShowMessageDialog("预办理操作成功",2);
		reSetThis();
	}else{
		rdShowMessageDialog("预办理操作失败，"+code+"："+msg,0);
	}
}


function set_offer_show(){
	$("#div_show_result").hide();
	
	if($("#sel_optype").val()=="m429"){
		$("#tr_show1").show();
		$("#tr_show2").hide();
		$("#tr_show3").hide();
	}  
	
	if($("#sel_optype").val()=="m430"){
		$("#tr_show1").hide();
		$("#tr_show2").show();
		$("#tr_show3").hide();
	}
	
	if($("#sel_optype").val()=="m431"){
		$("#tr_show1").hide();
		$("#tr_show2").hide();
		$("#tr_show3").show();
	}
	
}


$(document).ready(function(){
	$("#sel_optype").val("<%=opCode%>");
	set_offer_show();
});

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
			<td class="blue" width="15%">操作类型</td>
	    <td class="blue" colspan="3">
	    	<select id="sel_optype" name="sel_optype" onchange="set_offer_show()">
				    <option v_opTypeCode="01" value="m429" selected >订购</option>
				    <option v_opTypeCode="02" value="m430">退订</option>
				    <option v_opTypeCode="03" value="m431">查询</option>
				</select>
	    </td>
	</tr>
		
	<tr>
	    <td class="blue" width="15%">手机号码</td>
		  <td width="35%">
			    <%=activePhone%>
		  </td>
		  <td class="blue" width="15%">客户姓名</td>
		  <td>
			    <%=custName%>
		  </td>
	</tr>
	<tr id="tr_show1">
	    <td class="blue">订购资费</td>
		  <td colspan="3">
		  	<select id="sel_prodId" name="sel_prodId" style="width:400px">
				    <option value="">--请选择--</option>
				    <%
				    for(int i=0;i<result_Offer.length;i++){
				    %>
				    		<option value="<%=result_Offer[i][0]%>"><%=result_Offer[i][2]%>-><%=result_Offer[i][1]%>元</option>
				    <%	
				   	}
				    %>
				</select>
		  </td>
	</tr>
	
	<tr id="tr_show2" style="display:none">
	    <td class="blue">退订资费</td>
		  <td colspan="3">
		  	<select id="sel_q_prodId" name="sel_q_prodId" style="width:400px">
				    <option value="">--请选择--</option>
				    <%
				    for(int i=0;i<result_QuitOffer.length;i++){
				    %>
				    		<option value="<%=result_QuitOffer[i][0]%>"><%=result_QuitOffer[i][2]%></option>
				    <%	
				   	}
				    %>
				</select>
		  </td>
	</tr>

	
	<tr id="tr_show3" style="display:none">
	    <td class="blue">查询流水</td>
		  <td colspan="3">
		  	<select id="sel_q_accept" name="sel_q_accept" style="width:400px">
				    <option value="">--请选择--</option>
				    <%
				    for(int i=0;i<result_QueryOffer.length;i++){
				    %>
				    		<option value="<%=result_QueryOffer[i][1]%>" ><%=result_QueryOffer[i][1]%>--><%=result_QueryOffer[i][2]%></option>
				    <%	
				   	}
				    %>
				</select>
		  </td>
	</tr>

</table>


<div id="div_show_result" style="display:none">
<div class="title"><div id="title_zi">查询结果列表</div></div>
<TABLE cellSpacing="0" id="tab_show_result">
    <tr>
				<th>手机号码</th>
				<th>用户类型</th>
				<th>集团名称</th>
				<th>省代码</th>
				<th>订购关系查询处理时间</th>
				<th>产品订购流水号</th>
				<th>产品ID</th>
				<th>产品类型</th>
				<th>产品状态</th>
				<th>订购生效时间</th>
				<th>订购过期时间</th>
				<th>产品激活时间</th>
				<th>产品失效时间</th>
				<th>订购渠道</th>
    </tr>
</table>
</div>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="go_Cfm()"            />
	 	</td>
	</tr>
</table>


<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>