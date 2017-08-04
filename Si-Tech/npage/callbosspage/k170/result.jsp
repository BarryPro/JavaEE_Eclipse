<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat,com.sitech.crmpd.kf.ejb.client.KFEjbClient,com.sitech.crmpd.kf.ejb.client.KFEjbClient170"%>
<!--add by hanjc20090731 从内存中读取正在通话的接续记录---begin--->
<%@page import="com.sitech.crmpd.kf.dto.dcallcall.Dcallcallyyyymm"%>
<%@page import="com.sitech.crmpd.kf.cache.DCallCacheManager"%>
<%!
	//密码验证代码
  public String getCodeName(String code){
    String codeName = "否";
    if(code==null){
      return codeName;
    }else if("Y".equals(code)){
    	 codeName="是";
    }else if("YY".equals(code)){
    	 codeName="是(正确)";
    }else if("YN".equals(code)){
    	 codeName="是(失败)";
    }
      return codeName;
  }
%>
<!--add by hanjc20090731 从内存中读取正在通话的接续记录---end--->

<%
	String opCode="K171";
	String nowtoday = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String loginNo = (String) session.getAttribute("workNo");
	String orgCode = (String) session.getAttribute("orgCode");
	String kf_longin_no = (String) (session.getAttribute("kfWorkNo")==null?"":session.getAttribute("kfWorkNo"));
	String strAcceptLogSql = "";
	String strAcceptTimeSql = "";
	String strDateSql = "";
	String strPasswordSql = "";//是否验证密码
	String strOrderSql = " order by begin_date desc ";
	String start_date = "";
	String end_date = "";
	String region_code = "";
	String contact_id = "";
	String accept_login_no = "";
	String listen_flag = "";
	String accept_phone = "";
	String contact_address = "";
	String mail_address = "";
	String grade_code = "";
	String contact_phone = "";
	String caller_phone = "";
	String statisfy_code = "";
	String cust_name = "";
	String fax_no = "";
	String accept_long_begin = "";
	String accept_long_end = "";
	String callee_phone = "";
	String skill_quence = "";
	String staffHangup = "";
	String acceptid = "";
	String staffcity = "";
	String con_id = "";
	String month_interval = "";
	String[] tablenames;
	//add by hucw,20100608
	String hangup = ""; //挂机方
	int start=0;
  int end=0;
  //add by hanjc20090731 从内存中读取正在通话的接续记录---begin---
  Dcallcallyyyymm upatedcallcallpage=null;
  //add by hanjc20090731 从内存中读取正在通话的接续记录---end---

	String VERTIFY_PASSWD_FLAG_ISNOT_NULL = "";//是否验证密码
	String[][] dataRows = new String[][] {};

	//zengzq 20100125  若非查询，点击下一页等，则直接将总条数从原查询中取
	String rCount = (null == request.getParameter("rCount") ? "0": request.getParameter("rCount"));
	String isFirstQry = (null == request.getParameter("isFirstQry") ? "0": request.getParameter("isFirstQry"));
	int rowCount = Integer.parseInt(rCount);

	int pageSize = 15; // Rows each page
	int pageCount = 0; // Number of all pages
	int curPage = 0; // Current page
	String strPage; // Transfered pages
	String param = "";
	String sqlTemp = "";
	String querySql = "";
	String expFlag = request.getParameter("exp");

	start_date = request.getParameter("start_date")==null?nowtoday:request.getParameter("start_date");

	end_date = request.getParameter("end_date");
	contact_id = request.getParameter("contact_id");
	region_code = request.getParameter("region_code");
	accept_login_no = request.getParameter("accept_login_no")==null?loginNo:request.getParameter("accept_login_no");
	listen_flag = request.getParameter("listen_flag");
	accept_phone = request.getParameter("accept_phone");
	mail_address = request.getParameter("mail_address");
	contact_address = request.getParameter("contact_address");
	grade_code = request.getParameter("grade");
	contact_phone = request.getParameter("contact_phone");
	caller_phone = request.getParameter("caller_phone"); //主叫号码
	statisfy_code = request.getParameter("statisfy_code");
	cust_name = request.getParameter("cust_name");
	fax_no = request.getParameter("fax_no");
	accept_long_begin = request.getParameter("accept_long_begin");
	accept_long_end = request.getParameter("accept_long_end");
	callee_phone = request.getParameter("callee_phone");
	skill_quence = request.getParameter("skill_quence");
	staffHangup = request.getParameter("hangup");
	acceptid = request.getParameter("accid");
	staffcity = request.getParameter("staffcity");
	con_id = request.getParameter("con_id");
	month_interval = request.getParameter("month_interval");
	//add by hucw,20100608
	hangup = request.getParameter("hangup"); //挂机方
	
	//add by songjia .20100914
  String sort_sql = "begin_date desc";
  String orderColumn = request.getParameter("orderColumn")==null?"":request.getParameter("orderColumn");
  String orderCode = request.getParameter("orderCode")==null?"":request.getParameter("orderCode");
  if (!orderColumn.equals("") && !orderCode.equals("")) {
  	sort_sql = orderColumn + " " + orderCode;
 	}
	
	if("0".equals(month_interval)){
		tablenames = new String[1];
		tablenames[0] = start_date.substring(0,6);
	}else if ("1".equals(month_interval)){
		tablenames = new String[2];
		tablenames[0] = start_date.substring(0,6);
		tablenames[1] = end_date.substring(0,6);
	}else{
		tablenames = new String[1];
		tablenames[0] = start_date.substring(0,6);
	}
	VERTIFY_PASSWD_FLAG_ISNOT_NULL = request.getParameter("VERTIFY_PASSWD_FLAG_ISNOT_NULL");
	HashMap hashMap =new HashMap();
	///////查询条件在这
	String sqlFilter = request.getParameter("sqlFilter");
	System.out.println("accept_long_begin :~~~~~~~~~~~~~"+accept_long_begin);
		System.out.println("accept_long_end :~~~~~~~~~~~~~"+accept_long_end);
		System.out.println("客户级别————————"+grade_code);
		System.out.println("受理方式————————"+acceptid);
		System.out.println("联系地址---------------"+contact_address);
	if (sqlFilter == null || sqlFilter.trim().length() == 0) {
	hashMap.put("tablenames",tablenames);
	hashMap.put("begin_date",start_date);
    hashMap.put("end_date",end_date);
    hashMap.put("accept_long_begin",accept_long_begin);
    hashMap.put("accept_long_end",accept_long_end);
    hashMap.put("other_passwd_flag",VERTIFY_PASSWD_FLAG_ISNOT_NULL);
    hashMap.put("contact_id",contact_id);
    hashMap.put("region_code",region_code);
    hashMap.put("accept_login_no",accept_login_no);
    hashMap.put("accept_phone",accept_phone);
    hashMap.put("mail_address",mail_address);
    hashMap.put("contact_address",contact_address);
    hashMap.put("grade_code",grade_code);
    hashMap.put("contact_phone",contact_phone);
    hashMap.put("caller_phone",caller_phone);
    hashMap.put("statisfy_code",statisfy_code);
    hashMap.put("cust_name",cust_name);
    hashMap.put("fax_no",fax_no);
    hashMap.put("callee_phone",callee_phone);
    hashMap.put("skill_quence",skill_quence);
//add by jiyk 2012-06-14 修改挂机方为 "其它"判断方法
    if(hangup!=null&&hangup.equals("5"))
    {
      hangup=null;
    }
    hashMap.put("staffHangup",hangup);
    hashMap.put("acceptid",acceptid);
    hashMap.put("staffcity",staffcity);
    hashMap.put("listen_flag",listen_flag);
	  hashMap.put("sort_sql",sort_sql);
}

	  //通过此sql的值判断是否是质检员
    int tmpCoun = 0;
    hashMap.put("check_login_no",kf_longin_no.trim());
	  //tmpCoun=((Integer)KFEjbClient170.queryForObject("dcheckcount",hashMap)).intValue();
    // 获取最大记录数

    //zengzq 20100125
    if("0".equals(isFirstQry)){
    		rowCount=((Integer)KFEjbClient170.queryForObject("dcallcallcount",hashMap)).intValue();
    }

		strPage = request.getParameter("page");
		if (strPage == null || strPage.equals("")
		|| strPage.trim().length() == 0) {
			curPage = 1;
		} else {
			curPage = Integer.parseInt(strPage);
			if (curPage < 1)
		  curPage = 1;
		}
		pageCount = (rowCount + pageSize - 1) / pageSize;
		if (curPage > pageCount)
			curPage = pageCount;
		//计算分页参数
		start = (curPage - 1) * pageSize + 1;
		end = curPage * pageSize;

		if (end > rowCount){
			end = rowCount;
		}

		hashMap.put("start",String.valueOf(start));
    hashMap.put("end",String.valueOf(end));

		List iDataList =(List)KFEjbClient170.queryForList("dcallcallinfoselect",hashMap);
		dataRows = getArrayFromListMap(iDataList ,1,28);


    /*add  by yinzx 100104 */
	ArrayList podmlist =(ArrayList)session.getAttribute("podmbutton");
	//added by tangsong 20100406
	if (podmlist == null) {
		podmlist = new ArrayList();
	}

	String spopdmbutton="N" ;
	String spopdmbuttonclass="N" ;

	if (podmlist.indexOf("K00B")>=0)
	{
	  spopdmbutton="Y";
	}
	
	if (podmlist.indexOf("K01B")>=0)
	{
	  spopdmbuttonclass="Y";
	}
	/*add  by yinzx 100104 */
%>
<html>
	<head>
		<%@ include file="k171_callMsgQry_include.jsp" %>
	</head>

<%
	//updated by tangsong 20100603 普通话务员不能查看录音听取标志和质检员工号
	boolean isHWY = false;
	for(int i = 0; i < powerCodeArr.length; i++){
		for(int j = 0; j < HUAWUYUAN_ID.length; j++){
			if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) {
				isHWY = true;
				break;
			}
		}
	}
%>

	<script language="javascript" type="text/javascript">
	//updated by tansong 20101221 不再使用遮罩层
	/*
	function hiddenOperate(){
			parent.parent.document.getElementById("loadingresult").style.display='';
	}

	//added by tangsong 20100904
	function showOperate(){
			parent.parent.document.getElementById("loadingresult").style.display='none';
	}
	*/

	$(document).ready(
		function()
		{
	    $("tr").not("[input]").addClass("blue");
	    $("th").css("color","#3366FF").css("font-weight","bold");

			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "#159ee4");
			});
			//updated by tansong 20101221 不再使用遮罩层
			/*
			//added by tangsong 20100904
			showOperate();
			*/
		}
	);

	</script>
	<body>

		<div id="Operation_Table">
			<!--input type="button" class="b_foot" value = "展开/收起" onClick="showQuery('frameset110');" >
      <input type="button" class="b_foot" value = "刷新" onClick="parent.queryFrame.submitInputCheck();"-->
    <table  cellSpacing="0">
		<!--add by mixh-->
		<tr >
      <td align="left" colspan="28" class="Blue">
        <%if(pageCount!=0){%>
        第<%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
        <%} else{%>
        <font color="orange">当前记录为空！</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#"   onClick="doLoad('first');return false;">首页</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">上一页</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">下一页</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">尾页</a>&nbsp;
        <!--hucw 20100828,不需要链接<a>快速选择</a>-->
        <span>快速选择</span>
        <select onchange="jumpToPage(this.value);" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      </select style="height:18px">&nbsp;&nbsp;
        <!--hucw 20100828,不需要链接<a>快速跳转</a>-->
        <span>快速跳转</span>
        <input id="thePage1" name="thePage1" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>
        <a href="#" onClick="jumpToPage('jumpToPage1');return false;">
        	<font face=粗体>GO</font>
        </a>
        <%}%>
      </td>
    </tr>
		<!--add by mixh-->
          <tr >
       <script>

       	var tempBool ='flase';
      	if(true){
      		document.write('<th align="center" class="blue" width="15%" nowrap > <input type="checkbox" style="width:20px;" onclick="chooseAll(this)" title="全选" />操作 </th>');
      		tempBool='true';
      	}
        </script>
        	
            <th align="center" class="blue" width="8%" nowrap > 流水号 </th>
            <th align="center" class="blue" width="8%" nowrap > 受理号码
            	<%//added by tangosng 20110118 排序
            		if ("accept_phone".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('accept_phone','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('accept_phone','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('accept_phone','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>            
            <th align="center" class="blue" width="8%" nowrap > 主叫号码
            	<%//added by tangosng 20110118 排序
            		if ("caller_phone".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('caller_phone','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('caller_phone','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('caller_phone','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>
            <th align="center" class="blue" width="8%" nowrap > 被叫号码
            	<%//added by tangosng 20110118 排序
            		if ("callee_phone".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('callee_phone','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('callee_phone','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('callee_phone','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>            
            <th align="center" class="blue" width="8%" nowrap > 受理工号
            	<%//added by tangosng 20110118 排序
            		if ("accept_login_no".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('accept_login_no','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('accept_login_no','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('accept_login_no','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th> 
            <th align="center" class="blue" width="8%" nowrap > 客户姓名
            	<%//added by tangosng 20110118 排序
            		if ("cust_name".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('cust_name','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('cust_name','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('cust_name','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>           
            <th align="center" class="blue" width="8%" nowrap > 客户地市
            	<%//added by tangosng 20110118 排序
            		if ("servicecity".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('servicecity','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('servicecity','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('servicecity','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>      
            <th align="center" class="blue" width="8%" nowrap > 客户归属
            	<%//added by tangosng 20110118 排序
            		if ("region_code".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('region_code','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('region_code','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('region_code','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>     
            <!-- added by tangsong 20100528 加上客户级别-->
            <th align="center" class="blue" width="8%" nowrap > 客户级别
            	<%//added by tangosng 20110118 排序
            		if ("usertype".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('usertype','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('usertype','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('usertype','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>            
            <th align="center" class="blue" width="8%" nowrap > 受理时间
            	<%//added by tangosng 20110118 排序
            		if ("begin_date".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('begin_date','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('begin_date','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('begin_date','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>            
            <th align="center" class="blue" width="8%" nowrap > 挂机时间
            	<%//added by tangosng 20110118 排序
            		if ("end_date".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('end_date','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('end_date','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('end_date','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>            
            <th align="center" class="blue" width="8%" nowrap > 受理时长
            	<%//added by tangosng 20110118 排序
            		if ("accept_long".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('accept_long','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('accept_long','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('accept_long','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>            
            <th align="center" class="blue" width="8%" nowrap > 受理方式
            	<%//added by tangosng 20110118 排序
            		if ("acceptid".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('acceptid','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('acceptid','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('acceptid','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>            
            <th align="center" class="blue" width="8%" nowrap > 挂机方 </th>
            <th align="center" class="blue" width="8%" nowrap > 客户满意度
            	<%//added by tangosng 20110118 排序
            		if ("statisfy_code".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('statisfy_code','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('statisfy_code','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('statisfy_code','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>           
            <th align="center" class="blue" width="8%" nowrap > 来电原因</th>            
            <th align="center" class="blue" width="8%" nowrap > 有效性</th>            
            <th align="center" class="blue" width="8%" nowrap > 是否密码验证</th>            
            <th align="center" class="blue" width="8%" nowrap > 是否质检
            	<%//added by tangosng 20110118 排序
            		if ("qc_flag".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('qc_flag','asc')\" alt=\"点击升序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"parent.queryFrame.submitInputCheck('qc_flag','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"parent.queryFrame.submitInputCheck('qc_flag','desc')\" alt=\"点击降序排列\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>            
           	<!-- <th align="center" class="blue" width="8%" > 是否使用放音</th>-->
            <th align="center" class="blue" width="8%" nowrap > 质检员工号</th>            
            <th align="center" class="blue" width="8%" nowrap > 服务语种</th>
            <th align="center" class="blue" width="8%" nowrap > 录音听取标志 </th>            
            <th align="center" class="blue" width="8%" nowrap > 呼叫轨迹</th>            
            <!--<th align="center" class="blue" width="8%" nowrap > 是否他机验证</th>-->
            <th align="center" class="blue" width="8%" nowrap > 备注</th>
            <th align="center" class="blue" width="8%" nowrap > 转接备注</th>            
            <th align="center" class="blue" width="8%" nowrap > 技能队列</th>
   
          </tr>

          <%
           //add by hanjc20090731 从内存中读取正在通话的接续记录---begin---
            int m=0;
//System.out.println("dataRows:"+dataRows.length);
            if(dataRows.length>0){
            		upatedcallcallpage = DCallCacheManager.getInstance().getValue(dataRows[0][0]);

            }
            if(upatedcallcallpage != null){
               m=1;
               //以下是从内存中取第一条
               String accept=upatedcallcallpage.getAcceptid();
               String acceptName="人工";
               if(accept.equals("0"))
               {
               acceptName="人工";
               }
               else if(accept.equals("7"))
               {
               acceptName="呼出";
               }
                else if(accept.equals("9"))
               {
               acceptName="内部呼叫";
               }
               else if(accept.equals("13"))
               {
               acceptName="未受理";
               }
               else if(accept.equals("15"))
               {
               acceptName="内部求助";
               }

              //zengzq add 20090916
               String tmptdClass="blue";

            %>
            <!--zengzq add 20090916 -->
            <tr onClick="changeColor('<%=tmptdClass%>',this);"  >
              <script>
              if(tempBool=='true'){
             		document.write('<td align="center" class="tmptdClass">');
             	}
             	document.write('<input type="checkbox" name="saveBox" style="width:20px;" value="<%=upatedcallcallpage.getContact_id()%>" />');
             	
             	if(true){
             		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=upatedcallcallpage.getContact_id()%>\',\'<%=upatedcallcallpage.getAccept_login_no()%>\');return false;" alt="听取语音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">&nbsp;');
             	}             	
               if(checkRole(K171B_RolesArr)==true){
             		document.write('<img style="cursor:hand" onclick="getCallDetail(\'<%=upatedcallcallpage.getContact_id()%>\',\'<%=start_date%>\');return false;" alt="显示该通话的详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
             	}
             	//alert(11);
             	 //alert(checkRole(K171M_RolesArr)+"**");
             	if(checkRole(K171M_RolesArr)==true){
             		document.write('<img style="cursor:hand" onclick="keepRec(\'<%=upatedcallcallpage.getContact_id()%>\',\'<%=upatedcallcallpage.getAccept_login_no()%>\')" alt="另存录音到本地" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/3.gif" width="16" height="16" align="absmiddle">&nbsp;');
             	}
             	if(checkRole(K171D_RolesArr)==true&&1==2){ //1==2屏蔽掉该图标
             		document.write('<img style="cursor:hand" onclick="showCallLoc()" alt="显示呼叫轨迹" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/11.gif" width="16" height="16" align="absmiddle">&nbsp;');
             	}
             	if(checkRole(K171E_RolesArr)==true){
             		document.write('<img style="cursor:hand" onclick="checkIsHavePlan(\'<%=upatedcallcallpage.getContact_id()%>\',1,\'<%=upatedcallcallpage.getAccept_login_no()%>\',\'通话中\',\'<%=start_date.substring(0, 6)%>\')" alt="计划内质检考评" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif" width="16" height="16" align="absmiddle">&nbsp;');
             	}
                if(checkRole(K171L_RolesArr)==true){
             		document.write('<img style="cursor:hand" onclick="planOutQua(\'<%=upatedcallcallpage.getContact_id()%>\',\'<%=upatedcallcallpage.getAccept_login_no()%>\',1,2,\'通话中\')" alt="计划外质检考评(多次)" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/6.gif" width="16" height="16" align="absmiddle">&nbsp;');
             	}
                if(checkRole(K171F_RolesArr)==true){
             		document.write('<img style="cursor:hand" onclick="planOutCheckQua(\'<%=upatedcallcallpage.getContact_id()%>\',\'<%=upatedcallcallpage.getAccept_login_no()%>\',\'通话中\',\'<%=start_date.substring(0, 6)%>\')" alt="计划外质检考评(单次)" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/9.gif" width="16" height="16" align="absmiddle">&nbsp;');
             	}
             	if(checkRole(K171G_RolesArr)==true&&1==2){ //1==2屏蔽掉该图标
             		document.write('<img style="cursor:hand" onclick="keepRecToSer()" alt="转存录音到服务器" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/6.gif" width="16" height="16" align="absmiddle">&nbsp;');
             	}
             	if(checkRole(K171H_RolesArr)==true&&1==2){ //1==2屏蔽掉该图标
             		document.write('<img style="cursor:hand" onclick="getWorkInfo()" alt="查看对应工单信息" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/10.gif" width="16" height="16" align="absmiddle">');
             	}
               if(tempBool=='true'){
             		document.write('</td>');
             	}
             </script>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=upatedcallcallpage.getContact_id()%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(dataRows[0][4].length()!=0)?dataRows[0][4]:"&nbsp;"%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(dataRows[0][5].length()!=0)?dataRows[0][5]:"&nbsp;"%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(dataRows[0][6].length()!=0)?dataRows[0][6]:"&nbsp;"%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(dataRows[0][9].length()!=0)?dataRows[0][9]:"&nbsp;"%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(dataRows[0][2].length()!=0)?dataRows[0][2]:"&nbsp;"%></td>
             <!-- 加上的客户归属 by libin 2009/04/27 -->
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(dataRows[0][24].length()!=0)?dataRows[0][24]:"&nbsp;"%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(dataRows[0][3].length()!=0)?dataRows[0][3]:"&nbsp;"%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(dataRows[0][25].length()!=0)?dataRows[0][25]:"&nbsp;"%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(dataRows[0][7].length()!=0)?dataRows[0][7]:"&nbsp;"%></td> 
             <td align="center" class="<%=tmptdClass%>" nowrap > &nbsp; </td>
             <td align="center" class="<%=tmptdClass%>" nowrap > &nbsp; </td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(dataRows[0][1].length()!=0)?dataRows[0][1]:"&nbsp;"%></td> 
             <td align="center" class="<%=tmptdClass%>" nowrap > &nbsp; </td>
             <td align="center" class="<%=tmptdClass%>" nowrap > 未处理</td>
             <td align="left" class="<%=tmptdClass%>" nowrap > <%=(upatedcallcallpage.getCallcausedescs()==null)?"&nbsp;":upatedcallcallpage.getCallcausedescs()%></td>
             <!-- 判断受理来话有效性-->
             <td align="center" class="<%=tmptdClass%>" nowrap > &nbsp; </td>
             <td align="center" class="<%=tmptdClass%>" nowrap > <%=getCodeName(upatedcallcallpage.getVertify_passwd_flag())%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap >未质检</td>
             <td align="center" class="<%=tmptdClass%>" nowrap > &nbsp; </td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(dataRows[0][13].length()!=0)?dataRows[0][13]:"&nbsp;"%></td> 
             <td align="center" class="<%=tmptdClass%>" nowrap >未听</td>
             <!--添加呼叫轨迹数据-->
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=upatedcallcallpage.getCalltrack() == null ? "nbsp;" : upatedcallcallpage.getCalltrack()%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(upatedcallcallpage.getBak()==null)?"&nbsp;":upatedcallcallpage.getBak()%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(upatedcallcallpage.getTransfer_bak()==null)?"&nbsp;":upatedcallcallpage.getTransfer_bak()%></td>
             <td align="center" class="<%=tmptdClass%>" nowrap ><%=(upatedcallcallpage.getSkill_quence()==null)?"&nbsp;":upatedcallcallpage.getSkill_quence()%></td>
          </tr>
            <%
            }
            	String tdClass="blue";
              for (int i=0+m; i < dataRows.length; i++ ) {
          	 	//add by hanjc20090731 从内存中读取正在通话的接续记录---end---
                  %>
	          <tr onClick="changeColor('<%=tdClass%>',this);"  >

             <script>
             	if(tempBool=='true'){
             		document.write('<td align="center" class="<%=tdClass%>"  >');
             	}
             	document.write('<input type="checkbox" name="saveBox" style="width:20px;" value="<%=dataRows[i][0]%>" />');
             
             	if(true){

             		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][22]%>\');return false;" alt="听取语音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">&nbsp;');
	             	/*中测用,测试完毕请删除 add by mixh 20090410 begin */
	             	//document.write('<img style="cursor:hand" onclick="makeSign();" alt="标记该流水" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/flag_blue.gif" width="16" height="16" align="absmiddle">&nbsp;');
	               /*中测用,测试完毕请删除 add by mixh 20090410 end */
             	}
               if(checkRole(K171B_RolesArr)==true){
             		document.write('<img style="cursor:hand" onclick="getCallDetail(\'<%=dataRows[i][0]%>\',\'<%=start_date%>\');return false;" alt="显示该通话的详细情况" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');
             	}
             	//alert(checkRole(K171M_RolesArr));
             	if(checkRole(K171M_RolesArr)==true){
             		document.write('<img style="cursor:hand" onclick="keepRec(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][22]%>\')" alt="另存录音到本地" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/3.gif" width="16" height="16" align="absmiddle">&nbsp;');
             	}
             	if(checkRole(K171D_RolesArr)==true&&1==2){ //1==2屏蔽掉该图标
             		document.write('<img style="cursor:hand" onclick="showCallLoc()" alt="显示呼叫轨迹" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/11.gif" width="16" height="16" align="absmiddle">&nbsp;');
             	}
             	if(checkRole(K171E_RolesArr)==true){
             		document.write('<img style="cursor:hand" onclick="checkIsHavePlan(\'<%=dataRows[i][0]%>\',1,\'<%=dataRows[i][22]%>\',\'<%=dataRows[i][11]%>\',\'<%=start_date.substring(0, 6)%>\')" alt="计划内质检考评" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/5.gif" width="16" height="16" align="absmiddle">&nbsp;');
             	}
             	if(checkRole(K171L_RolesArr)==true){
             		document.write('<img style="cursor:hand" onclick="planOutQua(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][22]%>\',1,2)" alt="计划外质检考评(多次)" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/6.gif" width="16" height="16" align="absmiddle">&nbsp;');
             	}

                if(checkRole(K171F_RolesArr)==true||1==1){
             		document.write('<img style="cursor:hand" onclick="planOutCheckQua(\'<%=dataRows[i][0]%>\',\'<%=dataRows[i][22]%>\',\'<%=dataRows[i][11]%>\',\'<%=start_date.substring(0, 6)%>\')" alt="计划外质检考评(单次)" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/9.gif" width="16" height="16" align="absmiddle">&nbsp;');
             	}


             	if(checkRole(K171G_RolesArr)==true&&1==2){ //1==2屏蔽掉该图标
             		document.write('<img style="cursor:hand" onclick="keepRecToSer()" alt="转存录音到服务器" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/6.gif" width="16" height="16" align="absmiddle">&nbsp;');
             	}
             	if(checkRole(K171H_RolesArr)==true&&1==2){ //1==2屏蔽掉该图标
             		document.write('<img style="cursor:hand" onclick="getWorkInfo()" alt="查看对应工单信息" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/10.gif" width="16" height="16" align="absmiddle">');
             	}
               if(tempBool=='true'){
             		document.write('</td>');
             	}
             </script>
             <!--修改前台字段展示顺序 by tangxlc 2011/06/21 -->   
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td> 
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
             <!-- 加上的客户归属 by libin 2009/04/27 -->
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][24].length()!=0)?dataRows[i][24]:"&nbsp;"%></td>
             <!-- added by tangsong 20100528 加上客户级别 -->
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][25].length()!=0)?dataRows[i][25]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][23].length()!=0)?dataRows[i][23]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td> 
             <td align="center" class="<%=tdClass%>" nowrap ><%
               if(dataRows[i][10].trim().length()!=0)
               {
                   out.print(dataRows[i][10]);
               }else 
                   {
                    out.print("其他");
                   } 
                          %></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][12].length()!=0)?dataRows[i][12]:"&nbsp;" %></td>
             <td align="left" class="<%=tdClass%>" nowrap ><%=(dataRows[i][14].length()!=0)?dataRows[i][14]:"&nbsp;"%></td>
             <!-- 判断受理来话有效性-->
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][8].length()!=0&&Integer.parseInt(dataRows[i][8])>=3)?"有效":"无效"%></td>
				<%
					if (!isHWY) 
					{
				%>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][19].length()!=0)?dataRows[i][19]:"&nbsp;"%></td>
				<%
					} 
					else 
					{
				%>
             <td align="center" class="<%=tdClass%>" nowrap >***</td>
             <td align="center" class="<%=tdClass%>" nowrap >******</td>
        <%
        	}
       	%>
				<%
					if (!isHWY) 
					{
	         	//added by tangsong 20101220 "已质检"以红色显示
	         	String checkedStyle = "";
	         	if ("已质检".equals(dataRows[i][11])) 
	         	{
	         		checkedStyle = "style='color:red'";
	         	}
        %>
             <td align="center" class="<%=tdClass%>" <%=checkedStyle%> nowrap ><%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>
				<%
					} 
					else 
					{
				%>
						 <td align="center" class="<%=tdClass%>" nowrap >***</td>
        <%
        	}
       	%>
       	     <td align="center" class="<%=tdClass%>" nowrap ><%=((dataRows[i][17].length()!=0)?dataRows[i][17]:"&nbsp;")%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][13].length()!=0)?dataRows[i][13]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][15].length()!=0)?dataRows[i][15]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][26].length()!=0)?dataRows[i][26]:"&nbsp;"%></td>
             <!--<td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][19].length()!=0)?dataRows[i][18]:"&nbsp;"%></td>-->
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][20].length()!=0)?dataRows[i][20]:"&nbsp;"%></td>
             <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][21].length()!=0)?dataRows[i][21]:"&nbsp;"%></td>
						 <td align="center" class="<%=tdClass%>" nowrap ><%=(dataRows[i][27].length()!=0)?dataRows[i][27]:"&nbsp;"%></td>            
             </tr>
             <% }//for循环结尾括号%>

    <tr >
      <td align="right" colspan="28" class="Blue">
        <%if(pageCount!=0){%>
        第<%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
        <%} else{%>
        <font color="orange">当前记录为空！</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#"   onClick="doLoad('first');return false;">首页</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">上一页</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">下一页</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">尾页</a>&nbsp;
        <!--hucw 20100828,不需要链接<a>快速选择</a>-->
        <span>快速选择</span>
        <select onchange="jumpToPage(this.value);" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
      </select style="height:18px">&nbsp;&nbsp;
        <!--hucw 20100828,不需要链接<a>快速跳转</a>-->
        <span>快速跳转</span>
        <input id="thePage1" name="thePage1" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>
        <a href="#" onClick="jumpToPage('jumpToPage1');return false;">
        	<font face=粗体>GO</font>
        </a>
        <%}%>
      </td>
    </tr>
  </table>

</div>
<script type="text/javascript">
var rowCount="<%=rowCount%>"
if(rowCount>10000){
		parent.frames['queryFrame'].document.all.exportAll.disabled="disabled";
}else{
		parent.frames['queryFrame'].document.all.exportAll.disabled=false;
}
	function chooseAll(obj) {
	if (obj.checked) {
		$("input[name='saveBox']").attr("checked","checked");
	} else {
		$("input[name='saveBox']").attr("checked","");
	}
}
function download(){
			parent.frames['queryFrame'].document.all.downloadAll.disabled="disabled";
	//alert("fileId"+fileId);
			//var kf_login_no=window.opener.top.cCcommonTool.getWorkNo();
			var contact_ids = "";
			var objs = document.getElementsByName("saveBox");
			for (var i=0;i<objs.length;i++) {	
				if (objs[i].checked) {
					  //获取流水
					  contact_ids=objs[i].value+","+contact_ids;
				}
			}
			
			var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_downloadInfo.jsp","请稍候......");
			mypacket.data.add("contact_ids",contact_ids);
		  core.ajax.sendPacket(mypacket,doProcess,true);
			mypacket=null;
	}
	function doProcess(packet){
				var pathName = packet.data.findValueByName("pathName");
				//alert(pathName);
				parent.frames['queryFrame'].document.all.downloadAll.disabled=false;
			 	//打包下载了。
				var opener = openWinMid("k170_download_2.jsp","下载文件",200,300);
				opener.location.href=pathName;
	}
 //居中打开窗口
	function openWinMid(url,name,iHeight,iWidth)
		{
		  //var url; //转向网页的地址;
		  //var name; //网页名称，可为;
		  //var iWidth; //弹出窗口的宽度;
		  //var iHeight; //弹出窗口的高度;
		  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
		  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
		  var handler = window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
			return handler;
		}
</script>

	</body>
</html>
