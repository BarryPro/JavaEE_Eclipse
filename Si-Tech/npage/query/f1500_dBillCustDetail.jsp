<%
/********************
 version v2.0
开发商: si-tech
	*
	*update:zhanghonga@2008-08-13 页面改造,修改样式
	*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%
	String opCode = "1500";
  String opName = "详细优惠信息";
  String iChnSource = "01";
  String regionCode = (String)session.getAttribute("regCode");	
	String id_no= request.getParameter("idNo");
	String work_no=request.getParameter("workNo");
	String dNopass = (String)session.getAttribute("password");
	String work_name=request.getParameter("workName");
	String table_str=id_no.substring(id_no.length()-1,id_no.length());
	String phone_no = request.getParameter("phoneNo");
	String PrintAccept = getMaxAccept();
	
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");

	/*
	String sql_str="select a.mode_code,b.mode_name,decode(a.mode_flag,'0','主资费','1','附加','2','可选'),"
	+" decode(a.detail_type,'0','批价','1','月租','2','帐单优惠','3','通话类型优惠','4','特服优惠','a','特服绑定' ), "
	+" trim(c.note),to_char(a.begin_time,'YYYYMMDD'),to_char(a.end_time,'YYYYMMDD'),"
	+" decode(a.mode_status,'Y','开通','N','取消'),a.fav_order,a.op_code,to_char(op_time,'YYYYMMDD HH24 MI SS'),a.login_no "
	+" from dBillCustDetail" + table_str + " a, sBillModeCode b, sBillModeDetail c "
	+" where a.region_code=b.region_code and a.mode_code=b.mode_code and a.region_code=c.region_code and a.mode_time='Y' "
	+" and a.mode_code=c.mode_code and b.mode_code=c.mode_code and a.detail_type=c.detail_type and a.detail_code=c.detail_code "
	+" and a.id_no=" +id_no+ " order by substr(a.mode_code,3,1),to_char(a.begin_time,'YYYYMMDD')";
	*/
	/**
	String sql_str="SELECT   a.offer_id,b.offer_name,decode(b.offer_type,'10','主资费','20','套餐销售品','30','组合销售品','40','可选套餐'), "
		+" to_char(a.eff_date,'YYYYMMDD'),to_char(a.exp_date,'YYYYMMDD'), "
		+" decode(sign(a.exp_date-sysdate),1,'有效',-1,'已取销','归档'),a.priority,to_char(state_date,'YYYYMMDD HH24:MI:SS'),a.HANDLE_LOGIN_NO,b.offer_comments"
        +" FROM product_offer_instance a, product_offer b "
        +" WHERE a.offer_id = b.offer_id AND a.serv_id = " +id_no+ " "
		+" ORDER BY a.eff_date ";
        
	System.out.println("sql_str  :   " + sql_str);
	**/
%>

<wtc:service name="s1500_prodinst" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="19">
		<wtc:param value="<%=PrintAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=work_no%>" />
		<wtc:param value="<%=dNopass%>" />
		<wtc:param value="<%=phone_no%>" />
		<wtc:param value="" />
		<wtc:param value="<%=id_no%>" />
	</wtc:service>
	<wtc:array id="result11" start="0" length="3" scope="end"/>
	<wtc:array id="result22" start="3" length="16" scope="end"/>


<%
	int iretCode=999999; 
	System.out.println("gaopengSeeLog1500---result11.length==="+result11.length);
	System.out.println("gaopengSeeLog1500---result22.length==="+result22.length);
	System.out.println("gaopengSeeLog1500---retCode1==="+retCode1);
	System.out.println("gaopengSeeLog1500---retMsg1==="+retMsg1);
	if(retCode1!=null&&!"".equals(retCode1)){
		iretCode=Integer.parseInt(retCode1);
	}
	if(iretCode!=0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("服务未能成功,服务代码:<%=retCode1%><br>服务信息:<%=retMsg1%>!");
	</script>
<%
		return;
	}else if (result11==null||result11.length==0){
%>
		<script language="JavaScript">
			rdShowMessageDialog("没有符合条件的数据,详细优惠信息为空!");
			history.go(-1);
		</script>
<%	
	return;
	}
	
	//al = Wrapper.s1500_BillCust(work_no,phone_no,id_no);
%>
	<wtc:service name="s1500_dBillCust" routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode1" retmsg="retMsg1" outnum="7" >
	<wtc:param  value=""/>
  <wtc:param  value="01"/>
  <wtc:param  value="<%=opCode%>"/>
  <wtc:param  value="<%=work_no%>"/>
  <wtc:param  value="<%=password%>"/>
  <wtc:param  value="<%=phone_no%>"/>
  <wtc:param  value=""/>
	<wtc:param value="<%=id_no%>"/>
	</wtc:service>
	<wtc:array id="result1" start="0" length="2" scope="end"/>
	<wtc:array id="result2" start="2" length="5" scope="end"/>
<%		
	int valid = 0;
	 
	if( result1==null||result1.length==0||result2==null){
		valid = 1;
	}else{
		if( !result1[0][0].equals("000000") ){
			valid = 2;
		}else{
			valid = 0;
		}
	}
	if( valid == 1){
%>
		<script language="JavaScript">
			rdShowMessageDialog("系统错误，请与系统管理员联系，谢谢!!");
			history.go(-1);
		</script>	
<%
	}else if( valid == 2){
%>
		<script language="JavaScript">
			rdShowMessageDialog("业务错误！<br>服务代码:<%=result11[0][0]%><br>服务信息:<%=result11[0][1]%>");
			history.go(-1);
		</script>
<%
	}else{
%>
<HEAD><TITLE>详细优惠信息</TITLE>

	<script language="javascript">
		function updateMsg(rowId){
			var msgArr = new Array();
			<%
				for(int i = 0; i < result22.length; i++){
			%>
					msgArr[<%=i%>] = "<%=result22[i][9]%>";
			<%
				}
			%>
			$("#msgDiv").children("span").text(msgArr[rowId]);
		}
		
		$(document).ready(function(){
			var msgNode = $("#msgDiv").css("border","1px solid #999").width("260px")
                            .css("position","absolute").css("z-index","99")
                            .css("background-color","#dff6b3").css("padding","8");
            msgNode.hide();
        	var as = $("a");
        	as.css("cursor","hand").css("font-weight","600");
        	as.mouseover(function(event){
        		//获取当前准备显示的行数
	            var aNode = $(this);
	            aNode.css("color","#3366CC");
	            var divNode = aNode.parent();
	            sid = divNode.attr("rowId");
	            updateMsg(sid);
	            var myEvent = event || windows.event;
            	msgNode.css("left",myEvent.clientX + 8 + "px").css("top",myEvent.clientY + 8 + "px");
            	//浮动框显示
            	msgNode.show();
        	});
        	as.mouseout(function(){
        		var aNode = $(this);
	            aNode.css("font-weight","600").css("color","#333333");
            	msgNode.hide();
        	});
		});
	</script>
</HEAD>
<body>

<FORM method=post name="f1500_dBillCustDetail02">
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">详细优惠信息</div>
		</div>
	   <TABLE cellSpacing="0">
	     <TBODY>
	      <TR align="center">
	        <th>优惠代码</th>
	        <th>优惠名称</th>
	        <th>优惠类型1</th>
	        <th>开始时间</th>
	        <th>结束时间</th>                  
	        <th>状态</th>
	        <th>优惠顺序</th>
	        <th>操作时间</th>                  
	        <th>操作工号</th>
	        <th>操作渠道</th>
	        <th>流量是否结转</th>
	        <th>流量优先级</th>
	        <th>其他业务优先级</th>
	      </TR>
<%	      
		System.out.println("数量:  :   " + result11[0][2]);
		/*out.println("数量:  :   " + result11[0][2]);
		out.println("数量:  :   " + result11[0][0]);
		out.println("数量:  :   " + result11[0][1]);
		out.println("数量:  :   " + result22[0].length);
		*/
			for(int y=0;y<Integer.parseInt(result11[0][2]);y++){
			

%>
	    <tr align="center">
	    <%
	    	if(result22[y].length > 0){
	    		if(result22[y][5].trim().equals("有效"))
	    		{
	    %>
	    <td class="InputGrey">
	    	11-<div rowId="<%= y%>"><a><%= result22[y][0]%></a></div>
	    </td>
	    <td class="InputGrey">
	    	22-<div rowId="<%= y%>"><a><%= result22[y][1]	%></a></div>
	    </td>
	    <%
	    		}
	    	  else
	    	  {
	    	  
	    %>	
	    <td class="Grey">
	    	3<div rowId="<%= y%>"><a><%= result22[y][0]%></a></div>
	    </td>
	    <td class="Grey">
	    	4<div rowId="<%= y%>"><a><%= result22[y][1]%></a></div>
	    </td>
	    <%
	    		}  	
	    	}
	    %>
<%    	
				for(int j=2;j<result22[0].length ;j++)
				{	
				if(j==9) {
				 continue;
				}
				if(j==10) {
				System.out.println("资费优先级" + result22[y][j]);
				 continue;
				}				
				if(j==11) {
				 continue;
				}
				 	
					if(result22[y][5].trim().equals("有效"))
	    		{
%>
		  <td class="InputGrey">1a<%= result22[y][j]%>&nbsp;</td>
<%
					}
					else
					{
%>
		  <td class="Grey">b2<%= result22[y][j]%>&nbsp;</td>
<%		
					}		
					
					System.out.println("==========gaopengSeeLog1500====================result22["+y+"]["+j+"]" + result22[y][j]);		
				}
%>
	        </tr>
<%
	      }
        for (int i=0;i<result2.length;i++){%>
        
						<tr align="center">
						      <td>
                    <div align="center"><%=result2[i][0].trim()%></div>
                  </td>
                  <td>
                    <div align="center"><%=result2[i][1].trim()%></div>
                  </td>
                  <td>
                    <div align="center"></div>
                  </td>
                  <td>
                    <div align="center"></div>
                  </td>
                  <td>
                    <div align="center"></div>
                  </td>
                   <td>
                    <div align="center"><%=result2[i][2].trim()%></div>
                  </td>
                   <td>
                    <div align="center"><%=result2[i][3].trim()%></div>
                  </td>
                  <td>
                    <div align="center"></div>
                  </td>
                  <td>
                    <div align="center"></div>
                  </td>
                  <td>
                    <div align="center"></div>
                  </td>
                   <td>
                    <div align="center"><%=result2[i][4].trim()%></div>
                  </td>
			 					</tr>
		<%}%>
          </TBODY>
  		</TABLE>
      <font color="red">1.非GPRS资费优先级说明：“资费优先级先看第一位，数字越大优先级越高，如第一位相同取费率最低的批价，如费率相同再看第二位”;<br>
      2.GPRS资费优先级说明：数值越小优先级越高，优先级相同时取费率最低的批价;<br>3.预约失效的流量结转资费失效当月不结转。</font>
      <table cellspacing=0>
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onclick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
      	<div id="msgDiv">
	        资费说明：<span></span>
	    </div>
		</FORM>
		</BODY>
		<%@ include file="/npage/include/footer.jsp" %>
	</HTML>
<%
}
%>
