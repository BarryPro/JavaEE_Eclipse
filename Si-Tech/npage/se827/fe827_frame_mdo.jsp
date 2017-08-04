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
    	public  String getCurrDateStr(String format) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				format);
		return objSimpleDateFormat.format(new java.util.Date());
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
  String bp_name   = request.getParameter("bp_name");
  String sm_codes   = request.getParameter("sm_codes");
  String xingjis   = request.getParameter("xingjis");
  String acceptDept=(String)session.getAttribute("orgCode");//部门
  
  String jsonstr   = request.getParameter("jsonstr");
  
  
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
	String indictSeq=getCurrDateStr("yyyyMMdd")+"CSVC"+"451"+getCurrDateStr("HHmmsss");//首次查询创建请求服务标识
	
	String startquertime="";
  String endquerytime="";
  String optypess="";
  
  String[] infoStrs=infoStr.split("\\|");
	
	if(oprType.equals("001")) {/*ivr*/
	startquertime=infoStrs[1];
	endquerytime=infoStrs[2];
	
  }else{/*mdo*/
  optypess=infoStrs[1];
	startquertime=infoStrs[2];
	endquerytime=infoStrs[3];  	
  }
  
  String svcTypeId="0303";//服务请求分类编码
	String homeProv="451";//受理省代码
	
	String logType="";//接口类型
	
	String[] inputParams = new String[18];
	inputParams[0] = indictSeq;
	inputParams[1] = phoneNo;
	inputParams[2] = startquertime;
	inputParams[3] = endquerytime;
	inputParams[4] = "08";
	inputParams[5] = "";
	inputParams[6] = "";
	inputParams[7] = bp_name;
	inputParams[8] = xingjis;
	inputParams[9] = sm_codes;
	inputParams[10] = svcTypeId;
	inputParams[11] = homeProv;
	inputParams[12] = workNo;
	inputParams[13] = dateStr;
	inputParams[14] = dateStr;
	inputParams[15] = workNo;
	inputParams[16] = workNo;
	inputParams[17] = acceptDept;

	
%>
	
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
	<%

		for(int i=0;i<inputParams.length;i++) {
			System.out.println("----------liujian--sE827Qry---inputParams[" + i + "]=" + inputParams[i]);
		}
		//zhouby 开始调用服务


	//接口回参
	String retCodeMs = "";
	String retMsgMs = "";
	String userMsgMs[][] =new String[][]{};


			
	
if(oprType.equals("001")) {/*ivr*/
		 logType="s4g01Snd";
		 
		 try{
	%>		
	<wtc:service name="s4g01Snd" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCodeQry111" retmsg="retMsgQry111" outnum="8">
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
			<wtc:param value="<%=inputParams[14]%>"/>
			<wtc:param value="<%=inputParams[15]%>"/>
			<wtc:param value="<%=inputParams[16]%>"/>
			<wtc:param value="<%=inputParams[17]%>"/>
	</wtc:service>
	<wtc:array id="userMsg" scope="end"/>
<%
				
				userMsgMs = userMsg;
				retCodeMs = userMsgMs[0][0];
				//retMsgMs = "s4g01Snd";
				if("0000".equals(retCodeMs)){
				retMsgMs=userMsgMs[0][1];
				recordCount=userMsgMs[0][2]==""?"0":userMsgMs[0][2];
				lines_one_page=userMsgMs[0][3]==""?"0":userMsgMs[0][3];
				currCount=userMsgMs[0][4]==""?"0":userMsgMs[0][4];
				currPage=userMsgMs[0][5]==""?"0":userMsgMs[0][5];
				pageCount=userMsgMs[0][6]==""?"0":userMsgMs[0][6];
				rstStr=userMsgMs[0][7]==null?"":userMsgMs[0][7];
				
				if(recordCount != null && "0".equals(recordCount)) {
				sb.append("noRec");
				sbStr = sb.toString();
			  }
			
				}
			

		}catch(Exception ex){
			retCodeMs ="-1";
			retMsgMs="调用s4g01Snd接口失败！";
		}
	
  }else{/*mdo*/
  	
 		 logType="s4g02Snd";
 		 
 		  try{
	%>		
	<wtc:service name="s4g02Snd" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCodeQry111" retmsg="retMsgQry111" outnum="8">
			<wtc:param value="<%=inputParams[0]%>"/>
			<wtc:param value="<%=inputParams[1]%>"/>
			<wtc:param value="<%=inputParams[2]%>"/>
			<wtc:param value="<%=inputParams[3]%>"/>
			<wtc:param value="<%=optypess%>"/>
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
			<wtc:param value="<%=inputParams[14]%>"/>
			<wtc:param value="<%=inputParams[15]%>"/>
			<wtc:param value="<%=inputParams[16]%>"/>
			<wtc:param value="<%=inputParams[17]%>"/>
	</wtc:service>
	<wtc:array id="userMsg" scope="end"/>
<%

				userMsgMs = userMsg;
				retCodeMs = userMsgMs[0][0];
				//retMsgMs = "s4g01Snd";
				if("0000".equals(retCodeMs)){
				retMsgMs=userMsgMs[0][1];
				recordCount=userMsgMs[0][2]==""?"0":userMsgMs[0][2];
				lines_one_page=userMsgMs[0][3]==""?"0":userMsgMs[0][3];
				currCount=userMsgMs[0][4]==""?"0":userMsgMs[0][4];
				currPage=userMsgMs[0][5]==""?"0":userMsgMs[0][5];
				pageCount=userMsgMs[0][6]==""?"0":userMsgMs[0][6];
				rstStr=userMsgMs[0][7]==null?"":userMsgMs[0][7];
							
				
				if(recordCount != null && "0".equals(recordCount)) {
				sb.append("noRec");
				sbStr = sb.toString();
			  }
			
				} 	
  	
  		}catch(Exception ex){
			retCodeMs ="-1";
			retMsgMs="调用s4g02Snd接口失败！";
		}	

  }
  	

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

		
String e828retcodes="000000";
String e828retmsgs="成功";
if("0000".equals(retCodeMs)){
		String[] inputParamssss = new String[15];
		inputParamssss[0] = "";
		inputParamssss[1] = "01";
		inputParamssss[2] = opCode;
		inputParamssss[3] = workNo;
		inputParamssss[4] = op_strong_pwd;
		inputParamssss[5] = phoneNo;
		inputParamssss[6] = "";
		inputParamssss[7] = dateStr;
		inputParamssss[8] = busiType;
		inputParamssss[9] = "02"+oprType;
		inputParamssss[10] = infoStr;
		inputParamssss[11] ="";
    inputParamssss[12] ="";
		inputParamssss[13] = provCode;
		inputParamssss[14] = jsonstr;
	
	 try{	
%>
		<wtc:service name="sE828Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCodee828" retmsg="retMsge828" outnum="1">
				<wtc:param value="<%=inputParamssss[0]%>"/>
				<wtc:param value="<%=inputParamssss[1]%>"/>
				<wtc:param value="<%=inputParamssss[2]%>"/>
				<wtc:param value="<%=inputParamssss[3]%>"/>
				<wtc:param value="<%=inputParamssss[4]%>"/>
				<wtc:param value="<%=inputParamssss[5]%>"/>
				<wtc:param value="<%=inputParamssss[6]%>"/>
				<wtc:param value="<%=inputParamssss[7]%>"/>
				<wtc:param value="<%=inputParamssss[8]%>"/>
				<wtc:param value="<%=inputParamssss[9]%>"/>
				<wtc:param value="<%=inputParamssss[10]%>"/>
				<wtc:param value="<%=inputParamssss[11]%>"/>
				<wtc:param value="<%=inputParamssss[12]%>"/>
				<wtc:param value="<%=inputParamssss[13]%>"/>
				<wtc:param value="<%=inputParamssss[14]%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
e828retcodes=retCodee828;
e828retmsgs=retMsge828;

  		}catch(Exception ex){
			e828retcodes ="-1";
			e828retmsgs="调用sE828Cfm记录操作日志失败！";
		 }	

}	

	if(!"000000".equals(e828retcodes)){

%>
  	<script language="javascript">
 	    rdShowMessageDialog("调用sE828Cfm记录操作日志失败！错误代码<%=e828retcodes%>，错误原因<%=e828retmsgs%>",0);
 	  </script>
<%
	}
%>
            	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
    <script language="javascript" type="text/javascript" src="fe827.js?v=121122"></script>
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
						if(recordCount != null && !"0".equals(recordCount)) {
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
		if('<%=retCodeMs%>' == "0000") {
			/* liujian 添加title 2012-5-7 16:38:24 begin */
			$(window.parent.$("#indictSeq").val("<%=indictSeq%>")); 
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
				if(busiType=='99' && oprType=='001') {//ivr
					tdArr.push($this.find('td:eq(10)'));
					arrs.push(mdo_001_jftype);
				}else if(busiType=='99' && oprType=='002') {//order
					tdArr.push($this.find('td:eq(2)'));
					tdArr.push($this.find('td:eq(11)'));
					tdArr.push($this.find('td:eq(14)'));
					arrs.push(mdo_002_ywcztype);
					arrs.push(mdo_001_jftype);
					arrs.push(mdo_002_jftype);
					
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
			rdShowMessageDialog("错误代码：<%=retCodeMs%>，错误信息：<%=retMsgMs%>",0);
		}
		
		//隐藏父页面的遮罩
		window.parent.hideBox();
		
		$('#pageSel').change(function() {
		  	var toPage = $('#pageSel').val();
			var busiType = '<%=busiType%>';
			var oprType = '<%=oprType%>';
			location ='fe827_frame_mdo2.jsp?toPage=' + toPage + '&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&busiType=' 
				+ busiType + '&oprType=' + oprType + '&provCode=<%=provCode%>&oprStatus=<%=oprStatus%>&indictSeq=<%=indictSeq%>&optypess=<%=optypess%>&jsonstr=<%=jsonstr%>';
		});
		$('#nextPage').click(function() {
			//alert(598);
			var currPage = '<%=toPage%>';
			if( parseInt(currPage) < parseInt('<%=pageCount%>') ) {
			  var toPage = parseInt('<%=toPage%>') + 1;
			  var busiType = '<%=busiType%>';
			  var oprType = '<%=oprType%>';
			  location ='fe827_frame_mdo2.jsp?toPage=' + toPage 
			  	+ '&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&busiType=' + busiType + '&oprType=' + oprType
			  	+ '&provCode=<%=provCode%>&oprStatus=<%=oprStatus%>&indictSeq=<%=indictSeq%>&optypess=<%=optypess%>&jsonstr=<%=jsonstr%>';
			}
		});
		$('#lastPage').click(function() {
			var currPage = '<%=toPage%>';
			if( parseInt(currPage) < parseInt('<%=pageCount%>') ) {
			  var toPage = '<%=pageCount%>';
			  var busiType = '<%=busiType%>';
			  var oprType = '<%=oprType%>';
			  location ='fe827_frame_mdo2.jsp?toPage=' + toPage 
			  	+ '&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&busiType=' + busiType + '&oprType=' + oprType
			  	+ '&provCode=<%=provCode%>&oprStatus=<%=oprStatus%>&indictSeq=<%=indictSeq%>&optypess=<%=optypess%>&jsonstr=<%=jsonstr%>';
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