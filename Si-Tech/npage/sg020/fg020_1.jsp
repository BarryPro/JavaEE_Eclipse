<%
/*************************************
* 功  能: 应用软件下载安装
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: liujian @ 2012-08-13
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode     =  request.getParameter("opCode");
    String opName     =  request.getParameter("opName");
	String powerRight = (String)session.getAttribute("powerRight");	
    String workNo     = (String)session.getAttribute("workNo");//操作工号
    String regionCode = (String)session.getAttribute("regCode");

    String[][] result33 = null;
    String dateStr1SqlStr33 = new java.text.SimpleDateFormat("yyyy-MM-dd-HH-mm").format(new java.util.Date());//diling add 增加分
    String strTime[] = new String[5];
    strTime = dateStr1SqlStr33.split("-");
    StringBuffer sqlBufSqlStr33 = new StringBuffer();
    StringBuffer sb = new StringBuffer("");
	try{
		sqlBufSqlStr33.append( " select a.offer_id,a.offer_id||'-->'||a.offer_name from product_offer a ,region d,sregioncode e where a.offer_id != 0  and a.offer_attr_type='VpZ0' and a.offer_id=d.offer_id and d.group_id=e.group_id and e.region_code='"+regionCode+"' and a.exp_date>=sysdate ");
		sqlBufSqlStr33.append( "  and a.eff_date<=sysdate  ");
		sqlBufSqlStr33.append( "  and ( to_number(d.right_limit)<="+powerRight+")  ");
		sqlBufSqlStr33.append( "  and (  ");
		sqlBufSqlStr33.append( "  exists (select 1 from svpmnfeeindexconfig b  where ( to_number('"+strTime[0]+"')>=to_number(b.start_year) or (b.start_year is null))  ");
		sqlBufSqlStr33.append( "  and ( to_number('"+strTime[0]+"')<=to_number(b.end_year) or (b.end_year is null))  ");
		sqlBufSqlStr33.append( "  and ( to_number('"+strTime[1]+"')>=to_number(b.start_month) or (b.start_month is null))  ");
		sqlBufSqlStr33.append( "  and ( to_number('"+strTime[1]+"')<=to_number(b.end_month) or (b.end_month is null))  ");
		sqlBufSqlStr33.append( "  and ( to_number('"+strTime[2]+"')>=to_number(b.start_day) or (b.start_day is null))  ");
		sqlBufSqlStr33.append( "  and ( to_number('"+strTime[2]+"')<=to_number(b.end_day) or (b.end_day is null))  ");
		sqlBufSqlStr33.append( "  and ( to_number('"+strTime[3]+"')>=to_number(b.start_hours) or (b.start_hours is null))  ");
		sqlBufSqlStr33.append( "  and ( to_number('"+strTime[3]+"')<=to_number(b.end_hours) or (b.end_hours is null))  ");
		sqlBufSqlStr33.append( "  and ( to_number('"+strTime[4]+"')>=to_number(b.start_minute) or (b.start_minute is null) ) ");
		sqlBufSqlStr33.append( "  and ( to_number('"+strTime[4]+"')<to_number(b.end_minute) or (b.end_minute is null) ) ");
		sqlBufSqlStr33.append( "  and a.offer_id = b.feeindex and b.region_code = e.region_code ) ");
		sqlBufSqlStr33.append( "  or not exists (select 1 from svpmnfeeindexconfig f where a.offer_id = f.feeindex and f.region_code  = e.region_code ) ");
		sqlBufSqlStr33.append( "  )order by a.offer_id ");
		String sqlStr33 = sqlBufSqlStr33.toString();
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:sql><%=sqlStr33%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result_tu7" scope="end"/>

<%
        result33 = result_tu7;
        int recordNum = result33.length;
        for(int xCoTt=0;xCoTt<recordNum;xCoTt++){
        	sb.append("<option name='opt' value='" + result33[xCoTt][0] + "'>" + result33[xCoTt][1] + "</option>");
        }
    }catch(Exception e){
       System.out.println("资费sql查询失败");
    }
    
    
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<script type=text/javascript>
   
	$(function() {
		$('#searchBtn').click(function(){
			//必须输入一项
			var idiccId = $.trim($('#idiccId').val());
			var custId = $.trim($('#custId').val());
			var unitId = $.trim($('#unitId').val());
			var serviceNo = $.trim($('#serviceNo').val());			
			if(idiccId == '' && custId == '' && unitId == '' && serviceNo == ''){
				rdShowMessageDialog("至少输入一项查询条件！");
				return false;
			}	
			
			var packet = new AJAXPacket("fg020_2.jsp","正在获得相关信息，请稍候......");
			var _data = packet.data;
			_data.add("method","getBaseInfo");
			_data.add("idiccId",idiccId);
			_data.add("custId",custId);
			_data.add("unitId",unitId);
			_data.add("serviceNo",serviceNo);
			_data.add("opCode",'<%=opCode%>');
			core.ajax.sendPacket(packet,doGetInfoProcess);
			packet = null;
		});
		$('#clearBtn').click(function(){
			$('#idiccId').val('');
			$('#custId').val('');
			$('#unitId').val('');
			$('#serviceNo').val('');
			$('#baseInfoDiv').css('display','none');
			$('#typeDiv').css('display','none');
		});
		$('#submitBtn').click(function(){
			var packet = new AJAXPacket("fg020_2.jsp","正在获得相关信息，请稍候......");
			var _data = packet.data;
			_data.add("method","submit");
			_data.add("idNo",$('#oIdNo').val());
			var type = $('input:radio[name="radio"]:checked').val();
			_data.add("oprType",type);
			var offerVal = $('#offerSel').val();
			if(type == '1') {
				_data.add("offerId",offerVal);	
				_data.add("offerIdNew","");
			}else if(type == '2') {
				_data.add("offerId",$('#oVpZ0OfferId').val());	
				_data.add("offerIdNew",offerVal);	
			}else if(type == '3') {
				_data.add("offerId",$('#oVpZ0OfferId').val());	
				_data.add("offerIdNew","");		
			}
			_data.add("opCode",'<%=opCode%>');
			core.ajax.sendPacket(packet,doSubmitProcess);
			packet = null;	
		});
		
		$('#addRadio').click(function() {
			$('#offerTr').css('display','block');
		});
		$('#editRadio').click(function() {
			$('#offerTr').css('display','block');
		});
		$('#deleteRadio').click(function() {
			$('#offerTr').css('display','none');
		});
	});
	
	function doGetInfoProcess(package) {
		var retCode = package.data.findValueByName("retcode");
		var retMsg = package.data.findValueByName("retmsg");
		
		if(retCode == "000000") {
			$('#oIdiccId').val(package.data.findValueByName("oIdiccId"));
			$('#oCustId').val(package.data.findValueByName("oCustId"));
			$('#oUnitId').val(package.data.findValueByName("oUnitId"));
			$('#oUnitName').val(package.data.findValueByName("oUnitName"));
			$('#oServiceNo').val(package.data.findValueByName("oServiceNo"));
			$('#oIdNo').val(package.data.findValueByName("oIdNo"));
			$('#oProductCode').val(package.data.findValueByName("oProductCode"));
			$('#oProductName').val(package.data.findValueByName("oProductName"));
			$('#oAccountId').val(package.data.findValueByName("oAccountId"));
			$('#oZhwwFlag').val(package.data.findValueByName("oZhwwFlag")=='Y' ? '是':'否');
			var offerId = package.data.findValueByName("oVpZ0OfferId");
			$('#oVpZ0OfferId').val(offerId);
			if(package.data.findValueByName("oZhwwFlag")=='Y'){
				//offerId为空设置为新增
				if(!offerId) {
					$('#offerSel').empty();
					$('#offerSel').append("<%=sb.toString()%>");
					$('#addRadio').attr("checked",true);
					//修改和删除不允许点击
					$('#editRadio').attr("disabled",true);
					$('#deleteRadio').attr("disabled",true);
					$('#offerTr').css('display','block');	
				}else {
					//设置为修改，除去自身的offerId
					$('#offerSel').empty();
					$('#offerSel').append("<%=sb.toString()%>");
					$('#addRadio').attr("disabled",true);
					$("select option[value='" + offerId + "']").attr('disabled','disabled');
					$('#editRadio').attr("checked",true);
					$('#offerTr').css('display','block');		
				}
				$('#baseInfoDiv').css('display','block');	
				$('#typeDiv').css('display','block');	
			}else {
				$('#baseInfoDiv').css('display','block');	
				rdShowMessageDialog("非综合v网的集团不可以受理该模块");	
			}
			
		}else {
			rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
			return false;
		}
	}
	
	function doSubmitProcess(package) {
		var retCode = package.data.findValueByName("retcode");
		var retMsg = package.data.findValueByName("retmsg");
		
		if(retCode == "000000") {
			rdShowMessageDialog("提交成功！");
			location = window.location.href;
			
			return true;
		}else {
			rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
			return false;
		}
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
				<td class='blue'>证件号码</td>
				<td >
					<input type="text" name="idiccId" id="idiccId" value="" />
				</td>
				<td class='blue'>客户ID</td>
				<td>
					<input type="text" name="custId" id="custId" value="" />
				</td>
		    </tr>
		    <tr>
				<td class='blue'>集团编码</td>
				<td >
					<input type="text" name="unitId" id="unitId" value="" />
				</td>
				<td class='blue'>智能网编码</td>
				<td>
					<input type="text" name="serviceNo" id="serviceNo" value="" />
				</td>
		    </tr>
		    <tr id='footer'>
		        <td colspan='4'>
		            <input type="button"  id="searchBtn" class='b_foot' value="查询" name="search" />
		            <input type="button"  id="clearBtn" class='b_foot' value="清除" name="clear" />
		            <input type="button" class="b_foot" id="close" name="close" value="关闭" onclick="removeCurrentTab()"/>
		        </td>
		    </tr>	
		</table>
		
		<div  id="baseInfoDiv" style="display:none">
			<div class="title" style="margin-top:10px">
        		<div id="title_zi">基础信息</div>
        	</div>
			<table >
				<tr>
					<td class='blue'>证件号码</td>
					<td >
						<input type="text" name="oIdiccId" id="oIdiccId" value="" class="InputGrey" readonly/>
					</td>
					<td class='blue'>客户ID</td>
					<td>
						<input type="text" name="oCustId" id="oCustId" value="" class="InputGrey" readonly/>
					</td>
			    </tr>
			    <tr>
					<td class='blue'>集团编码</td>
					<td >
						<input type="text" name="oUnitId" id="oUnitId" value="" class="InputGrey" readonly/>
					</td>
					<td class='blue'>集团名称</td>
					<td>
						<input type="text" name="oUnitName" id="oUnitName" value="" class="InputGrey" readonly/>
					</td>
			    </tr>
			    <tr>
					<td class='blue'>智能网编码</td>
					<td >
						<input type="text" name="oServiceNo" id="oServiceNo" value="" class="InputGrey" readonly/>
					</td>
					<td class='blue'>产品id</td>
					<td>
						<input type="text" name="oIdNo" id="oIdNo" value="" class="InputGrey" readonly/>
					</td>
			    </tr>
			    <tr>
					<td class='blue'>产品代码</td>
					<td >
						<input type="text" name="oProductCode" id="oProductCode" value="" class="InputGrey" readonly/>
					</td>
					<td class='blue'>产品名称</td>
					<td>
						<input type="text" name="oProductName" id="oProductName" value="" class="InputGrey" readonly/>
					</td>
			    </tr>
			    <tr>
					<td class='blue'>产品账户id</td>
					<td >
						<input type="text" name="oAccountId" id="oAccountId" value="" class="InputGrey" readonly/>
					</td>
					<td class='blue'>是否为综合V网</td>
					<td>
						<input type="text" name="oZhwwFlag" id="oZhwwFlag" value="" class="InputGrey" readonly/>
					</td>
			    </tr>
			    <tr>
					<td class='blue'>综合v网资费代码</td>
					<td colspan="3">
						<input type="text" name="oVpZ0OfferId" id="oVpZ0OfferId" value="" class="InputGrey" readonly/>
					</td>
			    </tr>
			</table>
		</table>
		<div id="typeDiv" style="display:none">
			<div class="title">
        		<div id="title_zi">请选择操作类型</div>
        	</div>
			<table>
				<tr>
					<td  class='blue'>操作类型</td>
					<td>
						<input type="radio" name="radio" id="addRadio"  value="1" />新增&nbsp;
						<input type="radio" name="radio" id="editRadio"  value="2" />修改&nbsp;
						<input type="radio" name="radio" id="deleteRadio"  value="3" />删除&nbsp;
					</td>
				</tr>
				<tr id="offerTr" style="display:none">
					<td  class='blue'>综合v网资费</td>
					<td>
						<select id="offerSel"></select>
					</td>
				</tr>
			</table>
			<table>
		</div>
		
			<tr id='footer'>
		        <td colspan='4'>
		            <input type="button"  id="submitBtn" class='b_foot' value="确定" name="submit" />
		            <input type="button" class="b_foot" id="close" name="close" value="关闭" onclick="removeCurrentTab()"/>
		        </td>
		    </tr>	
			
				
				
			
		</div>
					
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>