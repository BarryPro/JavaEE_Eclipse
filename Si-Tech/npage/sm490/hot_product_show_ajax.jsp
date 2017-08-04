<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%

	String siteId =(String)session.getAttribute("siteId");
	String workNo=(String)session.getAttribute("workNo");//操作员登录工号
	
	System.out.println("====siteId=="+siteId);	
	System.out.println("====workNo=="+workNo);	
	String[][] productInfo=null; 
	int    num=0;
	int    num2=9;
%>
<wtc:utype name="sGetHotBOffer" id="retVal2" scope="end">
				<wtc:uparam value="<%=siteId%>" type="string" />
				<wtc:uparam value="<%=workNo%>" type="string" />
</wtc:utype>
<%
StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal2,1,"2",logBuffer);
		System.out.println(logBuffer.toString());
		String retCode2=retVal2.getValue(0);
		String retMsg2 =retVal2.getValue(1);
System.out.println("===retMsg2==="+retMsg2);		
		/*if(retCode2.equals("0"))
		{*/
			num= retVal2.getSize("2");
			if(num>0&&retVal2.getSize("2.0")>=num2) num2=retVal2.getSize("2.0");
			productInfo=new String[num][num2];
			for(int i=0;i<num;i++)
			{		
				for(int j=0;j<num2;j++)
				{//System.out.println(i+"-----------------------------"+j);
					productInfo[i][j]=retVal2.getValue("2."+i+"."+j);
				}
			}
%>		
<script type="text/javascript">
    $(document).ready(function(){
     $("#ta tr:even").addClass("double");
    });
</script>
 		
		<table id="ta" cellspacing=0>
					<tr>
						<th nowrap>选择</th>
						<th nowrap>销售品代码</th>
						<th nowrap>销售品名称</th>
						<th nowrap>生效时间</th>
						<th nowrap>销售品描述</th>
						<th nowrap>定价计划</th>
					</tr>	
<%
			for(int i=0;i<num;i++)
			{
						String proType=WtcUtil.repNull(productInfo[i][4]);
						String effecttime=WtcUtil.repNull(productInfo[i][11]);
						effecttime=effecttime.replaceAll(" ", "").replaceAll(":", "").replaceAll("-", "");
						if(effecttime.length()>8) effecttime=effecttime.substring(0,8);
						
						if("3".equals(proType)){
							effecttime="自定义";
						}
%>				    	
				
					<tr>
						<td><input type="radio" name="proRad" value="<%=productInfo[i][0]+","+productInfo[i][1]+","+productInfo[i][2] +","+productInfo[i][4]+","+productInfo[i][6]+","+productInfo[i][7]+","+productInfo[i][11]+","+productInfo[i][10]+",,"+productInfo[i][3] %>" ></td>
						<td><%=productInfo[i][0]%></td>
						<td><%=productInfo[i][2]%></td>
						<td><%=effecttime%></td>
						<td><%=productInfo[i][3]%></td>
						<td><input type="button" class="b_text" value="查看" onclick="window.showModalDialog('showPrice.jsp?OFFER_ID=<%=productInfo[i][0]%>','dialogHeight=700px','dialogWidth=650px','help=no','status=no')" /></td>
					</tr>
<%
			}
%>				
			</table>
				