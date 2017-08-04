<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String opCode="zg87";
	String opName="积分计算要素管理";	
 
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	String contextPath = request.getContextPath();
	String pass = (String)session.getAttribute("password");
	 
	String inParas2[] = new String[2]; 
	inParas2[0]="select to_char(code_id),code_name from ACT_MARKBRAND_CONF ";

	//服务入参 
	String dsxx = request.getParameter("dsxx");
	String ppxx = request.getParameter("ppxx");
	String jflx = request.getParameter("jflx");
	String jsys = request.getParameter("jsys");
	String sxzt = "";//request.getParameter("sxzt");
	String beizhu = "";//request.getParameter("beizhu");
	String jfjhmc = request.getParameter("jfjhmc");
	String wl_max = request.getParameter("wl_max");
	String wl_min = request.getParameter("wl_min");
	String jfbl = "";//request.getParameter("jfbl");
	String jsysz =  request.getParameter("jsysz");
	String shengxiao_time = "";//request.getParameter("shengxiao_time");
	//[2015/04/11
	//shengxiao_time=shengxiao_time.substring(0,4)+shengxiao_time.substring(5,7)+shengxiao_time.substring(8,10);
	String shixiao_time = "";//request.getParameter("shixiao_time");
	//shixiao_time=shixiao_time.substring(0,4)+shixiao_time.substring(5,7)+shixiao_time.substring(8,10);
	System.out.println("AAAAAAAAAAAAAAAAAA dsxx is "+dsxx+" and sxzt is "+sxzt);

	String paraAray[] = new String[16];
	paraAray[0]="z";
	paraAray[1]=dsxx;
	paraAray[2]=ppxx;
	paraAray[3]=jflx;
	paraAray[4]=jsys;
	paraAray[5]=jsysz;
	paraAray[7]=wl_max;
	paraAray[6]=wl_min;
	paraAray[8]=jfbl;
	paraAray[9]=shengxiao_time;
	paraAray[10]=shixiao_time;
	paraAray[11]="";//更新时间
	paraAray[12]=workNo;
	paraAray[13]=sxzt;
	paraAray[14]=beizhu;
	paraAray[15]=jfjhmc;
%>

<wtc:service name="TlsPubSelBoss" retcode="sRedCode" retmsg="sRedMsg" outnum="2">
    <wtc:param value="<%=inParas2[0]%>"/>  
 
</wtc:service>
<wtc:array id="red_val" scope="end" />

<wtc:service name="sCompConf" routerKey="region" routerValue="<%=regionCode%>" retcode="g089CfmCode" retmsg="g089CfmMsg" outnum="17" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/>
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/>
    <wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="<%=paraAray[9]%>"/>
	<wtc:param value="<%=paraAray[10]%>"/>
	<wtc:param value="<%=paraAray[11]%>"/>
	<wtc:param value="<%=paraAray[12]%>"/>
	<wtc:param value="<%=paraAray[13]%>"/>
	<wtc:param value="<%=paraAray[14]%>"/>
	<wtc:param value="<%=paraAray[15]%>"/>
    
</wtc:service>
<wtc:array id="r_return_code" scope="end" start="0"  length="2" />
<wtc:array id="r_return_detail" scope="end" start="2"  length="15" />
<%
	String retCode= g089CfmCode;
	String retMsg = g089CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
%>
 
<%
   

	String errMsg = g089CfmMsg;
	if ( g089CfmCode.equals("000000"))
	{
 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>查询结果</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">查询结果展示</div>
</div>

      <table cellspacing="0" id = "PrintA">
                <tr> 
             
                  <th>品牌信息</th> 
				  <th>积分类型</th>
				  <th>计算要素</th>
				  <th>计算要素值</th>
				  <th>最小值</th>
				  <th>最大值</th>
				  <th>积分倍率</th>
				  <th>生效时间</th>
				  <th>失效时间</th>
				 
				  <th>生效状态</th>
				 
                </tr>
<%
				for(int i=0;i<r_return_detail.length;i++)
				{
					%>
						<tr>
							 
							<td>
								<select name="ppxx" id="ppxxid">
									<%for(int j=0; j<red_val.length; j++){
								if(red_val[j][0].equals(r_return_detail[i][2])){
									%>
									<option value="<%=red_val[j][0]%>" selected >
						
						<%=red_val[j][0]%>--><%=red_val[j][1]%></option>
									<%
								}else{
									%>
									<option value="<%=red_val[j][0]%>">
						
									<%=red_val[j][0]%>--><%=red_val[j][1]%></option>
									<%
									}
							%>
							
						
						<%}%> 	
								</select>
							</td>
							<td><%=r_return_detail[i][3]%></td>
							<td><%=r_return_detail[i][4]%></td>
							<td><%=r_return_detail[i][5]%></td>
							<td><%=r_return_detail[i][6]%></td>
							<td><%=r_return_detail[i][7]%></td>
							<td><input type="text" name="jfbl1" value="<%=r_return_detail[i][8]%>"> </td>
							<td>
							<input type="text" name="shengxiao_time" id="shengxiao_timeid" size="18" value="<%=r_return_detail[i][9]%>"/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(shengxiao_time);return false' alt=弹出日历下拉菜单 align=absMiddle readonly></td>
							</td>
							
							<td>
							<input type="text" name="shixiao_time" id="shixiao_timeid" size="18" value="<%=r_return_detail[i][10]%>"/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(shixiao_time);return false' alt=弹出日历下拉菜单 align=absMiddle readonly></td>
							</td>
							<td>
								<select name="sxzt" id="sxztid">
									<%
										String s_zt="";
										if(r_return_detail[i][13]=="1" ||r_return_detail[i][13].equals("1"))
										{
											s_zt="生效";
										}
										else
										{
											s_zt="失效";
										}
									%>
									<option value="<%=r_return_detail[i][13]%>" selected><%=s_zt%></option>	
									<%
										if(r_return_detail[i][13]=="1" ||r_return_detail[i][13].equals("1") )
										{
											%>
											<option value="0">失效</option>
											<%
										}
										else
										{
											%>
											<option value="1">生效</option>
											<%
										}			
									%>
								</select>
							</td>
					  
 
						</tr>
					<%
				}

%>

         
          <tr id="footer"> 
      	    <td colspan="15">
    	      <input class="b_foot" name=back onClick="window.location = 'zg87_update.jsp' " type=button value=返回>
			  <input class="b_foot" name=back onClick="dels()" type=button value=修改>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
	 
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
<script language="javascript">
	function fPopUpCalendarDlg(ctrlobj)
	{
		showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
		showy = event.screenY - event.offsetY + 18; // + deltaY;
		newWINwidth = 210 + 4 + 18;
		retval = window.showModalDialog("/js/common/date/CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
		if(retval != null)
		{
			ctrlobj.value = retval;
		}
		else
		{
			//alert("canceled");
		}
	}
	function dels()
	{
			var	prtFlag = rdShowConfirmDialog("是否确定修改该条记录？");
		if (prtFlag==1)
		{
			var actions = "zg87_update_cfm.jsp?dsxx="+"<%=dsxx%>"+"&jflx="+"<%=jflx%>"+"&jsys="+"<%=jsys%>"+"&jfjhmc="+"<%=jfjhmc%>"+"&wl_max="+"<%=wl_max%>"+"&wl_min="+"<%=wl_min%>"+"&jfbl="+"<%=jfbl%>"+"&jsysz="+"<%=jsysz%>";
			document.all.frm1508_2.action=actions;
			//alert(actions);
			document.all.frm1508_2.submit();
			document.all.frm1508_2.action=actions;
			//alert(actions);
			document.all.frm1508_2.submit();
		}
		else
		{
			return false;
		}
			
	}	
</script>        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("增加失败: <%=retMsg%>,<%=g089CfmCode%>",0);
	window.location="zg87_del.jsp?opCode=g089&opName=集团红黑名单管理";
	</script>
<%}
%>
