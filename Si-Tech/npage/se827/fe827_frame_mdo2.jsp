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
	String opCode     =  request.getParameter("opCode");
  String opName     =  request.getParameter("opName");
  String workNo     = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
  String op_strong_pwd = (String) session.getAttribute("password");
  String phoneNo = request.getParameter("phoneNo");
  String busiType = request.getParameter("busiType");
  String oprType = request.getParameter("oprType");
	String toPage = request.getParameter("toPage");//跳转到哪页
	String provCode = request.getParameter("provCode");
	String oprStatus = request.getParameter("oprStatus");
	String indictSeq = request.getParameter("indictSeq");
	
	
	//设置一些变量
	String[][] tempArr = new String[][]{};
	String[] records =  null;
	String[] tds = null;
	String rstStr = "";
	String recordCount = "";//总记录数
	String pageCount = "";//总页数
	String lines_one_page = "";//一页多少行
	
	String currPage ="";//当前页
	String currCount = "";//当前页记录数
	StringBuffer sb = new StringBuffer("");
	String sbStr = "";
	String dateStr =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] inputParams = new String[9];
	inputParams[0] = "";
	inputParams[1] = "01";
	inputParams[2] = opCode;
	inputParams[3] = workNo;
	inputParams[4] = op_strong_pwd;
	inputParams[5] = phoneNo;
	inputParams[6] = "";
	inputParams[8] = toPage;
	
	String acceptDept=(String)session.getAttribute("orgCode");//部门
	
	String jsonstr   = request.getParameter("jsonstr");
	String optypess   = request.getParameter("optypess");
	
	
	String logType="";//接口类型
		//接口回参
	String retCodeMs = "";
	String retMsgMs = "";
	String userMsgMs[][] =new String[][]{};
	
%>
	
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
	<%
		inputParams[0] = loginAccept;
		String tempAccept = loginAccept.substring(5);
		inputParams[7] = oprStatus;
		
		for(int i=0;i<inputParams.length;i++) {
			System.out.println("----------liujian--sE827PageQry---inputParams[" + i + "]=" + inputParams[i]);
		}
		
		if(oprType.equals("001")) {/*ivr*/
		 logType="s4g03Snd";
		 
		 try{
	%>		
			<wtc:service name="s4g03Snd" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode111" retmsg="retMsg111" outnum="8">
				<wtc:param value="<%=indictSeq%>"/>
				<wtc:param value="<%=toPage%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=acceptDept%>"/>
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
			retMsgMs="调用s4g03Snd接口失败！";
		}				
			
	
	
  }else{/*mdo*/
  	
 		 logType="s4g04Snd";
 		 try{
%>		
			<wtc:service name="s4g04Snd" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode222" retmsg="retMsg222" outnum="8">
				<wtc:param value="<%=indictSeq%>"/>
				<wtc:param value="<%=toPage%>"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=acceptDept%>"/>
				<wtc:param value="<%=optypess%>"/>
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
			retMsgMs="调用s4g04Snd接口失败！";
		}		

  }
  
  
	%>	

	
<%
		/*
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
			pageCount = "5";
		
		
		if(toPage.equals("1")) {
			rstStr = "1|1111|111|111[REC_SPLIT]2|2222|222|222";
			currPage = "1";
		}else if(toPage.equals("2")) {
			rstStr = "3|3333|333|333[REC_SPLIT]4|4444|444|444";
			currPage = "2";
		}else if(toPage.equals("3")) {
			rstStr = "5|5555|555|555[REC_SPLIT]6|6666|666|666";
			currPage = "3";
		}else if(toPage.equals("4")) {
			rstStr = "7|7777|777|777[REC_SPLIT]8|8888|888|888";
			currPage = "4";
		}else if(toPage.equals("5")) {
			rstStr = "9|9999|999|999[REC_SPLIT]10|10101010|101010|101010";
			currPage = "5";
		}
		*/
		/**
		String [][]result1 = new String[1][9];
		result1[0][2] = "10";//总记录数
		result1[0][4] = "10";//一页多少行
		result1[0][5] = "2";//当前页
		result1[0][6] = "3";//总页数
		result1[0][7] = "1|1111|111|111|1[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3[REC_SPLIT]2|2222|222|222|3";
	  String retCodeQry = "000000";
	  String retMsgQry = "000000";
		*/

%>
            	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
    <script language="javascript" type="text/javascript" src="fe827.js"></script>
    <link href="../query/detail.css" rel="stylesheet" type="text/css"></link>
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
									<td><span name="firstPage" id="firstPage" class="detail_href">【首页】   </span> </td>
									<td><span name="prevPage" id="prevPage" class="detail_href">  【上一页】 </span> </td>
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
  			$(window.parent.$("#indictSeq").val("<%=indictSeq%>"));
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
  			setSelPage('<%=pageCount%>');
  			window.parent.hideBox();  
			window.parent.showIfTable();  
		}else {
			rdShowMessageDialog("错误代码：<%=retCodeMs%>，错误信息：<%=retMsgMs%>",0);
		}
		setToPageAttr();
		$('#firstPage').click(function() {
			 var currPage = '<%=toPage%>';
			 if(parseInt(currPage) > 1) {
		 		 var toPage = parseInt('<%=toPage%>') - 1;
				 var busiType = '<%=busiType%>';
	  			 var oprType = '<%=oprType%>';
	  			 window.parent.showBox();
				 location ='fe827_frame_mdo2.jsp?toPage=1' 
				  	+ '&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&busiType=' + busiType + '&oprType=' + oprType
				  	+ '&provCode=<%=provCode%>&oprStatus=<%=oprStatus%>&indictSeq=<%=indictSeq%>&optypess=<%=optypess%>&jsonstr=<%=jsonstr%>';
			}
		});
		$('#prevPage').click(function() {
			 var currPage = '<%=toPage%>';
			 if(parseInt(currPage) > 1) {
				  var toPage = parseInt('<%=toPage%>') - 1;
				  var busiType = '<%=busiType%>';
	  			  var oprType = '<%=oprType%>';
	  			  window.parent.showBox();
				  location ='fe827_frame_mdo2.jsp?toPage=' + toPage 
				  	+ '&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&busiType=' + busiType + '&oprType=' + oprType
				  	+ '&provCode=<%=provCode%>&oprStatus=<%=oprStatus%>&indictSeq=<%=indictSeq%>&optypess=<%=optypess%>&jsonstr=<%=jsonstr%>';
			 }
		});
		$('#pageSel').change(function() {
		  	var toPage = $('#pageSel').val();
			var busiType = '<%=busiType%>';
  			var oprType = '<%=oprType%>';
  			window.parent.showBox();
			location ='fe827_frame_mdo2.jsp?toPage=' + toPage 
			  	+ '&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&busiType=' + busiType + '&oprType=' + oprType
			  	+ '&provCode=<%=provCode%>&oprStatus=<%=oprStatus%>&indictSeq=<%=indictSeq%>&optypess=<%=optypess%>&jsonstr=<%=jsonstr%>';
		});
		$('#nextPage').click(function() {
			var currPage = '<%=toPage%>';
			if( parseInt(currPage) < parseInt('<%=pageCount%>') ) {
			  var toPage = parseInt('<%=toPage%>') + 1;
			  var busiType = '<%=busiType%>';
  			  var oprType = '<%=oprType%>';
  			  window.parent.showBox();
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
  			  window.parent.showBox();
			  location ='fe827_frame_mdo2.jsp?toPage=' + toPage 
			  	+ '&phoneNo=<%=phoneNo%>&opCode=<%=opCode%>&busiType=' + busiType + '&oprType=' + oprType
			  	+ '&provCode=<%=provCode%>&oprStatus=<%=oprStatus%>&indictSeq=<%=indictSeq%>&optypess=<%=optypess%>&jsonstr=<%=jsonstr%>';
			}
		});
		
		$('#toexcels').click(function() {
						printTable();
		});
		
  });
	//设置颜色和click事件
	function setToPageAttr() {
		var count = '<%=pageCount%>';
		var currPage = '<%=toPage%>';
		if(parseInt(count) == parseInt(currPage)) {
				$('#nextPage').removeClass("detail_href").addClass("detail_nohref").unbind("click");
				$('#lastPage').removeClass("detail_href").addClass("detail_nohref").unbind("click");
		}else if(parseInt(currPage) == 1) {
			  $('#firstPage').removeClass("detail_href").addClass("detail_nohref").unbind("click");
			  $('#prevPage').removeClass("detail_href").addClass("detail_nohref").unbind("click");
	  }
	}
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
					if( i == parseInt('<%=toPage%>')) {
						pageArr.push('<option value = ' + i + ' selected>第' + i + '页</option>');
					}else {
						pageArr.push('<option value = ' + i + '>第' + i + '页</option>');
					}
					
			}
			$('#pageSel').append(pageArr.join(''));
		}
}
	
	function ajaxRequest() {
		var packet = new AJAXPacket("fe827_2.jsp","正在获得相关信息，请稍候......");
		var _data = packet.data;
		_data.add("phoneNo",'<%=phoneNo%>');
		_data.add("type","0");//请求服务标识
		_data.add("page",typeCode);
		_data.add("method","apply_getSaleWays");
		core.ajax.sendPacket(packet);
		packet = null;	
	}
	function doProcess(package) {
		var retCode = package.data.findValueByName("retcode");
		var retMsg = package.data.findValueByName("retmsg");
		var result = package.data.findValueByName("result");
		if(retCode == "000000") {
			
		}else {
			rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
			return false;
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