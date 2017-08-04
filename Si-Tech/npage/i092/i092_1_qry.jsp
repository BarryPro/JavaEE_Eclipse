<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
      String opCode = "i092";
	  String opName = "强制预拆";
	  String s_phone=request.getParameter("s_phone");
	  String workno = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  //开始 结束
	  	
	  String ret_val[][];
	  String ret_val_new[][];
	  String[] inParas2 = new String[2];
	  inParas2[0]="select c.region_name,d.district_name,to_char(b.phone_no),to_char(b.run_time,'YYYYMMDD hh24:mi:ss'),to_char(floor(sysdate-b.run_time)),e.pay_name,to_char(a.prepay_fee),to_char(a.id_no) from  dcustbalance a,dcustmsg b,sregioncode c,sdiscode d,spaytype e where a.id_no=b.id_no and substr(b.belong_code,0,2) = c.region_code and c.region_code = d.region_code and substr(b.belong_code,3,2)=d.district_code and b.phone_no=:s_phone and a.pay_type = e.pay_type and c.region_code=:s_region_code and substr(b.run_code,2,1)='J'";
	  inParas2[1]="s_phone="+s_phone+",s_region_code="+regionCode;
 
%>
<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="8">
		    <wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
<wtc:array id="mainInfo1"  scope="end"/>  

<%
		String errCode = retCode2;
		String errMsg = retMsg2;
	 
		String[][] result1  = null ;
 
		result1 = mainInfo1; 
		if(retCode2.equals("0")||retCode2.equals("000000"))
		{
			System.out.println("CCCCCCCCCCCCCCCCCCCCCCCCC 成功");
			%>
				 
				<html xmlns="http://www.w3.org/1999/xhtml">
				<HEAD><TITLE>查询结果</TITLE>
				</HEAD>
				<body>


				<FORM method=post name="frm1508_2">
				<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">查询结果</div>
				</div>

					  <table cellspacing="0" id = "PrintA">
								<tr> 
									<th>地市</th>
									<th>区县</th>
									<th>手机号码</th>
									<th>进入预拆时间</th>
									<th>在预拆状态停留时长(天)</th>
									<th>专款名称</th>
									<th>专款金额</th>
									<th>操作</th>
							<%
								for(int i=0;i<result1.length;i++)
								{
									%>
										<tr>
											<td><%=result1[i][0]%></td>
											<td><%=result1[i][1]%></td>
											<td><%=result1[i][2]%></td>
											<td><%=result1[i][3]%></td>
											<td><%=result1[i][4]%></td>
											<td><%=result1[i][5]%></td>
											<td><%=result1[i][6]%></td>
											<td><input type="button" value="删除" onclick="deletes('<%=result1[i][7]%>')"  class="b_foot"></td>
										</tr>
									<%
								}
							%>
						  <tr id="footer"> 
							<td colspan="9">
							  <input class="b_foot" name=back onClick="window.location = 'i092_1.jsp' " type=button value=返回>
							  <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
							</td>
						  </tr>
						  
					  </table>
					 
					
						
							
						

				<%@ include file="/npage/include/footer.jsp" %>
				</FORM>
				</BODY></HTML>
			<%
		}
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("查询结果为空！");
					window.location.href="i092_1.jsp";
				</script>
			<%
		}
%>	 
<script language="javascript">
	function deletes(id_no)
	{
		//alert(id_no);
		var url="i092_Cfm.jsp?id_arrays="+id_no+"&s_flag=1";
		var url_new =url;//URLencode(url);
		//alert(url_new);
		document.frm1508_2.action=url_new;
		var	prtFlag = rdShowConfirmDialog("是否确定本次操作？");
		if (prtFlag==1)
		{
			//alert("bizcodeArrays is "+bizcodeArrays);
			document.frm1508_2.submit();  
		}
		else
		{
			return false;
		}
	}
</script> 


