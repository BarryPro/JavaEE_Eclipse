<%
/*************************************
* 功  能: 自有业务查询 e827
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: liujian @ 2012-05-03
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%!
    public int getLength(String a){
        int c = 0;
        for (int i = 0; i < a.length(); i ++) {
            char b = a.charAt(i);
            if (b == '|'){
                c ++;
            }
        }
        return c + 1; 
    }
%>

<%
	response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
	
	String opCode     =  request.getParameter("opCode");
  String opName     =  request.getParameter("opName");
  String workNo     = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
  String op_strong_pwd = (String) session.getAttribute("password");
  String phoneNo = request.getParameter("phoneNo");
  String busiType = request.getParameter("busiType");
  String oprType = request.getParameter("oprType");
  String infoStr   = request.getParameter("infoStr");
	String provCode = "451";
	//设置一些变量
	String[][] tempArr = new String[][]{};
	String[] records =  null;
	String[] tds = null;
	String rstStr = "";
	String recordCount = "";//总记录数
	String pageCount = "";//总页数
	String lines_one_page = "";//一页多少行
	String toPage = "1";//跳转到哪页
	String currPage ="";//当前页
	String currCount = "";//当前页记录数
	StringBuffer sb = new StringBuffer("");
	String dateStr =  new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String oprStatus = "";
	String sbStr = "";
	String[] inputParams = new String[14];
	inputParams[0] = "";
	inputParams[1] = "01";
	inputParams[2] = opCode;
	inputParams[3] = workNo;
	inputParams[4] = op_strong_pwd;
	inputParams[5] = phoneNo;
	inputParams[6] = "";
	inputParams[7] = dateStr;
	inputParams[8] = busiType;
	if(busiType != null) {
		if(busiType.equals("42")) {      //手机阅读42
			inputParams[12] = "01030303";
		}else if(busiType.equals("57")) {//手机游戏57
			inputParams[12] = "01030302";
		}else if(busiType.equals("64")) {//手机支付64
			inputParams[12] = "01030301";
		}else if(busiType.equals("72")) {//无线音乐72
			inputParams[12] = "01030305";
		}else if(busiType.equals("82")) {//手机视频82
			inputParams[12] = "01030304";
		}else if(busiType.equals("40")) {//手机电视40 
			inputParams[12] = "01030306";  //TODO
		}
	}
	inputParams[9] = "01"+oprType;
	inputParams[10] = infoStr;
	
%>
	
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
	<%
		//System.out.println("---liujian------e827--------loginAccept=" + loginAccept);
		String tempAccept = loginAccept.substring(5);
		inputParams[0] = loginAccept;
		inputParams[11] = dateStr2 + "CSVC" + provCode + tempAccept;
		oprStatus = inputParams[11];
		inputParams[13] = provCode;//省代码
		for(int i=0;i<inputParams.length;i++) {
			System.out.println("----------liujian--se827Qry---inputParams[" + i + "]=" + inputParams[i]);
		}
		//zhouby 开始调用服务
	%>		
	<wtc:service name="sE827Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCodeQry" retmsg="retMsgQry" outnum="9">
			<wtc:param value="<%=inputParams[0]%>"/>
			<wtc:param value="<%=inputParams[1]%>"/>
			<wtc:param value="<%=inputParams[2]%>"/>
			<wtc:param value="<%=inputParams[3]%>"/>
			<wtc:param value="<%=inputParams[4]%>"/>
			<wtc:param value="<%=inputParams[5]%>"/>
			<wtc:param value="<%=inputParams[6]%>"/>
			<wtc:param value="<%=inputParams[7]%>"/>
			<wtc:param value="<%=inputParams[8]%>"/>
			<wtc:param value="<%=inputParams[9]%>"/>
			<wtc:param value="<%=inputParams[10]%>"/>
			<wtc:param value="<%=inputParams[11]%>"/>
			<wtc:param value="<%=inputParams[12]%>"/>
			<wtc:param value="<%=inputParams[13]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
/*
	System.out.println("-------liujian----------test-----");
		
			1|1111|111|111[REC_SPLIT]2|2222|222|222
		    3|3333|333|333[REC_SPLIT]4|4444|444|444
		    5|5555|555|555[REC_SPLIT]6|6666|666|666
		    7|7777|777|777[REC_SPLIT]8|8888|888|888
		    9|9999|999|999[REC_SPLIT]10|10101010|101010|101010
		    11|11111111|111111|111111[REC_SPLIT]12|12121212|121212|121212
		    13|13131313|131313|131313[REC_SPLIT]14|14141414|141414|141414
		    15|15151515|151515|151515[REC_SPLIT]16|16161616|161616|161616
		    17|17171717|171717|171717[REC_SPLIT]18|18181818|181818|181818
		    19|19191919|191919|191919[REC_SPLIT]20|20202020|202020|202020
		
		recordCount = "10";
		lines_one_page = "2";
		currCount = "2";
		currPage = "1";
		pageCount = "5";
		rstStr = "1|1111|111|111|1|2|3[REC_SPLIT]2|2222|222|222|3|4|3";
		
		String recordCount = "";//总记录数
		String pageCount = "";//总页数
		String lines_one_page = "";//一页多少行
		String toPage = "1";//跳转到哪页
		String currPage ="";//当前页
		String currCount = "";//当前页记录数
		
		*/
		
	/**
		String [][]result1 = new String[1][9];
		result1[0][3] = "10";//总记录数
		result1[0][4] = "10";//一页多少行
		result1[0][5] = "10";//当前页记录数
		result1[0][6] = "1";//当前页记录数
		result1[0][7] = "3";//总页数
		//result1[0][8] = "1|20150527|水电费水电费|111|水电费水电费|1|0|1024|1|2|3|4[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3";
		result1[0][8] = "1|20150527|水电费水电费|111|水电费水电费|1|0|1111111111|1|2|3|4[REC_SPLIT]2|20150527|水电费水电费|111|水电费水电费|1|0|69632|1|2|3|4[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3";
	  String retCodeQry = "000000";
	  String retMsgQry = "000000";
	 */
		//zhouby调用服务结束
		System.out.println("e827===sE827Qry===liujian=======retCodeQry="+retCodeQry);
		System.out.println("e827===sE827Qry===liujian=======retMsgQry="+retMsgQry);
		
		if(retCodeQry.equals("000000")) {
			recordCount = result1[0][3];
			lines_one_page = result1[0][4];
			currCount = result1[0][5];
			currPage = result1[0][6];
			pageCount = result1[0][7];
			rstStr = result1[0][8];
			
			System.out.println("---liujian---recordCount--" + recordCount);
			System.out.println("---liujian---lines_one_page--" + lines_one_page);
			System.out.println("---liujian---currCount--" + currCount);
			System.out.println("---liujian---currPage--" + currPage);
			System.out.println("---liujian---pageCount--" + pageCount);
			System.out.println("---liujian---rstStr--" + rstStr);
			
			if(result1[0][3] != null && "0".equals(result1[0][3])) {
				sb.append("noRec");
				sbStr = sb.toString();
			}
		}
	
%>
            	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
    <script language="javascript" type="text/javascript" src="fe827.js?v=3"></script>
    <script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
    <link href="../query/detail.css" rel="stylesheet" type="text/css"></link>
    <meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="Cache-Control" content="no-cache" />
		<meta http-equiv="expires" content="0" /> 
</head>

<body>
<form name="frm" action="" method="post" >
		<div id="Operation_Table" style="padding-top:0px">
			<table id="tabList" name="tabList" cellspacing=0 style="display:none;">
				<thead id="listHead">
				</thead>
				<tbody id="listBody">
					<%
						if(result1[0][3] != null && !"0".equals(result1[0][3])) {
							records = rstStr.split("\\[REC_SPLIT\\]");
							for(int i=0;i<records.length;i++) {
							  tds = records[i].split("\\|");
							  int length = getLength(records[i]);
							  
								out.print("<tr>");
								for(int j=0;j<tds.length;j++) {
  									out.print("<td>");
  									out.print(tds[j]);
  									out.print("</td>");
								}
								
								int subLength = length - tds.length;
								for (int j = 0; j < subLength; j++){
								    out.print("<td>");
  									out.print("</td>");
								}
								
								out.print("</tr>");
							}
						}
					%>
				</tbody>
			</table>
			<table id="pageTable" style="display:none;">
	      		<tr>	
					<td>
						<div id="page0" style="position:relative;font-size:12px;">
							<!--分页-->
							<table>
								<tr> 
									<td> 共有<span id="pageCountSpan"></span>页，当前页为第<span id="currPageSpan"></span>页 </td>
									<td><span name="firstPage" id="firstPage" class="detail_nohref">【首页】   </span> </td>
									<td><span name="prevPage" id="prevPage" class="detail_nohref">  【上一页】 </span> </td>
									<td><span name="nextPage" id="nextPage" class="detail_href">  【下一页】 </span> </td>
									<td><span name="lastPage" id="lastPage" class="detail_href"> 【尾页】    </span> </td>										 
									<td width="10%">
										<select id="pageSel" name="pageSel" style="width:80px">
										</select>
									</td>	
									<td><span name="toexcels" id="toexcels" class="detail_href"> 【导出Excel】    </span>	</td>	 	 
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</div>
</form>
</body>
</html> 

<script type=text/javascript>
	
	$(function() {
		if('<%=retCodeQry%>' == "000000") {
			/* liujian 添加title 2012-5-7 16:38:24 begin */
			var busiType = '<%=busiType%>';
			var oprType = '<%=oprType%>';
			var titleArr = new Array();
			titleArr.push('<tr>')
			var titleItem = titles['title_' + busiType + '_' + oprType];
			for(var i=0,len=titleItem.length;i<len;i++) {
				titleArr.push('<th>');
				titleArr.push(titleItem[i]);
				titleArr.push('</th>');
			}
			titleArr.push('</tr>');
			$('#listHead').append(titleArr.join(''));
			/* liujian 添加title 2012-5-7 16:38:24 end */
			if("<%=sbStr%>" == 'noRec') {
  				$('#listBody').append("<tr><td colspan='" + titleItem.length+ "'>没有对应记录</td><tr>");
  			}
			//liujian 2012-8-31 16:54:26 返回值对应编码
			var busiType = '<%=busiType%>';
			var oprType = '<%=oprType%>';
			
			$('#listBody').find('tr').each(function() {
				var $this = $(this);
				var tdArr = new Array();
				var arrs = new Array();
				if(busiType=='72' && oprType=='001') {//无线音乐72--黑名单屏蔽日志查询
					tdArr.push($this.find('td:eq(5)'));
					arrs.push(music_001_15_array);

				}else if(busiType=='72' && oprType=='002') {//无线音乐--点播记录查询
					tdArr.push($this.find('td:eq(5)'));
					tdArr.push($this.find('td:eq(8)'));
					tdArr.push($this.find('td:eq(9)'));
					arrs.push(music_002_1_array);
					arrs.push(music_002_3_array);
					arrs.push(music_002_2_array);
					
				}else if(busiType=='72' && oprType=='003') {//无线音乐--会员操作记录查询
					tdArr.push($this.find('td:eq(1)'));
					tdArr.push($this.find('td:eq(2)'));
					tdArr.push($this.find('td:eq(3)'));
					tdArr.push($this.find('td:eq(4)'));
					arrs.push(music_003_1_array);
					arrs.push(music_003_2_array);
					arrs.push(music_003_3_array);
					arrs.push(music_002_3_array);
				}else if(busiType=='72' && oprType=='004') {//无线音乐--包月历史操作记录查询
					tdArr.push($this.find('td:eq(3)'));
					tdArr.push($this.find('td:eq(4)'));
					tdArr.push($this.find('td:eq(5)'));
					arrs.push(music_003_2_array);
					arrs.push(music_003_3_array);
					arrs.push(music_002_3_array);
				}else if(busiType=='72' && oprType=='005') {//无线音乐--单次消费历史记录查询
					tdArr.push($this.find('td:eq(5)'));
					tdArr.push($this.find('td:eq(8)'));
					tdArr.push($this.find('td:eq(9)'));
					tdArr.push($this.find('td:eq(10)'));
					arrs.push(music_002_1_array);
					arrs.push(music_002_2_array);
					arrs.push(music_002_3_array);
					arrs.push(music_004_1_array);
				}else if(busiType=='72' && oprType=='006') {//无线音乐--彩铃订购历史记录查询
					tdArr.push($this.find('td:eq(5)'));
					tdArr.push($this.find('td:eq(6)'));
					arrs.push(music_004_2_array);
					arrs.push(music_002_3_array);
					
				}else if(busiType=='41' && oprType=='001') {
					/*2014/08/05 14:59:26 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
						MobileMarket--MM订购黑名单查询
						返回结果 是否黑名单状态 转义
					*/
					tdArr.push($this.find('td:eq(0)'));
					arrs.push(mm_41_001_001_array);
					tdArr.push($this.find('td:eq(1)'));
					arrs.push(mm_41_001_002_array);
				}else if(busiType=='41' && oprType=='002') {
					/*2014/08/05 14:59:26 gaopeng 关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
						MobileMarket--MM订购黑名单查询
						返回结果 支付方式 定购渠道标识 操作类型标识 订单标识 用户定购的服务类型 转义
					*/
					tdArr.push($this.find('td:eq(0)'));
					arrs.push(mm_41_002_001_array);
					tdArr.push($this.find('td:eq(8)'));
					arrs.push(mm_41_002_002_array);
					tdArr.push($this.find('td:eq(9)'));
					arrs.push(mm_41_002_003_array);
					tdArr.push($this.find('td:eq(11)'));
					arrs.push(mm_41_002_004_array);
					tdArr.push($this.find('td:eq(14)'));
					arrs.push(mm_41_002_005_array);
					tdArr.push($this.find('td:eq(15)'));
					arrs.push(mm_41_002_006_array);
				}else if(busiType=='41' && oprType=='006') {
				 	tdArr.push($this.find('td:eq(2)'));
					arrs.push(mm_41_006_001_array);
					
				}else if(busiType=='41' && oprType=='007') {
				 	tdArr.push($this.find('td:eq(2)'));
					arrs.push(mm_41_006_001_array);
					tdArr.push($this.find('td:eq(4)'));
					arrs.push(mm_41_007_001_array);
				}else if(busiType=='42' && oprType=='001') {//手机阅读42--黑名单查询
					tdArr.push($this.find('td:eq(2)'));
					arrs.push(read_001_1_array);
				}else if(busiType=='42' && oprType=='002') {//手机阅读--阅读记录查询
					tdArr.push($this.find('td:eq(5)'));
					tdArr.push($this.find('td:eq(7)'));
					tdArr.push($this.find('td:eq(8)'));
					arrs.push(read_002_1_array);
					arrs.push(read_002_3_array);//2013/10/22 15:11:28 gaopeng 加入手机阅读的订购方式
					arrs.push(read_002_2_array);
				}else if(busiType=='42' && oprType=='003') {//手机阅读--书籍信息查询
					tdArr.push($this.find('td:eq(4)'));
					tdArr.push($this.find('td:eq(6)'));
					arrs.push(read_003_1_array);
					arrs.push(read_003_2_array);
				}else if(busiType=='42' && oprType=='005') {//手机阅读--包月记录查询
					tdArr.push($this.find('td:eq(8)'));
					tdArr.push($this.find('td:eq(9)'));
					arrs.push(read_005_1_array);
					arrs.push(read_005_2_array);
				}else if(busiType=='42' && oprType=='006') {//手机阅读--书籍信息查询 使用read_002_1_array，read_003_2_array
					tdArr.push($this.find('td:eq(6)'));
					tdArr.push($this.find('td:eq(7)'));
					tdArr.push($this.find('td:eq(8)'));
					tdArr.push($this.find('td:eq(9)'));
					tdArr.push($this.find('td:eq(14)'));
					arrs.push(read_002_1_array);
					arrs.push(read_006_2_array);
					arrs.push(read_003_2_array);
					arrs.push(read_006_1_array);
					arrs.push(read_006_3_array);
				}else if(busiType=='42' && oprType=='007') {//手机阅读--手持绑定关系查询 2013/10/22 15:17:51 gaopeng
					tdArr.push($this.find('td:eq(5)'));
					tdArr.push($this.find('td:eq(7)'));
					tdArr.push($this.find('td:eq(9)'));
					arrs.push(read_007_1_array);
					arrs.push(read_007_2_array);
					arrs.push(read_007_2_array);
				}else if(busiType=='57' && oprType=='001') {//手机游戏57--黑名单查询
					tdArr.push($this.find('td:eq(2)'));
					tdArr.push($this.find('td:eq(3)'));
					tdArr.push($this.find('td:eq(5)'));
					arrs.push(game_001_1_array);
					arrs.push(game_001_2_array);
					arrs.push(game_001_3_array);
				}else if(busiType=='57' && oprType=='002') {//手机游戏57--消费记录查询
					tdArr.push($this.find('td:eq(7)'));
					tdArr.push($this.find('td:eq(13)'));
					arrs.push(game_002_1_array);
					arrs.push(game_002_2_array);
				}else if(busiType=='57' && oprType=='003') {//手机游戏57--套餐订购关系查询
					tdArr.push($this.find('td:eq(7)'));
					tdArr.push($this.find('td:eq(8)'));
					arrs.push(game_003_1_array);
					arrs.push(game_003_2_array);
				}else if(busiType=='57' && oprType=='004') {//手机游戏57--套餐订购记录查询
					tdArr.push($this.find('td:eq(2)'));
					tdArr.push($this.find('td:eq(3)'));
					tdArr.push($this.find('td:eq(4)'));
					arrs.push(game_004_1_array);
					arrs.push(game_004_2_array);
					arrs.push(game_004_3_array);
				}else if(busiType=='57' && oprType=='005') {//手机游戏57--点数充值记录查询 使用game_002_3_array
					tdArr.push($this.find('td:eq(6)'));
					arrs.push(game_002_3_array);
				}else if(busiType=='57' && oprType=='006') {//手机游戏57--点数余额查询 使用game_004_2_array和game_004_3_array
					tdArr.push($this.find('td:eq(1)'));
					tdArr.push($this.find('td:eq(2)'));
					tdArr.push($this.find('td:eq(3)'));
					arrs.push(game_006_1_array);
					arrs.push(game_004_2_array);
					arrs.push(game_004_3_array);
				}else if(busiType=='57' && oprType=='007') {//手机游戏57--业务基本信息查询 使用game_002_1_array 和 game_002_2_array
					tdArr.push($this.find('td:eq(4)'));
					tdArr.push($this.find('td:eq(5)'));
					tdArr.push($this.find('td:eq(6)'));
					tdArr.push($this.find('td:eq(7)'));
					tdArr.push($this.find('td:eq(13)'));
					arrs.push(game_007_1_array);
					arrs.push(game_002_1_array);
					arrs.push(game_002_2_array);
					arrs.push(game_007_11_array);
					arrs.push(game_002_1_array);
				}else if(busiType=='57' && oprType=='008') {//手机游戏57--营销消息屏蔽查询
					tdArr.push($this.find('td:eq(2)'));
					arrs.push(game_008_1_array);
				}else if(busiType=='57' && oprType=='010') {
					/*手机游戏57--灰名单查询 2014/08/05 14:19:29 gaopeng
						关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
						加入灰名单来源转义
					*/
					tdArr.push($this.find('td:eq(2)'));
					arrs.push(game_57_010_01_array);
				}else if(busiType=='57' && oprType=='011') {
					/*手机游戏57--灰名单查询 2014/08/05 14:19:29 gaopeng
						关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
						加入核查结果转义
					*/
					tdArr.push($this.find('td:eq(0)'));
					arrs.push(game_57_011_01_array);
				}else if(busiType=='57' && oprType=='012') {
					/*手机游戏57--灰名单查询 2014/08/05 14:19:29 gaopeng
						关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知
						加入 操作类型 转义
					*/
					tdArr.push($this.find('td:eq(3)'));
					arrs.push(game_57_012_01_array);
				}else if(busiType=='64' && oprType=='002') {//手机支付64 --缴话费交易查询
					tdArr.push($this.find('td:eq(4)'));
					tdArr.push($this.find('td:eq(11)'));
					arrs.push(pay_002_1_array);
					arrs.push(pay_002_6_array);
				}else if(busiType=='64' && oprType=='003') {//手机支付64 --电子券查询
					tdArr.push($this.find('td:eq(11)'));
					arrs.push(pay_002_7_array);
				}else if(busiType=='64' && oprType=='004') {//手机支付64 --用户订单信息列表查询
					tdArr.push($this.find('td:eq(5)'));
					tdArr.push($this.find('td:eq(8)'));
					arrs.push(pay_004_1_array);
					arrs.push(pay_004_2_array);
				}else if(busiType=='64' && oprType=='005') {//手机支付64 --用户订单详细信息查询
					tdArr.push($this.find('td:eq(13)'));
					tdArr.push($this.find('td:eq(14)'));
					tdArr.push($this.find('td:eq(16)'));
					tdArr.push($this.find('td:eq(17)'));
					tdArr.push($this.find('td:eq(18)'));
					arrs.push(pay_004_2_array);
					arrs.push(pay_004_1_array);
					arrs.push(pay_005_1_array);
					arrs.push(pay_005_2_array);
					arrs.push(pay_005_3_array);
				}else if(busiType=='64' && oprType=='006') {//手机支付64 --用户开销户历史查询
					tdArr.push($this.find('td:eq(1)'));
					tdArr.push($this.find('td:eq(3)'));
					tdArr.push($this.find('td:eq(9)'));
					tdArr.push($this.find('td:eq(10)'));
					tdArr.push($this.find('td:eq(11)'));
					arrs.push(pay_006_1_array);
					arrs.push(pay_006_4_array);
					arrs.push(pay_006_2_array);
					arrs.push(pay_006_2_array);
					arrs.push(pay_006_3_array);
				}else if(busiType=='64' && oprType=='007') {//手机支付64 --用户开销户历史查询
					tdArr.push($this.find('td:eq(18)'));
					arrs.push(pay_64_0071_array);
				}
				else if(busiType=='64' && oprType=='009') {//手机支付64 --用户开销户历史查询
					tdArr.push($this.find('td:eq(1)'));
					tdArr.push($this.find('td:eq(4)'));
					tdArr.push($this.find('td:eq(5)'));
					tdArr.push($this.find('td:eq(6)'));
					tdArr.push($this.find('td:eq(7)'));
					tdArr.push($this.find('td:eq(9)'));
					arrs.push(pay_64_0091_array);
					arrs.push(pay_64_0092_array);
					arrs.push(pay_64_0093_array);
					arrs.push(pay_64_0094_array);
					arrs.push(pay_64_0095_array);
					arrs.push(pay_64_0096_array);
				}    
					else if(busiType=='64' && oprType=='011') {//手机支付64 --用户开销户历史查询
					tdArr.push($this.find('td:eq(2)'));
					tdArr.push($this.find('td:eq(5)'));
					arrs.push(pay_64_0111_array);
					arrs.push(pay_64_0112_array);

				}
				
				else if(busiType=='70' && oprType=='007') {//手机支付64 --通信账户支付历史订购查询
					tdArr.push($this.find('td:eq(6)'));
					arrs.push(pay_007_1_array);
				}else if(busiType=='82' && oprType=='001') {//手机视频82--黑名单查询
					tdArr.push($this.find('td:eq(2)'));
					arrs.push(media_001_1_array);
				}else if(busiType=='82' && oprType=='002') {//手机视频82--历史订购查询
					tdArr.push($this.find('td:eq(5)'));
					tdArr.push($this.find('td:eq(6)'));
					tdArr.push($this.find('td:eq(7)'));
					arrs.push(media_002_1_array);
					arrs.push(media_002_2_array);
					arrs.push(media_002_3_array);
				}else if(busiType=='82' && oprType=='003') {//手机视频82--点播记录查询 使用media_002_1_array
					tdArr.push($this.find('td:eq(6)'));
					arrs.push(media_002_1_array);
				}else if(busiType=='82' && oprType=='005') {//手机视频82--异常稽核用户查询 使用media_005_1_array
					tdArr.push($this.find('td:eq(1)'));
					arrs.push(media_005_1_array);
				}else if(busiType=='82' && oprType=='006') {//手机视频82--图形验证码用户查询 使用media_005_1_array
					tdArr.push($this.find('td:eq(1)'));
					arrs.push(media_005_1_array);
				}else if(busiType=='82' && oprType=='007') {
					/* 2014/08/05 10:11:03 gaopeng 手机视频82--使用记录查询 使用 media_002_1_array
						使用记录查询 将第七个出参转换  计费类型
					*/
					//$(this).find("td:eq(7)").html(checkshuzi($(this).find('td:eq(7)').html()));
					tdArr.push($this.find('td:eq(6)'));
					arrs.push(media_002_1_array);
				}else if(busiType=='82' && oprType=='008') {//手机视频82--008业务黑名单查询接口
					tdArr.push($this.find('td:eq(1)'));
					arrs.push(media_005_1_array);
				}else if (busiType == '40' && oprType == '003'){
					tdArr.push($this.find('td:eq(2)'));
					arrs.push(error_002_1_array);
				} else if (busiType == '40' && oprType == '004'){
					tdArr.push($this.find('td:eq(4)'));
					arrs.push(error_002_1_array);
				} else if (busiType == '40' && oprType == '005'){
					tdArr.push($this.find('td:eq(3)'));
					arrs.push(error_002_1_array);
				} else if (busiType == '40' && oprType == '006'){
					tdArr.push($this.find('td:eq(2)'));
					arrs.push(error_002_1_array);
				} else if (busiType == '40' && oprType == '007'){
					tdArr.push($this.find('td:eq(2)'));
					arrs.push(error_002_1_array);
				} else if (busiType == '40' && oprType == '008'){
					tdArr.push($this.find('td:eq(4)'));
					arrs.push(error_002_1_array);
				} else if (busiType == '40' && oprType == '009'){
					tdArr.push($this.find('td:eq(2)'));
					arrs.push(error_002_1_array);
				} else if (busiType == '40' && oprType == '010'){
					tdArr.push($this.find('td:eq(2)'));
					arrs.push(error_002_1_array);
				} else if (busiType == '95' && oprType == '003'){
					tdArr.push($this.find('td:eq(1)'));
				  tdArr.push($this.find('td:eq(6)'));
				  arrs.push(fee_003_113_array);
					arrs.push(fee_003_112_array);
				}else if (busiType == '95' && oprType == '010'){
					
					tdArr.push($this.find('td:eq(4)'));
					arrs.push(v_95_010_01_array);
					
					tdArr.push($this.find('td:eq(8)'));
					arrs.push(v_95_010_02_array);
					
					
				}else if (busiType == '95' && oprType == '013'){
					tdArr.push($this.find('td:eq(2)'));
					arrs.push(v_95_013_01_array);
					
				}else if (busiType == '95' && oprType == '014'){
					tdArr.push($this.find('td:eq(0)'));
					arrs.push(v_95_014_01_array);
					
				
				}else if (busiType == '95' && oprType == '005'){
					/*2014/08/05 9:12:07 gaopeng 用户接收状态查询
					关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知（能力开放接口）
					*/
				  tdArr.push($this.find('td:eq(0)'));
					arrs.push(anim_95_005_array);
				} 
				else if (busiType == '95' && oprType == '009'){
					/*2014/08/05 9:12:07 gaopeng 用户接收状态查询
					关于下发一级客服省级业务支撑系统2014年07月批次配合改造要求的通知（能力开放接口）
					*/
				  tdArr.push($this.find('td:eq(2)'));
					arrs.push(anim_95_009_001_array);
}else if (busiType == '121' && oprType == '005'){
					tdArr.push($this.find('td:eq(4)'));
					arrs.push(v_121_005_01_array);
				}else if (busiType == '121' && oprType == '006'){
					tdArr.push($this.find('td:eq(4)'));
					arrs.push(v_121_005_01_array);
				}else if (busiType == '121' && oprType == '007'){
					tdArr.push($this.find('td:eq(4)'));
					arrs.push(v_121_005_01_array);
				}else if (busiType == '121' && oprType == '008'){
					tdArr.push($this.find('td:eq(0)'));
					arrs.push(v_121_005_02_array);
				}else if (busiType == '159' && oprType == '001'){
					tdArr.push($this.find('td:eq(17)'));
					tdArr.push($this.find('td:eq(18)'));
					arrs.push(v_159_001_01_array);
					arrs.push(v_159_001_02_array);
				}else if (busiType == '42' && oprType == '009'){
					tdArr.push($this.find('td:eq(4)'));
					arrs.push(v_42_009_01_array);
				}else if (busiType == '42' && oprType == '008'){
				
					tdArr.push($this.find('td:eq(4)'));
					arrs.push(v_42_008_01_array);
					tdArr.push($this.find('td:eq(5)'));
					arrs.push(v_42_008_02_array);
				}else if (busiType == '82' && oprType == '009'){
					tdArr.push($this.find('td:eq(3)'));
					arrs.push(v_82_009_01_array);
				}else if (busiType == '82' && oprType == '011'){
					tdArr.push($this.find('td:eq(5)'));
					arrs.push(v_82_011_01_array);
				}				
				else if (busiType == '70' && oprType == '001'){
				  tdArr.push($this.find('td:eq(6)'));
					arrs.push(product_type_001_1_array);
				}else if (busiType == '70' && oprType == '002'){
				  tdArr.push($this.find('td:eq(0)'));
					arrs.push(product_type_002_1_array);
				} else if (busiType == '70' && oprType == '003'){
				  tdArr.push($this.find('td:eq(3)'));
					arrs.push(product_type_003_1_array);
				} else if (busiType == '54' && oprType == '001'){
					tdArr.push($this.find('td:eq(2)'));
					tdArr.push($this.find('td:eq(5)'));
					tdArr.push($this.find('td:eq(8)'));
					tdArr.push($this.find('td:eq(9)'));
					tdArr.push($this.find('td:eq(12)'));
					tdArr.push($this.find('td:eq(13)'));
					tdArr.push($this.find('td:eq(14)'));
					tdArr.push($this.find('td:eq(16)'));
					tdArr.push($this.find('td:eq(17)'));
					
					arrs.push(j_44_001_2);
					arrs.push(j_44_001_5);
					arrs.push(j_44_001_8);
					arrs.push(j_44_001_9);
					arrs.push(j_44_001_12);
					arrs.push(j_44_001_13);
					arrs.push(j_44_001_14);
					arrs.push(j_44_001_16);
					arrs.push(j_44_001_17);
					
				} else if (busiType == '54' && oprType == '002'){
					tdArr.push($this.find('td:eq(2)'));
					tdArr.push($this.find('td:eq(5)'));
					tdArr.push($this.find('td:eq(9)'));
					tdArr.push($this.find('td:eq(10)'));
					tdArr.push($this.find('td:eq(11)'));
					tdArr.push($this.find('td:eq(14)'));
					tdArr.push($this.find('td:eq(15)'));
					
					arrs.push(j_44_002_2);
					arrs.push(j_44_002_5);
					arrs.push(j_44_002_9);
					arrs.push(j_44_002_10);
					arrs.push(j_44_002_11);
					arrs.push(j_44_002_14);
					arrs.push(j_44_002_15);
					
				}else if (busiType == '54' && oprType == '003'){
				  tdArr.push($this.find('td:eq(2)'));
					arrs.push(j_44_003_2);
				}else if (busiType == '130' && oprType == '001'){
				  tdArr.push($this.find('td:eq(3)'));
					arrs.push(j_130_001_3);
				}else if (busiType == '130' && oprType == '003'){
				  tdArr.push($this.find('td:eq(3)'));
				  tdArr.push($this.find('td:eq(4)'));
					arrs.push(j_130_003_3);
					arrs.push(j_130_003_4);
				}else if (busiType == '130' && oprType == '004'){
				  tdArr.push($this.find('td:eq(2)'));
					arrs.push(j_130_004_2);
				}else if (busiType == '50' && oprType == '002'){
				  tdArr.push($this.find('td:eq(2)'));
				  tdArr.push($this.find('td:eq(3)'));
					arrs.push(j_50_002_2);
					arrs.push(j_50_002_3);
				}else if (busiType == '50' && oprType == '003'){
				  tdArr.push($this.find('td:eq(2)'));
				  tdArr.push($this.find('td:eq(3)'));
					arrs.push(j_50_003_2);
					arrs.push(j_50_003_3);
				}else if (busiType == '121' && oprType == '001'){
				  tdArr.push($this.find('td:eq(3)'));
					arrs.push(j_121_001_3);
				}else if (busiType == '121' && oprType == '002'){
				  tdArr.push($this.find('td:eq(5)'));
				  tdArr.push($this.find('td:eq(10)'));
					arrs.push(j_121_002_5);
					arrs.push(j_121_002_10);
				}else if (busiType == '121' && oprType == '003'){
				  tdArr.push($this.find('td:eq(2)'));
					arrs.push(j_121_003_2);
				}else if (busiType == '121' && oprType == '004'){
				  tdArr.push($this.find('td:eq(0)'));
					arrs.push(j_121_004_0);
				}else if (busiType == '47' && oprType == '002'){
				  tdArr.push($this.find('td:eq(2)'));
				  tdArr.push($this.find('td:eq(11)'));
				  tdArr.push($this.find('td:eq(14)'));
					arrs.push(zwmdo_002_ywcztype);
					arrs.push(zwmdo_002_jftype);
					arrs.push(zwmdo_002_jfstuts);
				}
				
				
				setTdVals(tdArr,arrs);
			});
			
			$('#currPageSpan').text('<%=currPage%>');
			$('#pageCountSpan').text('<%=pageCount%>');
			
			if('<%=pageCount%>' == '0' || '<%=pageCount%>' == '1') {
				$('#nextPage').removeClass("detail_href");
				$('#nextPage').addClass("detail_nohref");
				$('#lastPage').removeClass("detail_href");
				$('#lastPage').addClass("detail_nohref");
			}
			setSelPage('<%=pageCount%>');
			window.parent.showIfTable();  
		}else {
			rdShowMessageDialog("错误代码：<%=retCodeQry%>，错误信息：<%=retMsgQry%>",0);
		}
		
		//隐藏父页面的遮罩
		window.parent.hideBox();
		
		$('#pageSel').change(function() {
		  	var toPage = $('#pageSel').val();
			var busiType = '<%=busiType%>';
			var oprType = '<%=oprType%>';
			location ="fe827_frame2.jsp?toPage=" + toPage + "&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&busiType=" 
				+ busiType + "&oprType=" + oprType + "&provCode=<%=provCode%>&oprStatus=<%=oprStatus%>";
		});
		$('#nextPage').click(function() {
			//alert(598);
			var currPage = '<%=toPage%>';
			if( parseInt(currPage) < parseInt('<%=pageCount%>') ) {
			  var toPage = parseInt('<%=toPage%>') + 1;
			  var busiType = '<%=busiType%>';
			  var oprType = '<%=oprType%>';
			  location ="fe827_frame2.jsp?toPage=" + toPage 
			  	+ "&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&busiType=" + busiType + "&oprType=" + oprType
			  	+ "&provCode=<%=provCode%>&oprStatus=<%=oprStatus%>";
			}
		});
		$('#lastPage').click(function() {
			var currPage = '<%=toPage%>';
			if( parseInt(currPage) < parseInt('<%=pageCount%>') ) {
			  var toPage = '<%=pageCount%>';
			  var busiType = '<%=busiType%>';
			  var oprType = '<%=oprType%>';
			  location ="fe827_frame2.jsp?toPage=" + toPage 
			  	+ "&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&busiType=" + busiType + "&oprType=" + oprType
			  	+ "&provCode=<%=provCode%>&oprStatus=<%=oprStatus%>";
			}
		});
				$('#toexcels').click(function() {
						printTable();
		});
		
	});
	
	function showTable() {
	$('#tabList').css('display','block');	
	$('#pageTable').css('display','block');	
	//设置父页面的高度
	$(window.parent.document).find("iframe[@id='resultIframe']").css('height',$("body").height() + 'px');
	}
	
	function clearTable() {
		$('#tabList').empty();
		$('#pageTable').empty();
	}	
	
	function setSelPage(pageCount) {
		if(!pageCount || pageCount=='0') {
			$('#pageSel').append('<option value = 1>第1页</option>');
		}else {
			var count = parseInt(pageCount);
			var pageArr = new Array();
			for( var i = 1; i <= count; i++) {
				pageArr.push('<option value = ' + i + '>第' + i + '页</option>');
			}
			$('#pageSel').append(pageArr.join(''));
		}
	}
	
	var excelObj;
function printTable()
{
	var obj=document.all.tabList;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){alert("生成excel失败!");}
	} else {
		alert("no data");
	}
}

function checkshuzi(obj) {
  if(obj!=null) {
    var returnvaluss="";
            var jisuanhou=(parseFloat(obj)/1024);
            var dot = (jisuanhou+"").indexOf(".");
            if(dot != -1){
							returnvaluss=jisuanhou.toFixed(3);
            }else {
            	returnvaluss=jisuanhou;
            }
    return returnvaluss;
    }
}

</script>